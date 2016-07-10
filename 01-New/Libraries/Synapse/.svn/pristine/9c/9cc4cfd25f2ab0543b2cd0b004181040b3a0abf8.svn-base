unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ColorBox, Contnrs;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ColorBox1: TColorBox;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { private declarations }
    thList: TObjectList;
    procedure GarbageCollection;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  synsock, blcksock, synautil, HTTPSend;

{$R *.lfm}

type

  { TSockThread }

  TSockThread = class(TThread)
  private
    HTTP: THTTPSend;
    LogData: string;
    URI: string;
    procedure AddLog;
    procedure BeginSock;
    procedure EndSock;
  public
    DoneFlag: boolean;
    constructor Create(const auri: string);
    destructor Destroy; override;
    procedure Execute; override;
  end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text := 'www.yahoo.com, w.y.c, www.google.com, www.google.com:8080';
  Memo1.Lines.Clear;
  thList := TObjectList.Create(False);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Hide; // Because FormDestroy() may take time.
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
  SockThread: TSockThread;
begin
  for i := 0 to thList.Count - 1 do
  begin
    SockThread := TSockThread(thList[i]);
    SockThread.HTTP.Sock.AbortSocket;
    SockThread.Terminate;
    SockThread.WaitFor; // It may take time.
    SockThread.Free;
  end;
  thList.Free;
end;

procedure TForm1.GarbageCollection;
var
  i: integer;
  th: TSockThread;
begin
  i := 0;
  while i < thList.Count do
  begin
    th := TSockThread(thList[i]);
    if th.DoneFlag then
    begin
      th.Free;
      thList.Delete(i);
    end
    else
      Inc(i);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
  th: TSockThread;
begin
  if Button1.Caption = 'Go' then
  begin
    Memo1.Lines.Clear;
    Button1.Caption := 'Abort';
    GarbageCollection;
    thList.Add(TSockThread.Create(Edit1.Text));
    Memo1.Lines.Add('Thread Count: ' + IntToStr(thList.Count));
  end
  else
  begin
    for i := 0 to thList.Count - 1 do
    begin
      th := TSockThread(thList[i]);
      th.HTTP.Sock.AbortSocket;
      th.Terminate;
    end;
    Button1.Caption := 'Go';
  end;
end;

{ TSockThread }

constructor TSockThread.Create(const auri: string);
begin
  HTTP := THTTPSend.Create;
  URI := auri;
  FreeOnTerminate := False;
  Priority := tpNormal;
  inherited Create(False);
end;

destructor TSockThread.Destroy;
begin
  HTTP.Free;
  inherited Destroy;
end;

procedure TSockThread.Execute;
var
  s: string;
begin
  DoneFlag := False;
  Synchronize(@BeginSock);
  try
    while not Terminated do
    begin
      s := Trim(Fetch(URI, ','));
      if s = '' then
      begin
        LogData := 'Finished.' + CRLF;
        Synchronize(@AddLog);
        Break;
      end;
      LogData := StringOfChar('=', 80) + CRLF + s;
      Synchronize(@AddLog);
      HTTP.Timeout := 60 * 1000;
      HTTP.HTTPMethod('GET', s);
      if Terminated then
        Break;
      if HTTP.Sock.LastError = 0 then
      begin
        LogData := LogData + HTTP.Headers.Text + CRLF;
      end
      else
        LogData := LogData + 'ERROR: ' + HTTP.Sock.LastErrorDesc + CRLF;
      LogData := LogData + StringOfChar('=', 80);
      Synchronize(@AddLog);
    end;
  finally
    Synchronize(@EndSock);
    DoneFlag := True;
  end;
end;

procedure TSockThread.AddLog;
begin
  Form1.Memo1.Lines.BeginUpdate;
  try
    Form1.Memo1.Lines.Text := Form1.Memo1.Lines.Text + LogData + CRLF;
  finally
    Form1.Memo1.Lines.EndUpdate;
  end;
  LogData := '';
end;

procedure TSockThread.BeginSock;
begin
  Form1.ColorBox1.Selected := clRed;
end;

procedure TSockThread.EndSock;
var
  i: integer;
  b, b1, b2: boolean;
  SockThread: TSockThread;
begin
  b1 := False;
  b2 := False;
  for i := 0 to Form1.thList.Count - 1 do
  begin
    SockThread := TSockThread(Form1.thList[i]);
    b := (SockThread <> Self) and not SockThread.DoneFlag;
    b1 := b1 or b;
    b2 := b2 or (b and not SockThread.Terminated);
  end;
  if not b1 then
    Form1.ColorBox1.Selected := clGreen;
  if not b2 then
    Form1.Button1.Caption := 'Go';
end;

end.

