unit ConvertDBaseToSQLUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls, StdCtrls, ExtCtrls, FileCtrl, xpEdit, xpCheckBox,
  xpCombo, xpGroupBox, DBTables, DB, ADODB, xpButton, Menus, HotLog, SQLRemoteLogging;

type
  TfmConvertDBaseToSQL = class(TForm)
    gbx_DatabaseSettings: TxpGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cbxSQLDatabase: TxpComboBox;
    gbx_LoginParameters: TxpGroupBox;
    lb_SQLUser: TLabel;
    lb_SQLPassword: TLabel;
    cbUseSQLLogin: TxpCheckBox;
    edSQLUser: TxpEdit;
    edSQLPassword: TxpEdit;
    edSQLServer: TxpEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    lbxTables: TListBox;
    Panel5: TPanel;
    ProgressBar: TProgressBar;
    pnlStatus: TPanel;
    cbxSelectTableFilter: TxpComboBox;
    cbxDBaseDatabase: TxpComboBox;
    Label3: TLabel;
    cbCreateTableStructure: TxpCheckBox;
    Panel6: TPanel;
    btnLoad: TSpeedButton;
    btnSave: TSpeedButton;
    btnRun: TSpeedButton;
    Label4: TLabel;
    edUDLFileName: TxpEdit;
    btnLocateUDL: TxpButton;
    lbResults: TListBox;
    dlgUDLFileLocate: TOpenDialog;
    cbCombineToNY: TxpCheckBox;
    Label5: TLabel;
    edExtractFolder: TxpEdit;
    btnLocateExtractFolder: TxpButton;
    Label6: TLabel;
    edServerFolder: TxpEdit;
    dlgSaveIniFile: TSaveDialog;
    dlgLoadIniFile: TOpenDialog;
    btnLocateServerFolder: TxpButton;
    cbUseRemoteLogging: TxpCheckBox;
    edClientId: TxpEdit;
    Label7: TLabel;
    cbAutoInc: TxpCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure cbxDBaseDatabaseCloseUp(Sender: TObject);
    procedure btnLocateUDLClick(Sender: TObject);
    procedure btnLocateExtractFolderClick(Sender: TObject);
    procedure btnLocateServerFolderClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLoadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    bAutoRun, bCreateTables, bCombineToNY,
    bUseSQLLogin, bDeleteExtracts, bCancelled,
    bLoadDefaultsOnStartUp, bAutoInc : Boolean;
    sDefaultSet, sDBaseDatabaseName, sUDLFileName,
    sSQLPassword, sSQLUser, sServerName, sSQLDatabaseName,
    sLogFileLocation, sNotificationSettings : String;


    Procedure UpdateStatus(sStatus : String);
    Procedure LoadParameters;
    Procedure LoadDefaults(sDefaultSet : String);
    Procedure SaveDefaults(sDefaultSet : String);
    Procedure ExtractOneTable(    tbExtract : TTable;
                                  sDBaseDatabaseName : String;
                                  sTableName : String;
                                  sExtractFileName : String;
                                  bExtractMemosAsFiles : Boolean;
                                  bFirstLineIsHeaders : Boolean;
                                  bIncludeFieldTypes : Boolean;
                                  bCreateNewFile : Boolean;
                              var iMemoNumber : Integer);

    Procedure CreateOneTable(adoQuery : TADOQuery;
                             tbExtract : TTable;
                             sDBaseDatabaseName : String;
                             sTableName : String;
                             sSQLDatabaseName : String;
                             sExtractName : String);

    Procedure LoadOneTable(adoQuery : TADOQuery;
                           sTableName : String;
                           sSQLDatabaseName : String;
                           sExtractName : String);

    Procedure CopyOneTable(adoQuery : TADOQuery;
                           sSQLDatabaseName : String;
                           sSourceTable : String;
                           sDestTable : String;
                           bDropSourceTable : Boolean);

    Procedure AutoRun;

  end;

var
  GlblCurrentCommaDelimitedField : Integer;
  fmConvertDBaseToSQL: TfmConvertDBaseToSQL;
  sStartLogString, sFinishLogString : String;
  rlRemoteLog, rlEndRemoteLog : TRemoteLog;

const
  sSeparator = '|';
  sDefaultIniFileName = '\default.ini';

