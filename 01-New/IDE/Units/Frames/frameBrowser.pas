unit frameBrowser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, dialogs, IpHtml, Forms, Controls, ComCtrls, StdCtrls,
  ExtCtrls, lclintf, synautil, graphics, httpSend,  windows, uStrTools;

type
  TSimpleIpHtml = class(TIpHtml)
  public
    property OnGetImageX;

  end;



type

  { TframeBrowser }

  TframeBrowser = class(TFrame)
    btnSearchHelp: TToolButton;
    cboHelp: TComboBox;
    ilHelp: TImageList;
    lvHelpSearch: TListView;
    Panel4: TPanel;
    pnlHelpSearch: TPanel;
    Splitter1: TSplitter;
    htmHelp: TIpHtmlPanel;
    ToolBar1: TToolBar;
    ToolBar3: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton45: TToolButton;
    ToolButton46: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    tvHelp: TTreeView;
    txtHelpSearch: TEdit;
    procedure htmHelpHotClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure HTMLGetImageX(Sender: TIpHtmlNode; const URL: string; var Picture: TPicture);
    procedure tvHelpClick(Sender: TObject);
  private
    { private declarations }
    OnLineMode : Boolean;
    Online_Root : String;
    procedure LoadHelpFile(const filename : String);
    procedure LoadHelpAbout(const filename : String);
    procedure LoadHelpURL(const URL : String);
  public
    { public declarations }
    procedure LoadFromFIle(const fname : String);
    procedure URLDownload(filename, url: string);
    procedure URLDownloadStream(filestream: TStringList; url: string);
  end;

implementation

{$R *.lfm}

// Internet functionality

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


procedure TframeBrowser.URLDownload(filename, url: string);
var
  HTTP: THTTPSend;
  l: TFileStream;
begin
  HTTP := THTTPSend.Create;
  http.UserAgent:= 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1';
  if fileExists(filename) then
    deleteFile(pchar(filename));
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

procedure TframeBrowser.URLDownloadStream(filestream: TStringList; url: string);
var
  HTTP: THTTPSend;
  ResCode : Integer;
  ResString : String;
begin
  HTTP := THTTPSend.Create;
  http.UserAgent:= 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1';
  try
    if not HTTP.HTTPMethod('GET', url) then
    begin
      // Handle redirect's here I think?
      ResCode := Http.Resultcode;
      ResString := http.ResultString;
      if ResCode = 302 then
      begin
        URLDownloadStream(FileStream, ResString);
      end;
    end
    else
    begin
         FileStream.LoadFromStream(http.document);
    end;
  finally
    HTTP.Free;
  end;
end;

procedure TframeBrowser.LoadHelpURL(const URL: String);
var
  response: String;
  NewHTML: TSimpleIpHtml;
  html: TStringStream;
begin
 // Load a url instead of a file
 OnLineMode := True;
 Online_Root := 'http://' + ExtractURLServer(URL) + ExtractURLPath(url);
 response := httpGet(url);
 html := TStringStream.Create(response);
 try
    NewHTML := TSimpleIpHtml.Create;
    NewHTML.OnGetImageX := @HTMLGetImageX;
    NewHTML.LoadFromStream(html);
    htmHelp.SetHtml(NewHTML);
 finally
   html.Free;
 end;
// showMessage('Unable to handle online files at this time.');
end;



{ TframeBrowser }

procedure TframeBrowser.HTMLGetImageX(Sender: TIpHtmlNode; const URL: string; var Picture: TPicture);
var
  PicCreated: boolean;
  s: TMemoryStream;
  newURL : String;
