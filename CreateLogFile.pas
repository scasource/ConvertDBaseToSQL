unit CreateLogFile;

interface

uses
  Classes, SysUtils, Math, StdCtrls,
  Forms, Definitions;

Procedure SaveLogFile(UseCustomFilePath : Boolean;
                     CreateFileOnNotExist : Boolean);

Function GetComboBoxValue(Component : TComponent) : String;

Function GetListBoxValue(Component : TComponent) : TStringList;

Function GetEditValue(Component : TComponent) : String;

Function GetAutoRunValue : Boolean;

Function GetProgramStatus(var bRunStatus : Boolean) : Boolean;

Function GetCustomLogFilePath : String;


implementation
{$J+}

{===============================================================================

  CHG12092013(MPT):Create portable log file unit

===============================================================================}

Procedure SaveLogFile(UseCustomFilePath : Boolean;
                      CreateFileOnNotExist : Boolean);

var
  sDefaultLogFilePath, sCustomLogFilePath,
  sLogFilePath, sDateTime : String;
  _FileExists : Boolean;
  tfLogFile : TextFile;

begin
  sDefaultLogFilePath := GetCurrentDir + ExtractFileName(Application.ExeName) + '.log';
  sCustomLogFilePath := GetCustomLogFilePath;
  If UseCustomFilePath
    then sLogFilePath := sDefaultLogFilePath
    else sLogFilePath := sCustomLogFilePath;
  _FileExists := FileExists(sLogFilePath);
  If (_FileExists or
      ((not _FileExists) and
      CreateFileOnNotExist))
        then
          begin
            sDateTime := FormatDateTime(DateFormat, Date) + FormatDateTime(TimeFormat, Now);
            AssignFile(tfLogFile, sLogFilePath);
            Append(tfLogFile);
            Write(sLineBreak + sDateTime);
          end;

end;

{==============================================================================}
Function GetComboBoxValue(Component : TComponent) : String;

var
  sComponentValue : String;

begin
  sComponentValue := TComboBox(Component).Text;
  Result := sComponentValue;
end;

{==============================================================================}
Function GetListBoxValue(Component : TComponent) : TStringList;

var
  sComponentValue : String;
  slSelectedValues : TStringList;
  I : Integer;
begin
  slSelectedValues := TStringList.Create;
  For I:=0 to TListBox(Component).Items.Count do
    begin
      If TListBox(Component).Selected[I]
        then
          begin
            sComponentValue := TListBox(Component).Items[I];
            slSelectedValues.Append(sComponentValue);
          end;
      end;
  Result := slSelectedValues;
end;

{==============================================================================}
Function GetEditValue(Component : TComponent) : String;

var
  ComponentValue : String;

begin
  ComponentValue := TEdit(Component).Text;
  Result := ComponentValue;
end;

{==============================================================================}
Function GetAutoRunValue : Boolean;

var
  sCurrentParam : String;
  bAutoRun : Boolean;
  I : Integer;

begin
  bAutoRun := False;
  For I:=0 to ParamCount do
    begin
      sCurrentParam := Uppercase(ParamStr(I));
      If (sCurrentParam = 'AUTORUN')
        then bAutoRun := True;
    end;
  Result := bAutoRun;
end;

{==========================================================}
Function GetProgramStatus(var bRunStatus : Boolean) : Boolean;

var
  bRunYet : Boolean;

begin
  bRunYet := bRunStatus;
  If bRunStatus
    then bRunYet := True;
  Result := bRunYet;
end;

{==========================================================}
Function GetCustomLogFilePath : String;

var
  sCustomLogFilePath, sParameterString : String;
  I : Integer;

begin
  For I:=0 to ParamCount do
    begin
      sParameterString := Uppercase(ParamStr(I));
      If(Pos('LOGGING', sParameterString) > 0)
        then
          begin
            Delete(sParameterString, 1, 8);
            If not (Pos('.log', sParameterString) > 0)
              then sCustomLogFilePath := sParameterString + ExtractFileName(Application.ExeName) + '.log'
              else sCustomLogFilePath := sParameterString;
          end;
    end;
  Result := sCustomLogFilepath;
end;

end.



