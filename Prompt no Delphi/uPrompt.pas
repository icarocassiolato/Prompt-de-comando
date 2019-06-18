unit uPrompt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmPrompt = class(TForm)
    mmoConsole: TMemo;
    edtComando: TEdit;
    Button1: TButton;
    lbxComandos: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure edtComandoKeyPress(Sender: TObject; var Key: Char);
    procedure lbxComandosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrompt: TfrmPrompt;

implementation

{$R *.dfm}

function DosInDelphi(DosApp: String): WideString;
const
  ReadBuffer = 2400;
var
  Security: TSecurityAttributes;
  ReadPipe, WritePipe: THandle;
  start: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  Buffer: PAnsiChar;
  BytesRead: DWord;
  Apprunning: DWord;

  TotalBytesRead: DWord;
  TotalBytesAvail, BytesLeftThisMessage: Integer;
begin
  with Security do
  begin
    nlength:= SizeOf(TSecurityAttributes);
    binherithandle:= True;
    lpsecuritydescriptor:= nil;
  end;
  if Createpipe(ReadPipe, WritePipe, @Security, 0) then
  begin
    Buffer:= AllocMem(ReadBuffer+1);
    FillChar(Start, Sizeof(Start), #0);
    start.cb:= SizeOf(start);
    start.hStdOutput:= WritePipe;
    start.hStdInput:= ReadPipe;
    start.dwFlags:= STARTF_USESTDHANDLES+STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    if CreateProcess(nil, PChar(DosApp), @Security, @Security,
       True, NORMAL_PRIORITY_CLASS, nil, nil, start, ProcessInfo) then
    begin
      TotalBytesRead:= 0;
      repeat
        Apprunning:= WaitForSingleObject(ProcessInfo.hProcess, 100);
        BytesRead:= 0;

        if not PeekNamedPipe(ReadPipe, @Buffer[TotalBytesRead], ReadBuffer, @BytesRead,
                             @TotalBytesAvail, @BytesLeftThisMessage) then
          Break
        else
          if BytesRead > 0 then
            ReadFile(ReadPipe, Buffer[0], ReadBuffer, BytesRead, nil);

        Buffer[BytesRead]:= #0;
        OemToAnsi(Buffer, Buffer);
        Result:= Result + String(Buffer);
      until (Apprunning <> WAIT_TIMEOUT);
    end
    else
      Result:= 'Impossível de executar!';
    FreeMem(Buffer);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ReadPipe);
    CloseHandle(WritePipe);
  end;
end;

procedure TfrmPrompt.Button1Click(Sender: TObject);
begin
  mmoConsole.Text:= DosInDelphi(edtComando.Text);
end;

procedure TfrmPrompt.edtComandoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if lbxComandos.Items.IndexOf(edtComando.Text) < 0 then
      lbxComandos.Items.Add(edtComando.Text);
    mmoConsole.Text:= DosInDelphi(edtComando.Text);
  end;
end;

procedure TfrmPrompt.lbxComandosClick(Sender: TObject);
begin
  edtComando.Text:= lbxComandos.Items[lbxComandos.ItemIndex];
end;

end.
