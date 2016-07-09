unit uhttpdownloader;

{$mode Delphi}{$H+}

interface

uses
  Classes, SysUtils, httpsend, blcksock, typinfo;

type
  IProgress = interface
    procedure ProgressNotification(Text: String; CurrentProgress : integer; MaxProgress : integer);
  end;

type
  { THttpDownloader }

  THttpDownloader = class
  public
    function DownloadHTTP(URL, TargetFile: string; ProgressMonitor : IProgress): Boolean;
  private
    Bytes : Integer;
    MaxBytes : Integer;
    HTTPSender: THTTPSend;
    ProgressMonitor : IProgress;
    procedure Status(Sender: TObject; Reason: THookSocketReason; const Value: String);
    function GetSizeFromHeader(Header: String):integer;
  end;

implementation

function THttpDownloader.DownloadHTTP(URL, TargetFile: string; ProgressMonitor : IProgress): Boolean;
var
  HTTPGetResult: Boolean;
begin
  Result := False;
  Bytes:= 0;
  MaxBytes:= -1;
  Self.ProgressMonitor:= ProgressMonitor;

  HTTPSender := THTTPSend.Create;
  try
    HTTPSender.Sock.OnStatus:= Status;
    HTTPGetResult := HTTPSender.HTTPMethod('GET', URL);
    if (HTTPSender.ResultCode >= 100) and (HTTPSender.ResultCode<=299) then begin
      HTTPSender.Document.SaveToFile(TargetFile);
      Result := True;
    end;
  finally
    HTTPSender.Free;
  end;
end;

procedure THttpDownloader.Status(Sender: TObject; Reason: THookSocketReason; const Value: String);
var
  V, currentHeader: String;
  i: integer;
begin
  //try to get filesize from headers
  if (MaxBytes = -1) then
  begin
    for i:= 0 to HTTPSender.Headers.Count - 1 do
    begin
      currentHeader:= HTTPSender.Headers[i];
      MaxBytes:= GetSizeFromHeader(currentHeader);
      if MaxBytes <> -1 then break;
    end;
  end;

  V := GetEnumName(TypeInfo(THookSocketReason), Integer(Reason)) + ' ' + Value;

  if Reason = THookSocketReason.HR_ReadCount then
  begin
    Bytes:= Bytes + StrToInt(Value);
    ProgressMonitor.ProgressNotification(V, Bytes, MaxBytes);
  end;
end;

function THttpDownloader.GetSizeFromHeader(Header: String): integer;
var
  item : TStringList;
begin
  Result:= -1;

  if Pos('Content-Length:', Header) <> 0 then
  begin
    item:= TStringList.Create();
    item.Delimiter:= ':';
    item.StrictDelimiter:=true;
    item.DelimitedText:=Header;
    if item.Count = 2 then
    begin
      Result:= StrToInt(Trim(item[1]));
    end;
  end;
end;

end.

