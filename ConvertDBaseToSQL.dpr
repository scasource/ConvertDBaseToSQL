program ConvertDBaseToSQL;

uses
  Forms,
  ConvertDBaseToSQLUnit in 'ConvertDBaseToSQLUnit.pas' {fmConvertDBaseToSQL},
  CreateLogFile in 'CreateLogFile.pas',
  SQLRemoteLogging in 'SQLRemoteLogging.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmConvertDBaseToSQL, fmConvertDBaseToSQL);
  Application.Run;
end.