implementation

{$R *.dfm}

uses Utilities, Definitions;

{==========================================================}
Procedure TfmConvertDBaseToSQL.LoadParameters;

begin
    LoadIniFile(Self, sDefaultIniFileName, True, False);
end;

{==========================================================}
Procedure TfmConvertDBaseToSQL.LoadDefaults(sDefaultSet : String);

begin
end;  {LoadDefaults}

{==========================================================}
Procedure TfmConvertDBaseToSQL.SaveDefaults(sDefaultSet : String);

begin
end;  {SaveDefaults}

{===============================================================}
Procedure TfmConvertDBaseToSQL.btnLocateUDLClick(Sender: TObject);

begin
  If dlgUDLFileLocate.Execute
  then edUDLFileName.Text := dlgUDLFileLocate.FileName;

end;  {btnLocateUDLClick}

{==============================================================================}
Function GetADOConnectionString(bUseSQLLogin : Boolean;
                                sSQLPassword : String;
                                sSQLUser : String;
                                sServerName : String;
                                sDatabaseName : String) : String;

begin
  If bUseSQLLogin
    then Result := 'Provider=SQLNCLI.1;Password=' + sSQLPassword +
                   ';Persist Security Info=True;User ID=' + sSQLUser
    else Result := 'Provider=SQLNCLI.1;Integrated Security=SSPI;Persist Security Info=False;User ID=' + sSQLUser;

  Result := Result +
            ';Initial Catalog=' + sDatabaseName +
            ';Data Source=' + sServerName;

end;  {GetADOConnectionString}

{==========================================================}
Function GetExtractName(sTableName : String;
                        sExtractFolder : String) : String;

begin
  Result := sExtractFolder + sTableName + '.txt';
end;

{==========================================================}
Procedure TfmConvertDBaseToSQL.cbxDBaseDatabaseCloseUp(Sender: TObject);

begin
  Session.GetTableNames(cbxDBaseDatabase.Items[cbxDBaseDatabase.ItemIndex],
                        '*.*', False, False, lbxTables.Items);
end;

{==========================================================}
Procedure GetSelectedFromListBox(lbTemp : TListBox;
                                 slSelected : TStringList);

var
  I : Integer;

begin
  slSelected.Clear;

  with lbTemp do
    For I := 0 to (Items.Count - 1) do
      If Selected[I]
      then slSelected.Add(Items[I]);

end;  {GetSelectedFromListBox}

{==========================================================}
Procedure TfmConvertDBaseToSQL.FormCreate(Sender: TObject);

var
  sParameterString, sIniFilePath,
  sTempStr : String;
  i : integer;

{CHG12112013(MPT):Add support for logging}
begin
  {Local Logging}
  hLog.StartLogging;
  hLog.hlWriter.hlFileDef.append := True;
  sStartLogString := FormatDateTime(DateFormat, Date) + #9 + FormatDateTime(TimeFormat, Now) + #9 + 'STARTUP' + #9;

  {Remote Logging}
  rlRemoteLog := TRemoteLog.Create;
  rlRemoteLog.SetTable('log_entry');


  GlblCurrentCommaDelimitedField := 0;
  Session.GetDatabaseNames(cbxDBaseDatabase.Items);
  bAutoRun := False;
  bLoadDefaultsOnStartUp := True;
  {CHG11302013(MPT):Add parameter functions}
  For i := 1 to ParamCount do
  begin
    sParameterString := ParamStr(i);
    if Uppercase(sParameterString) = 'AUTORUN'
      then
        begin
          bAutoRun := True;
        end;

    if (Pos('SETTINGS',Uppercase(sParameterString)) > 0)
      then
        begin
          sIniFilePath := sParameterString;
          Delete(sIniFilePath,1,9);
          bLoadDefaultsOnStartUp := False;
          LoadIniFile(Self, sIniFilepath, True, True);
        end;

    if (Pos('LOGGING',Uppercase(sParameterString)) > 0)
      then
        begin
          sLogFileLocation := sParameterString;
          Delete(sLogFileLocation,1,8);
          hLog.hlWriter.hlFileDef.fileName := sLogFileLocation ;
        end;

    if (Pos('NOTIFICATION',Uppercase(sParameterString)) > 0)
      then
        begin
          sNotificationSettings := sParameterString;
          Delete(sNotificationSettings,1,13);
        end;
  end;

  rlRemoteLog.AddColumn('configuration');
  sTempStr := sIniFilePath + ' ' + sLogFileLocation + ' ' + sNotificationSettings;
  rlRemoteLog.AddValue(sTempStr);

  if bLoadDefaultsOnStartUp
    then LoadParameters;

  AutoRun;

