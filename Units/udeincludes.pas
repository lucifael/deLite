unit uDEIncludes;

{$mode objfpc}{$H+}

interface

uses
  Classes, windows, registry, SysUtils, FileUtil, SynHighlighterPas, SynExportHTML,
  SynMemo, IpHtml, Forms, Controls, Graphics, Dialogs, ActnList, Menus,
  ExtCtrls, ComCtrls, Buttons, StdCtrls, uPSComponent, uPSComponent_Default,
  uPSComponent_DB, uPSComponent_Forms, uPSComponent_Controls,
  uPSComponent_StdCtrls, SMNetGradient, uPSCompiler, httpSend, VersionInfo,
  uTools, uStrTools, BigIni, uTip, uAsk, lclintf, MMSystem,
  synautil, ftpSend, uUserPass, {uPSPreProcessor, uPSRuntime,}
  Process, uEncrypt, Base64, uPSRuntime, pingsend, sntpsend, winsock;

// Profile HERE

procedure RunAndPAuse(cmdline: string);
// Registry
function ReadIntFromReg(Reg: TRegistry; Name: string; Def: Integer): Integer;
// List Functions
function GetFileList2(FDirectory, Filter: string; var lst : TStringList; const Recurse : Boolean): boolean;
procedure lst_Copy(var From, ToLst : TStringList);
procedure lst_RemoveDuplicates(var TheList : TStringList);
// Internet Functions
function PingHost2(const Host: string): Integer;
function TraceRouteHost2(const Host: string): string;
function FtpGetFile2(var lst : TStringList): Boolean;
function FtpPutFile2(var lst : TStringList): Boolean;
function NetTime(const host : String) : Boolean;
procedure URLDown(filename, url: string);
function getIPs: Tstrings;
function httpGet(URL: String): String;
procedure httpGetStream(URL: String; var s: TMemoryStream);
// Ini Functions
function ini_ReadString(const filename, section, variable, default : String) : String;
Procedure ini_WriteString(const filename, section, variable, Value : String);
function ini_ReadInteger(const filename, section, variable : String; Default : Integer) : Integer;
Procedure ini_WriteInteger(const filename, section, variable: String; Value : Integer);
Procedure ini_ReadList(const filename, section : String; Default : string; var lst : TStringList);
Procedure ini_WriteList(const filename, section : String; Var Lst : TStringList);
// MMS
procedure snd_PlayASound(FileName: string);
procedure SendMCI(const str : String);
// Dialog Functions
function dlg_Open(Title, Filter : String) : String;
function dlg_Color(Title : String) : TColor;
function dlg_Save(Title, Filter, DefaultEXT : String) : String;
// System
procedure SetWallpaper(const Filename : String; const style : Integer);
function getWinVer: String;



implementation

// Actual Stuff HERE

// Helper function to read registry values, and
// deal with cases where no values exist
function ReadIntFromReg(Reg: TRegistry; Name: string; Def: Integer): Integer;
  {Reads integer with given name from registry
  and returns it. If no such value exists, returns
  Def default value}
begin
 if Reg.ValueExists(Name) then
    Result := Reg.ReadInteger(Name)
  else
    Result := Def;
end;


function GetFileList2(FDirectory, Filter: string; var lst : TStringList; const Recurse : Boolean): boolean;
var
   ARec: TSearchRec;
   Res: Integer;
begin
     if FDirectory[Length(FDirectory)] <> '\' then FDirectory := FDirectory + '\';
     //ShowMEssage(FDirectory);
     try
        Res := FindFirst(FDirectory + Filter, faAnyFile, ARec);
        if Res=0 then
        begin
          repeat
            if FileExists(FDirectory + ARec.Name) then lst.Add(FDirectory + ARec.Name);
          until FindNExt(ARec)<>0;
        end;
        if Recurse then
        begin
             if (ARec.Attr and faDirectory) = faDirectory then
                if ARec.Name <> '.' then
                   if ARec.Name<>'..' then GetFileList2(FDirectory + ARec.NAme, filter, lst, true);
        end;
        FindClose(ARec);
        REsult := true;
        except
              lst.clear;
              Result := false;
        end;

