unit uNetAssets;

{$mode Delphi}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls, httpsend, blcksock, typinfo,
  uhttpdownloader,  ExtCtrls, Buttons, lclintf, uMain, types, bigini, uAsk;

type

  { TfrmNetAssets }

  TfrmNetAssets = class(TForm)
    btnStop: TBitBtn;
    btnGo: TBitBtn;
    BitBtn3: TBitBtn;
    btnUn: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblURL: TLabel;
    lvNetAssets: TListView;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pbarTiny: TProgressBar;
    pbar: TProgressBar;
    procedure btnStopClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure btnUnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure lblURLClick(Sender: TObject);
  private
    { private declarations }
    Bail : Boolean;
    Downloader : ThttpDownloader;
    HTTPSender: THTTPSend;
    MaxBytes, Bytes : Integer;
    function URLDown2(filename, url: string) : Boolean;
    procedure Status(Sender: TObject; Reason: THookSocketReason; const Value: String);
  public
    { public declarations }
  end;

var
  frmNetAssets: TfrmNetAssets;

implementation

{$R *.lfm}

{ TfrmNetAssets }

function GetSizeFromHeader(Header: String): integer;
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

procedure TfrmNetAssets.Status(Sender: TObject; Reason: THookSocketReason; const Value: String);
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
    Bytes := Bytes + StrToInt(Value);
  end;
  pbarTiny.Max := MaxBytes;
  pbarTiny.Position := Bytes;
  application.processMessages;
end;

procedure TfrmNetAssets.Label1Click(Sender: TObject);
var
  a : Integer;
begin
  for a := 0 to lvNetAssets.items.count - 1 do lvNetAssets.Items.item[a].Checked:=True;
end;

procedure TfrmNetAssets.FormCreate(Sender: TObject);
var
  ini : TbigInifile;
  A, cnt : Integer;
  new : TListItem;
  typ : String;
  fname : String;
begin
  Downloader := THTTPDownloader.Create();
  if Ask('Use of this feature is at your own risk.' + #10#13 + 'Do you understand this?') = mrYes then
  begin
    DeleteFile(FrmMain.Dir.FUserDirectory + 'NetRes.ini');
    frmMain.URLDownload(FrmMain.Dir.FUserDirectory + 'NetRes.ini', 'http://software.lucifael.com/delite/delite.netres');
    ini := TBigInifile.create(FrmMain.Dir.FUserDirectory + 'NetRes.ini');
    try
       // Work through file creating the entries
      Caption := 'Internet Resources - Update: ' + ini.ReadString('Header', 'LastUpdate', 'Unknown');
      cnt := ini.ReadInteger('Header', 'Entries', -1);
      for a := 0 to cnt do
      begin
        new := lvNetAssets.items.add;
        new.caption := ini.ReadString('Entry'+IntToStr(a), 'Name', '');
        typ := ini.ReadString('Entry'+IntToStr(a), 'Type', '');
        new.Subitems.add(Typ);
        typ := lowercase(typ);
        new.Subitems.add(ini.ReadString('Entry'+IntToStr(a), 'URL', ''));
        fname := ini.ReadString('Entry'+IntToStr(a), 'FName', '');
        if typ = 'wizard' then fname := frmMain.Dir.FWizDirectory + fname
        else if typ = 'template' then fname := frmMain.Dir.FTemplateDirectory + fname
        else if typ = 'snip' then fname := frmMain.Dir.FSnipDirectory + fname
        else if typ = 'help' then fname := frmMain.Dir.FHelpDirectory + fname
        else if typ = 'tool' then fname := frmMain.Dir.FToolDirectory + fname
        else if typ = 'unit' then fname := frmMain.Dir.FUnitDirectory + fname
        else if typ = 'tip' then fname := frmMain.Dir.FTipDirectory + fname
        else if typ = 'themes' then fname := frmMain.Dir.FThemeDirectory + fname
        else if typ = 'examples' then fname := frmMain.Dir.FExamDirectory + fname;
        new.Subitems.add(fname);
        new.Subitems.add(ini.ReadString('Entry'+IntToStr(a), 'Comments', ''));
      end;
    finally
      ini.free;
    end;
  end else close;
end;

procedure TfrmNetAssets.btnStopClick(Sender: TObject);
begin
  Bail := true;
end;

procedure TfrmNetAssets.btnGoClick(Sender: TObject);
var
  A : Integer;
  filename, url : String;
  new : TListItem;
begin
  Bail := false;
  pbar.position := 0;
  pbarTiny.Style := pbstMarquee;
  btnGo.enabled := false;
  btnStop.enabled := True;
  btnUn.Enabled := false;
  pbar.Max:= lvNetAssets.items.count - 1;
  for a := 0 to lvNetAssets.items.count - 1 do
  begin
       new := lvNetAssets.Items.item[a];
       if new.checked then
       begin
         filename := new.Subitems[2];
         url := new.Subitems[1];
         URLDown2(Filename, URL);
//         frmMain.URLDownload(filename, url);
         pbar.position := a;
         application.ProcessMessages;
         if bail then exit;
         application.ProcessMessages;
       end;
  end;
  if bail then ShowMessage('Quit procedure before finish');
  pbar.position := 0;
   btnGo.enabled := true;
   btnStop.enabled := false;
   btnUn.Enabled := true;
   pbarTiny.Style := pbstNormal;
end;

procedure TfrmNetAssets.btnUnClick(Sender: TObject);
var
  a : Integer;
  fname : String;
begin
  pbar.Max := lvNetAssets.Items.count - 1;
  pbar.position := 0;
  for a := 0 to lvNetAssets.Items.Count - 1 do
  begin
       if lvNetAssets.items.item[a].Checked then
       begin
         if fileExists(lvNetAssets.Items.item[a].SubItems[2]) then DeleteFile(lvNetAssets.Items.item[a].SubItems[2]);
         pbar.position := 0;
         application.ProcessMessages;
       end;
  end;
  pbar.position := 0;
end;

procedure TfrmNetAssets.Label2Click(Sender: TObject);
var
  a : Integer;
begin
  for a := 0 to lvNetAssets.items.count - 1 do lvNetAssets.Items.item[a].Checked:=false;
end;

procedure TfrmNetAssets.Label3Click(Sender: TObject);
var
  a : Integer;
begin
  for a := 0 to lvNetAssets.items.count - 1 do lvNetAssets.Items.item[a].Checked := not lvNetAssets.Items.item[a].Checked;
end;

procedure TfrmNetAssets.lblURLClick(Sender: TObject);
begin
     OpenDocument(TButton(sender).hint);
end;

function tfrmNetAssets.URLDown2(filename, url: string) : Boolean;
var
  l: TFileStream;
begin
  HTTPSender := THTTPSend.Create;
  HTTPSender.UserAgent:= 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1';
  HTTPSender.Sock.OnStatus:= Status;
  if fileExists(filename) then
    deleteFile(filename);
//  l := TFileStream.Create(filename, fmCreate);
  try
    if not HTTPSender.HTTPMethod('GET', url) then
    begin
      // It Failed!
      result := false;
    end else
    begin
      //        ShowMessage(IntToStr(Http.Resultcode)+ ' '+ Http.Resultstring);
      //        ShowMessage(Http.headers.text);
      if (HTTPSender.ResultCode >= 100) and (HTTPSender.ResultCode<=299) then
      begin
           if FileExists(Filename) then deleteFile(Filename);
           HTTPSender.Document.SaveToFile(Filename);
           Result := True;
      end;
    end;
  finally
    HTTPSender.Free;
//    l.Free;
  end;
end;


end.