begin
 NewURL := URL;
 if not OnLineMode then
 begin
  try
    if FileExistsUTF8(ExtractFilePath(ParamStr(0)) + '\Help\' + URL) then begin
      PicCreated := False;
      if Picture=nil then begin
        Picture:=TPicture.Create;
        PicCreated := True;
      end;
      Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\Help\' + URL);
//      ShowMessage(url);
    end;
  except
    if PicCreated then
      Picture.Free;
    Picture := nil;
  end;
 end else
 begin
   s := TMemoryStream.Create;
   try
     PicCreated := false;
     if pos('HTTP:', uppercase(NewURL))<=0 then NewURL := OnLine_Root + NewURL;
     httpGetStream(NewURL,s);
     if Picture = nil then
     begin
       Picture := TPicture.Create;
       Picture.LoadFromStream(s);
     end;
   except
     if PicCreated then Picture.Free;
     Picture := nil;
   end;
   s.Free;
 end;
end;

procedure TframeBrowser.tvHelpClick(Sender: TObject);
begin
 if tvHelp.Selected<>nil then
 begin
      if tvHelp.selected.level=1 then
      begin
           LoadHelpFile(extractFilePath(ParamStr(0)) + 'Help\' + tvHelp.selected.Text + '.html');
           cboHelp.ItemIndex := cboHelp.Items.count - 1;
      end;
 end;
end;

procedure TframeBrowser.ToolButton8Click(Sender: TObject);
begin
     Toolbutton8.down := not toolbutton8.down;
     pnlHelpSearch.visible := toolButton8.down;
     tvHelp.visible := ToolButton8.down;
     Splitter1.visible := ToolButton8.down;
end;

procedure TframeBrowser.htmHelpHotClick(Sender: TObject);
var
  NodeA: TIpHtmlNodeA;
  NewFilename: String;
begin
  if htmHelp.HotNode is TIpHtmlNodeA then begin
    NodeA := TIpHtmlNodeA(htmHelp.HotNode);
    NewFilename := NodeA.HRef;
    if extractFilePath(NewFilename) = '' then NewFilename := ExtractFilePath(ParamStr(0)) + 'help\' + NewFilename;
    LoadHelpFile(NewFilename);
//    self.FocusControl(TWinControl(seEDit));
  end;
end;

procedure TframeBrowser.ToolButton1Click(Sender: TObject);
begin
 LoadHelpFile(ExtractFilepath(ParamStr(0)) + 'Interface\home.html');
end;

procedure TframeBrowser.ToolButton3Click(Sender: TObject);
begin
  if cboHelp.ItemIndex > 0 then cboHelp.ItemIndex := cboHelp.ItemIndex - 1;
  LoadHElPFile(cboHelp.items[cboHelp.ItemIndex]);
end;

procedure TframeBrowser.ToolButton5Click(Sender: TObject);
begin
  if cboHelp.ItemIndex < cboHelp.items.count - 1 then cboHelp.ItemIndex := cboHelp.ItemIndex + 1;
  LoadHElPFile(cboHelp.items[cboHelp.ItemIndex]);
end;

procedure TframeBrowser.ToolButton7Click(Sender: TObject);
begin
  if cboHelp.text<>'' then LoadHelpFile(cboHelp.text);
  cboHelp.ItemIndex := cboHelp.Items.count - 1;
end;

procedure TframeBrowser.LoadHelpFile(const filename : String);
var
  fs: TFileStream;
  NewHTML: TSimpleIpHtml;
begin
  //ShowMessage(ExtractFilePath(ParamStr(0)) + 'Help\Blank.html');
  if pos('HTTP:', uppercase(filename))>0 then LoadHelpURL(Filename);
  if pos('ABOUT:', uppercase(filename))>0 then LoadHelpAbout(Filename);
  if fileExists(Filename) then
  begin
    //ShowMEssage('In');
    OnLineMode := false;
  try
    fs:=TFileStream.Create(UTF8ToSys(Filename),fmOpenRead);
    try
      NewHTML:=TSimpleIpHtml.Create; // Beware: Will be freed automatically by htmReports
      NewHTML.OnGetImageX:=@HTMLGetImageX;
      NewHTML.LoadFromStream(fs);
    finally
      fs.Free;
    end;
    htmHelp.SetHtml(NewHTML);
    cbohelp.items.add(filename);
  except
    on E: Exception do
    begin
//      ShowTip('Unable to open HTMLFile' + #10#13 + ExtractFilename(Filename));
    end;
  end;
  end else
  begin
//      ShowTip('Missing ' + Filename + #10#13 + 'For Loading into HTML Viewer');
  end;
end;

procedure TframeBrowser.LoadHelpAbout(const filename : String);
var
  fs: TFileStream;
  NewHTML: TSimpleIpHtml;
  fname : String;
begin
  //ShowMessage(ExtractFilePath(ParamStr(0)) + 'Help\Blank.html');
  if pos('ABOUT:FILE', uppercase(filename))>0 then
  begin
       // Special case to load an external file or function
       // split after file to get the paramater list
       fname := '';
  end;
  if pos(':HOME', uppercase(filename))>0 then fname := extractFilePath(ParamStr(0)) + 'Interface\index.html';
  if pos(':VERSION', uppercase(filename))>0 then fname := extractFilePath(ParamStr(0)) + 'Interface\version.html';
  if pos(':BLANK', uppercase(filename))>0 then fname := extractFilePath(ParamStr(0)) + 'Interface\blank.html';
  if fileExists(fname) then
  begin
    //ShowMEssage('In');
    OnLineMode := false;
  try
    fs:=TFileStream.Create(UTF8ToSys(Filename),fmOpenRead);
    try
      NewHTML:=TSimpleIpHtml.Create; // Beware: Will be freed automatically by htmReports
      NewHTML.OnGetImageX:=@HTMLGetImageX;
      NewHTML.LoadFromStream(fs);
    finally
      fs.Free;
    end;
    htmHelp.SetHtml(NewHTML);
    cbohelp.items.add(filename);
  except
    on E: Exception do
    begin
      ShowMessage('Unable to open HTMLFile' + #10#13 + ExtractFilename(Filename));
    end;
  end;
  end else
  begin
      ShowMessage('Missing ' + Filename + #10#13 + 'For Loading into HTML Viewer');
  end;
end;

procedure TframeBrowser.LoadFromFIle(const fname : String);
begin
 LoadHelpFile(Fname);
end;



end.