end;

procedure RunAndPAuse(cmdline: string);
var
  AProcess: TProcess;
begin
  // Now we will create the TProcess object, and
  // assign it to the var AProcess.
  AProcess := TProcess.Create(nil);

  // Tell the new AProcess what the command to execute is.
  AProcess.CommandLine := cmdline;

  // We will define an option for when the program
  // is run. This option will make sure that our program
  // does not continue until the program we will launch
  // has stopped running.
  // poNoConsole
  AProcess.Options := AProcess.Options + [poWaitOnExit];
  AProcess.ShowWindow := swoHIDE;
  // Now that AProcess knows what the commandline is
  // we will run it.
  AProcess.Execute;
  // This is not reached until ppc386 stops running.
  AProcess.Free;
end;



function PingHost2(const Host: string): Integer;
begin
  with TPINGSend.Create do
  try
    Result := -1;
    if Ping(Host) then
    begin
      if ReplyError = IE_NoError then
      begin
        Result := PingTime;
      end;
    end;
  finally
    Free;
  end;
end;

function TraceRouteHost2(const Host: string): string;
var
  Ping: TPingSend;
  ttl : byte;
begin
  Result := '';
  Ping := TPINGSend.Create;
  try
    ttl := 1;
    repeat
      ping.TTL := ttl;
      inc(ttl);
      if ttl > 30 then
        Break;
      if not ping.Ping(Host) then
      begin
        Result := Result + Host + ' Timeout' + CRLF;
        continue;
      end;
      if (ping.ReplyError <> IE_NoError)
        and (ping.ReplyError <> IE_TTLExceed) then
      begin
        Result := Result + Ping.ReplyFrom + ' ' + Ping.ReplyErrorDesc + CRLF;
        break;
      end;
      Result := Result + Ping.ReplyFrom + ' ' + IntToStr(Ping.PingTime) + CRLF;
    until ping.ReplyError = IE_NoError;
  finally
    Ping.Free;
  end;
end;


function FtpGetFile2(var lst : TStringList): Boolean;
var
   IP, Port, Dir, Filename, LocalFilename, User, Pass : String;
begin
  Result := False;
 if lst.count>=6 then
 begin
      IP := lst[0];
      Port := lst[1];
      Dir := lst[2];
      Filename := lst[3];
      LocalFilename := lst[4];
      User := lst[5];
      Pass := lst[6];
 end else exit;
  with TFTPSend.Create do
  try
    if User <> '' then
    begin
      Username := User;
      Password := Pass;
    end;
    TargetHost := IP;
    TargetPort := Port;
    if not Login then
    begin
      Exit;
    end;
    ChangeWorkingDir(Dir);
    AutoTLS := true;
    DirectFileName := LocalFilename;
    DirectFile:=True;
    Result := RetrieveFile(FileName, False);
    Logout;
  finally
    Free;
  end;
end;


function NetTime(const host : String) : Boolean;
var
   net : TSNTPSend;
begin
     net := TSNTPSend.Create;
     try
        net.TargetHost:=host;
        net.SyncTime:= True;
        net.MaxSyncDiff:=360000;
        result := net.GetNTP;
     finally
       net.free;
       result := false;
     end;
end;

function FtpPutFile2(var lst : TStringList): Boolean;
var
   IP, Port, Dir, Filename, LocalFilename, User, Pass : String;
begin
  Result := False;
  if lst.count>=6 then
  begin
       IP := lst[0];
       Port := lst[1];
       Dir := lst[2];
       Filename := lst[3];
       LocalFilename := lst[4];
       User := lst[5];
       Pass := lst[6];
  end else exit;
