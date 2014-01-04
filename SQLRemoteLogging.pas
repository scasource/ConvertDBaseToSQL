{==========================================================================
This is unit is used to create an SQL insert statement for the purposes of
logging program behavior to a remote SQL server.

TODO:
  Sanitize read/write from properties.
  Format connection string from seperate variables.

Written by :
Morgan Thrapp.
===========================================================================}



unit SQLRemoteLogging;

interface

uses Classes, ADODB, SysUtils, StdCtrls, Windows, Dialogs, Forms;

type
  TRemoteLog = class

  private
    sConnectionString : String;
    sTableName : String;
    slColumnList : TStringList;
    slValuesList : TStringList;
    sInsertStatement : String;
    bUseColumns : Boolean;

    function FormatAsSQL(TempStr : String) : String;

    procedure SaveInput(InputStr : String;
                        TypeStr : String);

    procedure FormatInsertString;

    procedure DeleteInput(DeleteStr : String;
                          TypeStr : String);



  published
    constructor Create;

    procedure SetTable(TableName : String);

    procedure AddColumn(ColumnName : String); Overload;

    procedure AddValue(Value : String); Overload;

    procedure AddColumnValuePair(ColumnName : String;
                                 Value : String); 

    procedure SaveLog;

    procedure SetConnectionString(ConnectionString : String);

    procedure DeleteColumn(ColumnName : String);

    procedure DeleteValue(Value : String);

    procedure DeleteColumnValuePair(Index : Integer);

    function CurrentDatetime : String;



    property UseColumns : Boolean
      read bUseColumns
      write bUseColumns;

    property ConnectionString : String
      read sConnectionString
      write SetConnectionString;

    property TableName : String
      read sTableName
      write SetTable;

    property ColumnList : TStringlist
      read slColumnList
      write slColumnList;

    property ValuesList : TStringlist
      read slValuesList
      write slValuesList;

  end;

  Const
    rlTables = 'log_entry';
    rlDatetime = 'log_datetime';
    rlRunType = 'run_type';
    rlSource = 'source';
    rlDestination = 'destination';
    rlClientId = 'log_instance_id';
    rlAction = 'log_action';
    rlConfiguration = 'configuration';

implementation

{==============================================================================}
constructor TRemoteLog.Create;
begin
  self.sConnectionString := 'FILE NAME=' + GetCurrentDir + '/' + 'RemoteLog.udl';
  self.sTableName := '';
  self.bUseColumns := True;
  self.slColumnList := TStringList.Create;
  self.slValuesList := TStringList.Create;
end;

{==============================================================================}
function TRemoteLog.FormatAsSQL(TempStr : String) : String;
var
  sResultString : String;

begin
  sResultString := '''' + TempStr + '''';
  result := sResultString;
end;

{==============================================================================}
procedure TRemoteLog.SaveInput(InputStr : String;
                               TypeStr : String);
var
  sTypeStr, sTempStr : String;

begin
  sTypeStr := AnsiUpperCase(TypeStr);
  if (sTypeStr = 'TABLE')
    then sTableName := InputStr;
  if (sTypeStr = 'COLUMN')
    then slColumnList.Add(InputStr);
  if (sTypeStr = 'VALUE')
    then slValuesList.Add(InputStr);
  if (sTypeStr = 'CONNECTION')
    then sConnectionString := InputStr;
end;

{==============================================================================}
procedure TRemoteLog.SaveLog;
var
  SQLLogQuery : TADOQuery;
  SQLLogConnection : TADOConnection;

begin
  FormatInsertString;

  SQLLogConnection := TADOConnection.Create(nil);
  SQLLogConnection.ConnectionString := sConnectionString;
  SQLLogConnection.LoginPrompt := False;
  SQLLogConnection.Connected := True;

  SQLLogQuery := TADOQuery.Create(nil);
  SQLLogQuery.Connection := SQLLogConnection;
  SQLLogQuery.SQL.Add(sInsertStatement);

  SQLLogQuery.ExecSQL;
end;

{==============================================================================}
procedure TRemoteLog.FormatInsertString;
var
  sTempStr : String;
  I, X : Integer;
begin
  sInsertStatement := 'INSERT INTO ' + sTableName + ' ';
  if bUseColumns
    then
      begin
        sInsertStatement := sInsertStatement + '(';
        for I:=0 to slColumnList.Count - 1 do
          begin
            sTempStr := slColumnList[I] + ',';
            sInsertStatement := sInsertStatement + sTempStr;
          end;
        X := Length(sInsertStatement);
        Delete(sInsertStatement,X,1);
        sInsertStatement := sInsertStatement + ') ';
      end;
  sInsertStatement := sInsertStatement + 'VALUES (';
  for I:=0 to slValuesList.Count - 1 do
    begin
      sTempStr := FormatAsSQL(slValuesList[I]) + ',';
      sInsertStatement := sInsertStatement + sTempStr;
    end;
  X := Length(sInsertStatement);
  Delete(sInsertStatement,X,1);
  sInsertStatement := sInsertStatement + ');';
end;

{==============================================================================}
procedure TRemoteLog.SetTable(TableName : String);
begin
  SaveInput(TableName, 'table');
end;

{==============================================================================}
procedure TRemoteLog.AddColumn(ColumnName : String);
begin
  SaveInput(ColumnName, 'column');
end;

{==============================================================================}
procedure TRemoteLog.AddValue(Value : String);
begin
  SaveInput(Value, 'value');
end;


{==============================================================================}
procedure TRemoteLog.SetConnectionString(ConnectionString : String);
begin
  SaveInput(ConnectionString, 'connection');
end;

{==============================================================================}
procedure TRemoteLog.DeleteColumn(ColumnName : String);
begin
  DeleteInput(ColumnName, 'C');
end;

{==============================================================================}
procedure TRemoteLog.DeleteColumnValuePair(Index: Integer);
var
  sColumnStr : String;
  sValueStr : String;
begin
  sColumnStr := slColumnList[Index];
  sValueStr := slValuesList[Index];
  DeleteInput(sColumnStr, 'C');
  DeleteInput(sValueStr, 'V');
end;

{==============================================================================}
procedure TRemoteLog.DeleteValue(Value : String);
begin
  DeleteInput(Value, 'V');
end;

{==============================================================================}
procedure TRemoteLog.DeleteInput(DeleteStr : String;
                                 TypeStr: String);
var
  I : Integer;
  sTypeStr : String;

begin
  sTypeStr := AnsiUpperCase(TypeStr);
  if (sTypeStr = 'COLUMN')
    then
      begin
        I := slColumnList.IndexOf(DeleteStr);
        if (I<>-1)
          then slColumnList.Delete(I);
      end;
  if (sTypeStr = 'VALUE')
    then
      begin
        I := slColumnList.IndexOf(DeleteStr);
        if (I<>-1)
          then slValuesList.Delete(I);
      end;
end;

{==============================================================================}
function TRemoteLog.CurrentDatetime: String;
var
  dtCurTime : TDateTime;
  sTimeStr, sDateStr : String;
begin
  dtCurTime := Now;
  sDateStr := FormatDateTime('yyyymmdd',dtCurTime);
  sTimeStr := FormatDateTime('hh:mm:ss.zzz',dtCurTime);
  Result := sDateStr + ' ' + sTimeStr;
end;

{==============================================================================}
procedure TRemoteLog.AddColumnValuePair(ColumnName: String;
                                        Value: String);
begin
  AddColumn(ColumnName);
  AddValue(Value);
end;

end.
