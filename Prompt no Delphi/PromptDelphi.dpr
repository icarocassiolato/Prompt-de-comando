program PromptDelphi;

uses
  Forms,
  uPrompt in 'uPrompt.pas' {frmPrompt};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrompt, frmPrompt);
  Application.Run;
end.