//  Filename := extractFilename(LocalFilename);
{  ShowMessage('IP: ' + IP + #10#13+
  'PORT: ' + Port + #10#13+
  'Remote Dir: ' + Dir + #10#13+
  'Remote: ' + Filename + #10#13+
  'Local: ' + LocalFilename + #10#13+
  'User: ' + User + #10#13+
  'Pass: ' + Pass);
}
  with TFTPSend.Create do
  try
    PassiveMode := true;
    if User <> '' then
    begin
      Username := User;
      Password := Pass;
    end;
    TargetHost := IP;
    TargetPort := Port;
    if not Login then
    begin
      Exit;
    end;
    ChangeWorkingDir(Dir);
    AutoTLS := true;
    DirectFileName := LocalFilename;
    DirectFile := True;
    Result := StoreFile(Filename, false);
    Logout;
  finally
    Free;
  end;
end;

function ini_ReadString(const filename, section, variable, default : String) : String;
var
   ini : TBiginifile;
begin
     ini := TBiginifile.create(filename);
     try
       result := ini.ReadString(Section, variable, default);
     finally
       ini.free;
     end;
end;

Procedure ini_WriteString(const filename, section, variable, Value : String);
var
   ini : TBiginifile;
begin
     ini := TBiginifile.create(filename);
     try
       ini.WriteString(Section, variable, Value);
     finally
       ini.free;
     end;
end;


function ini_ReadInteger(const filename, section, variable : String; Default : Integer) : Integer;
var
   ini : TBiginifile;
begin
     ini := TBiginifile.create(filename);
     try
       result := ini.ReadInteger(Section, variable, default);
     finally
       ini.free;
     end;
end;

Procedure ini_WriteInteger(const filename, section, variable: String; Value : Integer);
var
   ini : TBiginifile;
begin
     ini := TBiginifile.create(filename);
     try
       ini.WriteInteger(Section, variable, Value);
     finally
       ini.free;
     end;
end;

Procedure ini_ReadList(const filename, section : String; Default : string; var lst : TStringList);
var
   ini : TBiginifile;
begin
     ini := TBiginifile.create(filename);
     try
       ini.ReadNumberedList(Section, Lst, default);
     finally
       ini.free;
     end;
end;

Procedure ini_WriteList(const filename, section : String; Var Lst : TStringList);
var
   ini : TBiginifile;
begin
     ini := TBiginifile.create(filename);
     try
       ini.WriteNumberedList(Section, Lst);
     finally
       ini.free;
     end;
end;

procedure snd_PlayASound(FileName: string);
begin
  if fileexists(Filename) then
  begin
    sndPlaySound(PChar(Filename), SND_NODEFAULT or SND_ASYNC);
  end;
end;

procedure lst_Copy(var From, ToLst : TStringList);
var
  A : Integer;
begin
 for a := 0 to From.count - 1 do toLst.add(from[a]);
end;

procedure lst_RemoveDuplicates(var TheList : TStringList);
var
  A : Integer;
  NewLst : TStringList;
begin
 NewLst := TStringList.create;
 try
   for a := 0 to TheList.count - 1 do
   begin
     if Newlst.IndexOf(TheList[a])=-1 then NewLST.add(TheList[a]);
   end;
   TheList.clear;
   TheList.Assign(NewLst);
 finally
   NewLst.free;
 end;
end;

function dlg_Open(Title, Filter : String) : String;
var
  dlgGOpen : TOpenDialog;
begin
 result := '';
 dlgGOpen := TOpenDialog.create(application);
 try
   dlgGOpen.title := Title;
   dlgGOpen.Filter := Filter;
   if dlgGOpen.execute then
   begin
        result := dlgGOpen.Filename;
   end;
 finally
   dlgGOpen.free;
 end;
end;

function dlg_Save(Title, Filter, DefaultEXT : String) : String;
var
  dlgGenSave : TOpenDialog;