end;  {FormCreate}

{======================================================}
Procedure TfmConvertDBaseToSQL.UpdateStatus(sStatus : String);

begin
  pnlStatus.Caption := sStatus;
  Application.ProcessMessages;
end;

{======================================================}
Procedure TfmConvertDBaseToSQL.ExtractOneTable(    tbExtract : TTable;
                                                   sDBaseDatabaseName : String;
                                                   sTableName : String;
                                                   sExtractFileName : String;
                                                   bExtractMemosAsFiles : Boolean;
                                                   bFirstLineIsHeaders : Boolean;
                                                   bIncludeFieldTypes : Boolean;
                                                   bCreateNewFile : Boolean;
                                               var iMemoNumber : Integer);

var
  sTempFileName : String;
  I, iNumRecordsExported : Integer;
  slFields : TStringList;
  flExtract : TextFile;

begin
  slFields := TStringList.Create;
  AssignFile(flExtract, sExtractFileName);

  Rewrite(flExtract);

  with tbExtract do
  try
    TableName := sTableName;
    DatabaseName := sDBaseDatabaseName;
    Open;
    First;

    For I := 0 to (FieldList.Count - 1) do
      slFields.Add(FieldList[I].FieldName);
  except
  end;

  If (bCreateNewFile and
      bFirstLineIsHeaders)
    then
      begin
        For I := 0 to (slFields.Count - 1) do
          WriteCommaDelimitedLine(flExtract, [slFields[I]]);

        WritelnCommaDelimitedLine(flExtract, []);

      end;  {If FirstLineIsHeadersCheckBox.Checked}

  iNumRecordsExported := 0;
  ProgressBar.Max := tbExtract.RecordCount;
  ProgressBar.Position := 0;

  with tbExtract do
    while not EOF do
    begin
      iNumRecordsExported := iNumRecordsExported + 1;
      ProgressBar.StepIt;
      Self.UpdateStatus(sDBaseDatabaseName + ':' + sTableName + ' ' + IntToStr(iNumRecordsExported) + ' exported.');

      For I := 0 to (slFields.Count - 1) do
        If ((FindField(slFields[I]).DataType = ftMemo) and
             bExtractMemosAsFiles and
            (not FindField(slFields[I]).IsNull))
          then
            begin
              iMemoNumber := iMemoNumber + 1;
              sTempFileName := 'MEMO' + IntToStr(iMemoNumber) + '.MEM';
              TMemoField(FindField(slFields[I])).SaveToFile(sTempFileName);
              WriteCommaDelimitedLine(flExtract, [sTempFileName]);

            end
          else WriteCommaDelimitedLine(flExtract, [FindField(slFields[I]).AsString]);

      WritelnCommaDelimitedLine(flExtract, ['|']);

      Next;

    end;  {while not EOF do}

  CloseFile(flExtract);
  tbExtract.Close;

end;  {ExtractOneTable}

{==========================================================}
Procedure TfmConvertDBaseToSQL.CreateOneTable(adoQuery : TADOQuery;
                                              tbExtract : TTable;
                                              sDBaseDatabaseName : String;
                                              sTableName : String;
                                              sSQLDatabaseName : String;
                                              sExtractName : String);

var
  slSQL : TStringList;
  I : Integer;
  sFieldName, sTemp : String;

