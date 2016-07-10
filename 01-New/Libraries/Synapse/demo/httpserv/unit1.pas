unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Memo1: TMemo;
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
  synsock, blcksock, synautil,
  Contnrs;

{$R *.lfm}

type

  { TTCPHttpDaemon }

  TTCPHttpDaemon = class(TThread)
  private
    Sock: TTCPBlockSocket;
    ThreadList: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  { TTCPHttpThread }

  TTCPHttpThread = class(TThread)
  private
    Sock: TTCPBlockSocket;
    Headers: TStringList;
    InputData, OutputData: TMemoryStream;
    LogData: string;
    function ProcessHttpRequest(Request, URI: string): integer;
    procedure AddLog;
  public
    DoneFlag: boolean;
    constructor Create(hSock: TSocket);
    destructor Destroy; override;
    procedure Execute; override;
  end;

var
  Daemon: TTCPHttpDaemon;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Align := alClient;
  Memo1.Lines.Clear;
end;

{ TTCPHttpDaemon }

constructor TTCPHttpDaemon.Create;
begin
  Sock := TTCPBlockSocket.Create;
  Sock.Family := SF_IP4;
  ThreadList := TObjectList.Create(False);
  FreeOnTerminate := False;
  Priority := tpNormal;
  inherited Create(False);
end;

destructor TTCPHttpDaemon.Destroy;
var
  thd: TTCPHttpThread;
  i: integer;
begin
  for i := 0 to ThreadList.Count - 1 do
  begin
    thd := TTCPHttpThread(ThreadList[i]);
    thd.Sock.AbortSocket;
    thd.Terminate;
    thd.WaitFor;
    FreeAndNil(thd);
  end;
  ThreadList.Free;
  Sock.Free;
  inherited Destroy;
end;

procedure TTCPHttpDaemon.Execute;
var
  hSock: TSocket;
  th: TTCPHttpThread;
  i: integer;
begin
  try
    Sock.CreateSocket;
    Sock.SetLinger(True, 10000);
    Sock.Bind('0.0.0.0', '80');
    Sock.Listen;
    while not Terminated do
    begin
      if Sock.CanRead(1000) then
      begin
        hSock := Sock.Accept;
        if Sock.LastError = 0 then
        begin
          i := 0;
          while i < ThreadList.Count do
          begin
            // Garbage collection
            th := TTCPHttpThread(ThreadList[i]);
            if th.DoneFlag then
            begin
              th.Free;
              ThreadList.Delete(i);
            end
            else
              Inc(i);
          end;

          ThreadList.Add(TTCPHttpThread.Create(hSock));
        end;
      end;
    end;
  finally
  end;
end;

{ TTCPHttpThrd }

constructor TTCPHttpThread.Create(hSock: TSocket);
begin
  Sock := TTCPBlockSocket.Create;
  Sock.Family := SF_IP4;
  Sock.Socket := hSock;
  FreeOnTerminate := False;
  Priority := tpNormal;
  inherited Create(False);
end;

destructor TTCPHttpThread.Destroy;
begin
  Sock.Free;
  inherited Destroy;
end;

procedure TTCPHttpThread.Execute;
var
  timeout: integer;
  s: string;
  method, uri, protocol: string;
  size: integer;
  x, n: integer;
  resultcode: integer;
  Close: boolean;
begin
  Headers := TStringList.Create;
  InputData := TMemoryStream.Create;
  OutputData := TMemoryStream.Create;
  DoneFlag := False;
  try
    timeout := 120000;
    while not Terminated and (Sock.LastError = 0) do
    begin
      // read request line
      s := Sock.RecvString(timeout);
      if Sock.LastError <> 0 then
        Exit;
      if s = '' then
        Exit;

      LogData := Format('%s:%d Connected. (ID=%d)',
        [Sock.GetRemoteSinIP, Sock.GetRemoteSinPort, Self.FThreadID]);
      Synchronize(@AddLog);

      method := fetch(s, ' ');
      if (s = '') or (method = '') then
        Exit;
      uri := fetch(s, ' ');
      if uri = '' then
        Exit;
      protocol := fetch(s, ' ');
      headers.Clear;
      size := -1;
      Close := False;
      //read request headers
      if protocol <> '' then
      begin
        if pos('HTTP/', protocol) <> 1 then
          Exit;
        if pos('HTTP/1.1', protocol) <> 1 then
          Close := True;
        repeat
          s := sock.RecvString(Timeout);
          if sock.lasterror <> 0 then
            Exit;
          if s <> '' then
            Headers.add(s);
          if Pos('CONTENT-LENGTH:', Uppercase(s)) = 1 then
            Size := StrToIntDef(SeparateRight(s, ' '), -1);
          if Pos('CONNECTION: CLOSE', Uppercase(s)) = 1 then
            Close := True;
        until s = '';
      end;
      //recv document...
      InputData.Clear;
      if size >= 0 then
      begin
        InputData.SetSize(Size);
        x := Sock.RecvBufferEx(InputData.Memory, Size, Timeout);
        InputData.SetSize(x);
        if sock.lasterror <> 0 then
          Exit;
      end;
      OutputData.Clear;
      ResultCode := ProcessHttpRequest(method, uri);
      sock.SendString(protocol + ' ' + IntToStr(ResultCode) + CRLF);
      if protocol <> '' then
      begin
        headers.Add('Content-length: ' + IntToStr(OutputData.Size));
        if Close then
          headers.Add('Connection: close');
        headers.Add('Date: ' + Rfc822DateTime(now));
        headers.Add('Server: Synapse HTTP server demo');
        headers.Add('');
        for n := 0 to headers.Count - 1 do
          sock.sendstring(headers[n] + CRLF);
      end;
      if Sock.LastError <> 0 then
        Exit;
      Sock.SendBuffer(OutputData.Memory, OutputData.Size);
      if Close then
        Break;
    end;

  finally
    Headers.Free;
    InputData.Free;
    OutputData.Free;
    DoneFlag := True;
  end;
end;

function TTCPHttpThread.ProcessHttpRequest(Request, URI: string): integer;
var
  l: TStringList;
begin
  //sample of precessing HTTP request:
  // InputData is uploaded document, headers is stringlist with request headers.
  // Request is type of request and URI is URI of request
  // OutputData is document with reply, headers is stringlist with reply headers.
  // Result is result code
  Result := 504;
  if request = 'GET' then
  begin
    headers.Clear;
    headers.Add('Content-type: Text/Html');
    l := TStringList.Create;
    try
      l.Add('<html>');
      l.Add('<head></head>');
      l.Add('<body>');
      l.Add('Request Uri: ' + uri);
      l.Add('<br>');
      l.Add('This document is generated by Synapse HTTP server demo!');
      l.Add('</body>');
      l.Add('</html>');
      l.SaveToStream(OutputData);
    finally
      l.Free;
    end;
    Result := 200;
  end;
end;

procedure TTCPHttpThread.AddLog;
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
begin
  Daemon := TTCPHttpDaemon.Create;
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