begin
 result := '';
 dlgGenSave := TOpenDialog.create(application);
 try
   dlgGenSave.title := Title;
   dlgGenSave.Filter := Filter;
   dlgGenSave.DefaultExt := DefaultEXT;
   if dlgGenSave.execute then
   begin
        result := dlgGenSave.Filename;
   end;
 finally
   dlgGenSave.free;
 end;
end;

function dlg_Color(Title : String) : TColor;
var
  dlgGenColor : TColorDialog;
begin
 result := clWhite;
 dlgGenColor := TColorDialog.create(application);
 try
   dlgGenColor.title := Title;
   if dlgGenColor.execute then
   begin
        result := dlgGenColor.Color;
   end;
 finally
   dlgGenColor.free;
 end;
end;

procedure URLDown(filename, url: string);
var
  HTTP: THTTPSend;
  l: TFileStream;
begin
  HTTP := THTTPSend.Create;
  http.UserAgent:= 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1';
  if fileExists(filename) then
    deleteFile(filename);
  l := TFileStream.Create(filename, fmCreate);
  try
    if not HTTP.HTTPMethod('GET', url) then
    begin
      // ShowMessage('ERROR');
    end
    else
    begin
      //        ShowMessage(IntToStr(Http.Resultcode)+ ' '+ Http.Resultstring);
      //        ShowMessage(Http.headers.text);
      http.document.SaveToStream(l);
    end;
  finally
    HTTP.Free;
    l.Free;
  end;
end;

procedure SetWallpaper(const Filename : String; const style : Integer);
var
  reg : TRegIniFile;
  st : Integer;
begin
     reg := TRegIniFile.create('Control Panel\Desktop');
     try
       st := Style;
       if Style = 1 then
       begin
            st := 0;
            reg.WriteInteger('', 'TileWallpaper', 1);
       end else reg.WriteInteger('', 'TileWallpaper', 0);
       reg.WriteInteger('', 'WallpaperStyle', style);
       reg.WriteString('', 'Wallpaper', Filename);
     finally
       reg.free;
     end;
     SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, nil, SPIF_SENDWININICHANGE);
end;

procedure SendMCI(const str : String);
begin
     // This single command should open up using MCI
     MCISendString(PChar(str), nil, 0, 0);
end;

function getIPs: Tstrings;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: array[0..63] of Char;
  I: Integer;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := TstringList.Create;
  Result.Clear;
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  I    := 0;
  while pPtr^[I] <> nil do
  begin
    Result.Add(inet_ntoa(pptr^[I]^));
    Inc(I);
  end;
  WSACleanup;
end;

{$IFDEF MSWINDOWS}
function getWinVer: String;
var
  VerInfo: TOSVersioninfo;
begin
  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VerInfo);
  Result := 'Windows NT '+IntToStr(VerInfo.dwMajorVersion) + '.' + IntToStr(VerInfo.dwMinorVersion)
end;
{$ENDIF}

function httpGet(URL: String): String;
var
  HTTP: THTTPSend;
  l: TStrings;
  OS: String;
begin
  Result := '';
  l := TStringList.Create;
  HTTP := THTTPSend.Create;
  http.UserAgent:= 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1';
  if HTTP.HTTPMethod('GET', URL) then
  begin
    l.LoadFromStream(Http.Document);
    Result := l.Text;
  end;
  HTTP.Free;
  l.Free;
end;

procedure httpGetStream(URL: String; var s: TMemoryStream);
var
  HTTP: THTTPSend;
  OS: String;
begin
  {$ifdef Windows}
    OS := getWinVer;
  {$endif}
  {$ifdef Linux}
    OS := 'Linux';
  {$endif}
  {$ifdef FreeBSD}
    OS := 'FreeBSD';
  {$endif}
  {$ifdef Darwin}
    OS := 'OSX';
  {$endif}
  HTTP := THTTPSend.Create;
  http.UserAgent:= 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1';
  if HTTP.HTTPMethod('GET', URL) then
  begin
    s.Clear;
    s.LoadFromStream(Http.Document);
  end;
  HTTP.Free;
end;




end.