begin
  slSQL := TStringList.Create;

  UpdateStatus('Dropping Table ' + sTableName);

  _QueryExec(adoQuery,
             ['Drop Table [' + sSQLDatabaseName + '].[dbo].[' + sTableName + ']']);

  UpdateStatus('Creating Table ' + sTableName);

  slSQL.Add('CREATE TABLE [' + sSQLDatabaseName + '].[dbo].[' + sTableName + '] (');

  with tbExtract do
  try
    TableName := sTableName;
    DatabaseName := sDBaseDatabaseName;
    Open;
    First;
  except
  end;

  with tbExtract do
  begin
    For I := 0 to (FieldCount - 1) do
    begin
      //sFieldName := '[' + StringReplace(FieldDefs.Items[I].Name, '2', 'Second', [rfReplaceAll]) + ']';
      sFieldName := '[' + FieldDefs.Items[I].Name + ']';

      If (Fields[I].DataType = ftMemo)
      then sTemp := sFieldName + ' text NULL'
      else sTemp := sFieldName + ' varchar(250) NULL';

      If _Compare(I, (FieldCount - 1), coLessThan)
      then sTemp := sTemp + ',';

      slSQL.Add(sTemp);

    end;  {For I := 0 to (FieldCount - 1) do}

  end;  {with tbExtract do}

  slSQL.Add(')');

  try
    adoQuery.Close;
    adoQuery.SQL.Assign(slSQL);
    adoQuery.ExecSQL;
  except
  end;

  tbExtract.Close;

end;  {CreateOneTable}

{==========================================================}
Procedure TfmConvertDBaseToSQL.LoadOneTable(adoQuery : TADOQuery;
                                            sTableName : String;
                                            sSQLDatabaseName : String;
                                            sExtractName : String);

begin
  _QueryExec(adoQuery,
             ['BULK INSERT [' + sSQLDatabaseName + '].[dbo].[' + sTableName + ']',
              'FROM ' + FormatSQLString(sExtractName),
              'WITH (DATAFILETYPE = ' + FormatSQLString('char') + ',',
              'FIELDTERMINATOR = ' + FormatSQLString('|') + ',',
              'ROWTERMINATOR = ' + FormatSQLString('\n') + ')']);

  UpdateStatus(sSQLDatabaseName + ':' + sTableName + ' imported data from ' + sExtractName);

end;  {LoadOneTable}

{==========================================================}
Procedure DeleteOneExtract(sExtractName : String);

begin
  try
    DeleteFile(sExtractName);
  except
  end;

end;  {DeleteOneExtract}

{==========================================================}
Procedure TfmConvertDBaseToSQL.CopyOneTable(adoQuery : TADOQuery;
                                            sSQLDatabaseName : String;
                                            sSourceTable : String;
                                            sDestTable : String;
                                            bDropSourceTable : Boolean);

begin
  _QueryExec(adoQuery,
             ['INSERT INTO [' + sSQLDatabaseName + '].[dbo].[' + sDestTable + ']',
              'SELECT * FROM [' + sSQLDatabaseName + '].[dbo].[' + sSourceTable + ']']);

  If bDropSourceTable
  then _QueryExec(adoQuery,
                  ['DROP TABLE [' + sSQLDatabaseName + '].[dbo].[' + sSourceTable + ']']);

  UpdateStatus(sSQLDatabaseName + ':' + sSourceTable + ' copied to ' + sDestTable);

end;  {CopyOneTable}

{============================================================}
Procedure TfmConvertDBaseToSQL.btnLocateExtractFolderClick(Sender: TObject);

var
  sChosenDirectory : String;
