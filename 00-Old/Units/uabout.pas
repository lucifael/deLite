unit uAbout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Buttons, StdCtrls, lclintf, httpsend, VersionInfo;

type

  { TfrmAbout }

  TfrmAbout = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnGetUpdate: TBitBtn;
    Label16: TLabel;
    lblLinkRichEdit4: TLabel;
    memBlur: TMemo;
    memUpdates: TMemo;
    txtCurrVer: TEdit;
    ilAbout: TImageList;
    Image1: TImage;
    imgHeader: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblLinkRichEdit: TLabel;
    lblLinkRichEdit1: TLabel;
    lblLinkRichEdit2: TLabel;
    lblLinkRichEdit3: TLabel;
    nbAbout: TNotebook;
    Page1: TPage;
    Page2: TPage;
    Page3: TPage;
    Page4: TPage;
    Page5: TPage;
    Panel1: TPanel;
    Panel2: TPanel;
    tvAbout: TTreeView;
    txtOnlineVer: TEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure btnGetUpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure lblLinkRichEditClick(Sender: TObject);
    procedure tvAboutClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAbout: TfrmAbout;



implementation

{$R *.lfm}

uses
  uMain;

{ TfrmAbout }

procedure TfrmAbout.Image1Click(Sender: TObject);
begin
  ShowMessage('This will take you to my Software Homepage, where there is a link');
  OpenDocument('http://software.lucifael.com');
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
var
  ver : TVersionInfo;
begin
  ver := TVersionInfo.Create(ParamStr(0));
  try
    txtCurrVer.text := ver.GetFileVersionWithDots;
  finally
    ver.free;
  end;
end;

procedure TfrmAbout.BitBtn2Click(Sender: TObject);
var
  url, SiteVersion, LocalVersion: string;
  siteStr, LocalStr: TStringList;
begin
  // Version Check
  url := 'http://software.lucifael.com/deLite.html';
  LocalVersion :=  txtCurrVer.text;
  SiteStr := TStringList.Create;
  try
    frmMain.URLDownloadStream(SiteStr, url);
    if SiteSTR.Count <> -1 then
    BEGIN
      SiteVersion := SiteStr[0];
      memUpdates.lines := SiteStr;
    end
    else
      SiteVersion := LocalVersion;
  finally
    SiteStr.Free;
  end;
  txtOnlineVer.text := SiteVersion;
  if LocalVersion <> SiteVersion then
  begin
    btnGetUpdate.enabled := true;
    txtOnlineVer.Font.color := clRed;
  end
  else
  begin
    memUpdates.lines.text := 'You''re all up to date!';
    txtOnlineVer.Font.color := clGreen;
    //sbar.simpleText := 'Version is up to date';
  end;
end;

procedure TfrmAbout.btnGetUpdateClick(Sender: TObject);
begin
  frmMain.URLDownload(frmMain.Dir.FUserDirectory + 'ScriptHost_Inst.exe', 'http://software.lucifael.com/exe/ScriptHost_Inst.exe');
  OpenDocument(frmMain.dir.FUserDirectory + 'ScriptHost_Inst.exe');
end;

procedure TfrmAbout.lblLinkRichEditClick(Sender: TObject);
begin
  with sender as TLabel do
       OpenDocument(hint);
end;

procedure TfrmAbout.tvAboutClick(Sender: TObject);
begin
  if tvAbout.selected<>nil then nbAbout.PageIndex := tvAbout.Selected.StateIndex else nbAbout.PAgeIndex := 0;
end;

end.

