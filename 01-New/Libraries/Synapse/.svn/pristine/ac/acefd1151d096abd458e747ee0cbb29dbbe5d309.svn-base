unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  synsock, blcksock, synautil;

{$R *.lfm}

type

  { TUDPDaemon }

  TUDPDaemon = class(TThread)
  private
    Sock: TUDPBlockSocket;
    LogData: string;
    procedure AddLog;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute; override;
  end;

var
  Daemon: TUDPDaemon;
  MyIPAddr: string;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  sock: TUDPBlockSocket;
begin
  sock := TUDPBlockSocket.Create;
  try
    sock.Family := SF_IP4;
    sock.CreateSocket();
    sock.Bind('0.0.0.0', '0');
    sock.MulticastTTL := 1;
    sock.Connect('234.5.6.7', '22401');
    if sock.LastError = 0 then
      sock.SendString('Hello World! I am ' + MyIPAddr);
  finally
    sock.Free;
  end;
end;

{ TUDPDaemon }

constructor TUDPDaemon.Create;
begin
  Sock := TUDPBlockSocket.Create;
  Sock.Family := SF_IP4;
  FreeOnTerminate := False;
  Priority := tpNormal;
  inherited Create(False);
end;

destructor TUDPDaemon.Destroy;
begin
  Sock.Free;
  inherited Destroy;
end;

procedure TUDPDaemon.Execute;
begin
  try
    Sock.CreateSocket();
    Sock.EnableReuse(True);
    // better to use MyIP(not to use INADDR_ANY). Because a problem occurs in Windows7.
    Sock.Bind(MyIPAddr, '22401');
    Sock.AddMulticast('234.5.6.7', MyIPAddr);
    while not Terminated do
    begin
      LogData := Sock.RecvPacket(1000);
      LogData := Sock.GetRemoteSinIP + ': ' + LogData;
      if Sock.LastError = 0 then
        Synchronize(@AddLog);
    end;
  finally
  end;
end;

procedure TUDPDaemon.AddLog;
begin
  if Assigned(Form1) then
  begin
    Form1.Memo1.Lines.BeginUpdate;
    try
      Form1.Memo1.Lines.Add(LogData);
    finally
      Form1.Memo1.Lines.EndUpdate;
    end;
  end;
  LogData := '';
end;

procedure _Init;
var
  sock: TBlockSocket;
begin
  sock := TBlockSocket.Create;
  try
    sock.Family := SF_IP4;
    MyIPAddr := sock.ResolveName(sock.LocalName);
  finally
    sock.Free;
  end;

  Daemon := TUDPDaemon.Create;
end;

procedure _Fin;
begin
  if Assigned(Daemon) then
  begin
    Daemon.Terminate;
    Daemon.WaitFor;
    FreeAndNil(Daemon);
  end;
end;

initialization
  _Init;

finalization
  _Fin;
end.