begin
  if SelectDirectory('Select a directory', 'C:\', sChosenDirectory)
  then edExtractFolder.Text := sChosenDirectory;
end;

{============================================================}
procedure TfmConvertDBaseToSQL.btnLocateServerFolderClick(Sender: TObject);

var
  sChosenDirectory : String;
begin
  if SelectDirectory('Select a directory', 'C:\', sChosenDirectory)
  then edServerFolder.Text := sChosenDirectory;
end;

{CHG12062013(MPT): Add automatic shutdown if autorun parameter is specified}
{==========================================================}
Procedure TfmConvertDBaseToSQL.btnRunClick(Sender: TObject);

var
  slSelectedTables, slSaveTables : TStringList;
  I, iMemoNumber : Integer;
  sConnectionString, sAutoInc,
  sExtractName, sExtractFolder, sServerFolder,
  sTempStr : String;
  adoQuery, adoAutoInc : TADOQuery;
  tbExtract : TTable;
  adoConnectAutoInc : TADOConnection;

begin
  {CHG12202013(MPT):Implementation of both client and server side logging}
  {Local Logging}
  sStartLogString := sStartLogString + 'START' + #9;
  If bAutoRun
    then sStartLogString := sStartLogString + 'AUTO' + #9
    else sStartLogString := sStartLogString + 'MANUAL' + #9;
  slSaveTables := TStringList.Create;
  slSaveTables := SaveSelectedListBoxItems(lbxTables);
  sStartLogString := sStartLogString + edUDLFileName.Text + #9 + cbxDBaseDatabase.Text + #9 + StringListToCommaDelimitedString(slSaveTables) + #9;
  hLog.Add(sStartLogString);

  {Remote Logging}
  if cbUseRemoteLogging.Checked
    then
      begin
        rlRemoteLog.AddColumnValuePair(rlDateTime, rlRemoteLog.CurrentDatetime);
        rlRemoteLog.AddColumnValuePair(rlAction, 'START');
        rlRemoteLog.AddColumn(rlRunType);
        if bAutoRun
          then rlRemoteLog.AddValue('AUTO')
          else rlRemoteLog.AddValue('MANUAL');
        rlRemoteLog.AddColumnValuePair(rlSource, cbxDBaseDatabase.Text);
        rlRemoteLog.AddColumnValuePair(rlDestination, edExtractFolder.Text);
        sTempStr := StringListToCommaDelimitedString(SaveSelectedListBoxItems(lbxTables));
        rlRemoteLog.AddColumnValuePair(rlTables, sTempStr);
        rlRemoteLog.AddColumnValuePair(rlClientId, edClientId.Text);
        rlRemoteLog.SaveLog;
      end;

  bCancelled := False;
  slSelectedTables := TStringList.Create;
  sExtractFolder := IncludeTrailingPathDelimiter(edExtractFolder.Text);
  sServerFolder := IncludeTrailingPathDelimiter(edServerFolder.Text);
  bDeleteExtracts := False;
  GetSelectedFromListBox(lbxTables, slSelectedTables);

  (*If not bAutoRun
  then GetOptions(edServer.Text, cbxSQLDatabase.Text, cbxDBaseDatabase.Text,
                  cbUseSQLLogin.Checked, edSQLUser.Text, edSQLPassword.Text,
                  cbCreateTableStructure.Checked); *)

  sServerName := edSQLServer.Text;
  sDBaseDatabaseName := cbxDBaseDatabase.Text;
  sSQLDatabaseName := cbxSQLDatabase.Text;
  bUseSQLLogin := cbUseSQLLogin.Checked;
  sSQLUser := edSQLUser.Text;
  sSQLPassword := edSQLPassword.Text;
  bCreateTables := cbCreateTableStructure.Checked;
  bCombineToNY := cbCombineToNY.Checked;

  sUDLFileName := edUDLFileName.Text;
  If _Compare(sUDLFileName, coBlank)
  then sConnectionString := GetADOConnectionString(bUseSQLLogin, sSQLPassword, sSQLUser,
                                                   sServerName, sSQLDatabaseName)
  else sConnectionString := 'FILE NAME=' + sUDLFileName;

  bCancelled := False;
  I := 0;

  tbExtract := TTable.Create(nil);
  adoQuery := TADOQuery.Create(nil);

  tbExtract.TableType := ttDBase;
  adoQuery.ConnectionString := sConnectionString;
  adoQuery.CommandTimeout := 10000;

  while ((not bCancelled) and
         (I <= (slSelectedTables.Count - 1))) do
  begin
    sExtractName := GetExtractName(slSelectedTables[I], sExtractFolder);
    ExtractOneTable(tbExtract, sDBaseDatabaseName, slSelectedTables[I], sExtractName,
                    True, False, False, bCreateTables, iMemoNumber);

    If bCreateTables
    then CreateOneTable(adoQuery, tbExtract, sDBaseDatabaseName, slSelectedTables[I], sSQLDatabaseName, sExtractName);

    sExtractName := sServerFolder + slSelectedTables[I] + '.txt';
    LoadOneTable(adoQuery, slSelectedTables[I], sSQLDatabaseName, sExtractName);

    If bDeleteExtracts
    then DeleteOneExtract(sExtractName);

    I := I + 1;

  end;  {while ((not bCancelled) and...}

  I := 0;

  If bCombineToNY
  then
  while ((not bCancelled) and
         (I <= (slSelectedTables.Count - 1))) do
  begin
    If (_Compare(slSelectedTables[I], 'h', coStartsWith) or
        _Compare(slSelectedTables[I], 't', coStartsWith))
    then CopyOneTable(adoQuery, sSQLDatabaseName, slSelectedTables[I],  'N' + Copy(slSelectedTables[I], 2, 255), True);

    I := I + 1;

  end;  {while ((not bCancelled) and...}

  {CHG010520114(MPT):Allow Sales_ID in PSalesRec to autoincrement if checked}
  bAutoInc := cbAutoInc.Checked;
  sAutoInc := 'ALTER TABLE PSalesRec DROP COLUMN Sale_ID;';
  if bAutoInc
    then
      begin
          adoAutoInc := TADOQuery.Create(nil);
          adoConnectAutoInc := TADOConnection.Create(nil);
          adoConnectAutoInc.ConnectionString := 'FILE NAME=' + edUDLFileName.Text;
          adoConnectAutoInc.LoginPrompt := False;
          adoConnectAutoInc.Connected := True;

          adoAutoInc.Connection := adoConnectAutoInc;
          adoAutoInc.SQL.Add(sAutoInc);
          adoAutoInc.ExecSQL;
          adoAutoInc.Free;

          adoAutoInc := TADOQuery.Create(nil);
          adoAutoInc.Connection := adoConnectAutoInc;
          adoAutoInc.SQL.Add('ALTER TABLE PSalesRec ADD Sale_ID int IDENTITY(1,1);');
          adoAutoInc.ExecSQL;
          adoAutoInc.Free;
      end;

  UpdateStatus('Done.');
  ProgressBar.Position := 0;

  {End of run logging}
  {Local}
  sFinishLogString := FormatDateTime(DateFormat, Date) + #9 + FormatDateTime(TimeFormat, Now) + #9 + 'CLOSE' + #9 + 'FINISHED' ;
  hLog.AddStr(sFinishLogString);
  {Remote}
  if cbUseRemoteLogging.checked
    then
      begin
        rlEndRemoteLog := TRemoteLog.Create;
        rlEndRemoteLog.SetTable('log_entry');
        rlEndRemoteLog.AddColumnValuePair(rlAction, 'FINISH');
        rlEndRemoteLog.AddColumn(rlRunType);
        if bAutoRun
          then rlEndRemoteLog.AddValue('AUTO')
          else rlEndRemoteLog.AddValue('MANUAL');
        rlEndRemoteLog.AddColumnValuePair(rlDatetime, rlEndRemoteLog.CurrentDatetime);
        rlEndRemoteLog.SaveLog;
      end;


  slSelectedTables.Free;
  tbExtract.Close;
  tbExtract.Free;
  adoQuery.Close;

  if bAutoRun
    then fmConvertDBaseToSQL.Destroy;

end;  {btnRunClick}

{==========================================================}
{CHG11272013(MPT): Add Saving and Loading from INI file}

procedure TfmConvertDBaseToSQL.btnSaveClick(Sender: TObject);

var
  sIniFileName : String;
begin
   if dlgSaveIniFile.Execute
   then
   begin
    sIniFileName := dlgSaveIniFile.FileName;
    SaveIniFile(Self, sIniFileName, True, True);
   end; {Check for cancel}
end; {Save custom INI files}

{==========================================================}
procedure TfmConvertDBaseToSQL.btnLoadClick(Sender: TObject);

var
  sIniFileName : string;
begin
  if dlgLoadIniFile.Execute
  then
  begin
    sIniFileName := dlgLoadIniFile.FileName;
    LoadIniFile(Self, sIniFileName, True, True);
  end; {Check for cancel}
end; {Load custom INI files}

{==========================================================}
procedure TfmConvertDBaseToSQL.FormClose(Sender: TObject;
                                          var Action: TCloseAction);

begin
  SaveIniFile(Self, sDefaultIniFileName, True, False);

end; {Save current setup as default on close}

{CHG12082103(MPT):Adding autorun functionaity}
{==========================================================}
procedure TfmConvertDBaseToSQL.AutoRun;
begin
  If bAutoRun
    then fmConvertDBaseToSQL.btnRunClick(Self);
end;


end.
