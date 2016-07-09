unit uMain;

{$mode objfpc}{$H+}

interface


// Can I Have - Form Designer To Do
{
Yes To All These
btn : TBitBtn;
img : TImage;
shp : TShape;
bvl : TBevel;
bn : TNotebook;
pg : TPage;
ScrollBox : TScrollbox;
SB : TSpeedButton;
pntBox : TPaintBox;
Timer : TTimer;
}

uses
  Classes, windows, SysUtils, FileUtil, SynHighlighterPas, SynExportHTML,
  SynMemo, IpHtml, Forms, Controls, Graphics, Dialogs, ActnList, Menus,
  ExtCtrls, ComCtrls, Buttons, StdCtrls, uPSComponent, uPSComponent_Default,
  uPSComponent_DB, uPSComponent_Forms, uPSComponent_Controls,
  uPSComponent_StdCtrls, uPSCompiler, httpSend, VersionInfo,
  uTools, uStrTools, BigIni, uTip, uAsk, lclintf,
  synautil, uUserPass, {uPSPreProcessor, uPSRuntime,}
  uEncrypt, Base64, {uPSRuntime,}
  uDEIncludes;


type
  TMyTreeNode = class(TTreeNode)
  private
    fmyFilename: String;
//    fExported : Boolean;
  Property
    Filename: String read fmyFilename write fmyFilename;
{  Property
    Intf: Integer read FIntf write FIntf;
  property
    Exported: Boolean read FExported write fExported;
}  end;

type
  TSimpleIpHtml = class(TIpHtml)
  public
    property OnGetImageX;

  end;

type
  TDirectories = Record
    FUserDirectory, FTemplateDirectory,
    FSnipDirectory, FToolDirectory,
    FUnitDirectory, FHelpDirectory,
    FWizDirectory, FExamDirectory,
    FTipDirectory, FThemeDirectory : String;
end;


type

  { TfrmMain }

  TfrmMain = class(TForm)
    actFileSave: TAction;
    actFileSaveAs: TAction;
    actExit: TAction;
    actEditDelete: TAction;
    actHelpContents: TAction;
    actHelpAbout: TAction;
    actEditCommentOut: TAction;
    actEditUnindent: TAction;
    actEditIndent: TAction;
    actExportSourceToHTML: TAction;
    actFileExportHTML: TAction;
    actEditFind: TAction;
    actEditReplace: TAction;
    actSolProperties: TAction;
    actSolDel: TAction;
    actSolAdd: TAction;
    actSolSaveAS: TAction;
    actSolSave: TAction;
    actSolOpen: TAction;
    actSolNew: TAction;
    actToolsMakeSnip: TAction;
    actToolsMakeTemplate: TAction;
    actToolsSettings: TAction;
    actToolsNetAssets: TAction;
    actRunExecute: TAction;
    actRunCompile: TAction;
    actNewWizard: TAction;
    actOpenFile: TAction;
    actNewBlank: TAction;
    actNewTemplate: TAction;
    actEditCut: TAction;
    actEditCopy: TAction;
    actEditPaste: TAction;
    actGotoLine: TAction;
    ActionList1: TActionList;
    cboHelp: TComboBox;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    dlgFind: TFindDialog;
    htmHelp: TIpHtmlPanel;
    NetGradient9: TPanel;
    Panel5: TPanel;
    PSCustomPlugin1: TPSCustomPlugin;
    ToolBar3: TToolBar;
    btnSearchHelp: TToolButton;
    ToolBar4: TToolBar;
    btnGo: TToolButton;
    ToolButton44: TToolButton;
    ToolButton45: TToolButton;
    ToolButton46: TToolButton;
    ilProject: TImageList;
    ilActions: TImageList;
    ilTree: TImageList;
    ilSolution: TImageList;
    ilCompiler: TImageList;
    ilHelp: TImageList;
    lvHelpSearch: TListView;
    lvCompiler: TListView;
    lvTemplates: TListView;
    lvExamples: TListView;
    lvSnips: TListView;
    MainMenu1: TMainMenu;
    memDebug: TMemo;
    memTool: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem54: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem56: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem64: TMenuItem;
    mnuTutorial: TMenuItem;
    mnuSettings: TMenuItem;
    mnuQuickScripts: TMenuItem;
    mnuIntScriptItem: TMenuItem;
    mnuIntScripts: TMenuItem;
    MenuItem40: TMenuItem;
    mnuMRU: TMenuItem;
    mnuTutorials: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    nbEditors: TNotebook;
    NetGradient1: TPanel;
    NetGradient2: TPanel;
    NetGradient3: TPanel;
    NetGradient4: TPanel;
    NetGradient5: TPanel;
    NetGradient6: TPanel;
    NetGradient7: TPanel;
    NetGradient8: TPanel;
    dlgOpenSolution: TOpenDialog;
    dlgAdd: TOpenDialog;
    Page1: TPage;
    Page2: TPage;
    pnlHelpSearch: TPanel;
    Panel4: TPanel;
    pgBlank: TPage;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    pnlSTuff: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pnlData: TPanel;
    popMRU: TPopupMenu;
    popTray: TPopupMenu;
    popSolutionMRU: TPopupMenu;
    PSDllPlugin1: TPSDllPlugin;
    PSImport_Classes1: TPSImport_Classes;
    PSImport_Controls1: TPSImport_Controls;
    PSImport_DateUtils1: TPSImport_DateUtils;
    PSImport_DB1: TPSImport_DB;
    PSImport_Forms1: TPSImport_Forms;
    PSImport_StdCtrls1: TPSImport_StdCtrls;
    dlgExport: TSaveDialog;
    dlgSaveSolution: TSaveDialog;
    dlgReplace: TReplaceDialog;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    sysScript: TPSScript;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    sbar: TStatusBar;
    sysHTML: TSynExporterHTML;
    seEdit: TSynMemo;
    synPas: TSynPasSyn;
    ToolBar2: TToolBar;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton36: TToolButton;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    ToolButton39: TToolButton;
    ToolButton40: TToolButton;
    ToolButton41: TToolButton;
    ToolButton42: TToolButton;
    ToolButton43: TToolButton;
    ToolButton47: TToolButton;
    ToolButton48: TToolButton;
    btnBack: TToolButton;
    btnNext: TToolButton;
    btnSearch: TToolButton;
    ToolButton51: TToolButton;
    btnHome: TToolButton;
    tvHelp: TTreeView;
    tvSolution: TTreeView;
    tsSolution: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton2: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    sysTray: TTrayIcon;
    tvProject: TTreeView;
    tsProject: TTabSheet;
    tsTemplates: TTabSheet;
    tsExamples: TTabSheet;
    tsSnips: TTabSheet;
    tsDebug: TTabSheet;
    tsCompiler: TTabSheet;
    tsTools: TTabSheet;
    txtHelpSearch: TEdit;
    procedure actEditCommentOutExecute(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditDeleteExecute(Sender: TObject);
    procedure actEditFindExecute(Sender: TObject);
    procedure actEditIndentExecute(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
    procedure actEditReplaceExecute(Sender: TObject);
    procedure actEditUnindentExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actFileExportHTMLExecute(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actGotoLineExecute(Sender: TObject);
    procedure actHelpAboutExecute(Sender: TObject);
    procedure actHelpContentsExecute(Sender: TObject);
    procedure actNewBlankExecute(Sender: TObject);
    procedure actNewWizardExecute(Sender: TObject);
    procedure actOpenFileExecute(Sender: TObject);
    procedure actRunCompileExecute(Sender: TObject);
    procedure actRunExecuteExecute(Sender: TObject);
    procedure actSolAddExecute(Sender: TObject);
    procedure actSolDelExecute(Sender: TObject);
    procedure actSolNewExecute(Sender: TObject);
    procedure actSolOpenExecute(Sender: TObject);
    procedure actSolPropertiesExecute(Sender: TObject);
    procedure actSolSaveASExecute(Sender: TObject);
    procedure actSolSaveExecute(Sender: TObject);
    procedure actToolsMakeSnipExecute(Sender: TObject);
    procedure actToolsMakeTemplateExecute(Sender: TObject);
    procedure actToolsNetAssetsExecute(Sender: TObject);
    procedure actToolsSettingsExecute(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnSearchHelpClick(Sender: TObject);
    procedure cboHelpKeyPress(Sender: TObject; var Key: char);
    procedure dlgFindFind(Sender: TObject);
    procedure dlgReplaceReplace(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure htmHelpHotClick(Sender: TObject);
    procedure lvCompilerDblClick(Sender: TObject);
    procedure lvExamplesDblClick(Sender: TObject);
    procedure lvHelpSearchDblClick(Sender: TObject);
    procedure lvSnipsDblClick(Sender: TObject);
    procedure lvTemplatesDblClick(Sender: TObject);
    procedure MenuItem39Click(Sender: TObject);
    procedure MenuItem41Click(Sender: TObject);
    procedure mnuIntScriptItemClick(Sender: TObject);
    procedure mnuIntScriptsClick(Sender: TObject);
    procedure mnuMRUClick(Sender: TObject);
    procedure mnuQuickClick(Sender: TObject);
    procedure mnuQuickScriptsClick(Sender: TObject);
    procedure mnuTutorialClick(Sender: TObject);
    procedure mnuTutorialsClick(Sender: TObject);
    procedure popMRUPopup(Sender: TObject);
    procedure popSolutionMRUPopup(Sender: TObject);
    procedure popTrayPopup(Sender: TObject);
    procedure seEditChange(Sender: TObject);
    procedure seEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure sysScriptCompile(Sender: TPSScript);
    procedure sysScriptCompImport(Sender: TObject; x: TPSPascalCompiler);
    function sysScriptNeedFile(Sender: TObject; const OrginFileName: string;
      var FileName, Output: string): Boolean;
    procedure ToolButton46Click(Sender: TObject);
    procedure tvHelpClick(Sender: TObject);
    procedure tvProjectClick(Sender: TObject);
    procedure HTMLGetImageX(Sender: TIpHtmlNode; const URL: string;
      var Picture: TPicture);
    procedure tvSolutionCreateNodeClass(Sender: TCustomTreeView;
      var NodeClass: TTreeNodeClass);
    procedure tvSolutionDblClick(Sender: TObject);
    procedure txtHelpSearchKeyPress(Sender: TObject; var Key: char);
  private
    { private declarations }
    Function GetByState(IdX : Integer) : TTreeNode;
    Function GetSByState(IdX : Integer) : TTreeNode;
    procedure SaveAsk;
    procedure MakeLists;
    procedure ADDToMRU(const fname : String);
    procedure ADDToSolMRU(const fname : String);
    procedure LoadHelpFile(const filename : String);
    procedure LoadTheme(Const filename : String);
  public
    { public declarations }
    FSiteVersion, FVersionInfo : String;
    Dir : TDirectories;
    FTipDir, FFilename, FSettingsFile, FLastProj : String;
    FOKNext, FFirstRun : Boolean;
    FDefaultBlank : String;
    FCurrentTheme : String;
    FSolution : String;
    FSolutionLoaded : Boolean;
    fPos:integer;
    found:boolean;
    OnLineMode : Boolean;
    Online_Root : String;
    function GetFileList(FDirectory, Filter: TFileName; var lst : TStringList): boolean;
    procedure URLDownload(filename, url: string);
    procedure URLDownloadStream(filestream: TStringList; url: string);
    procedure DoVErsionCheck;
    Procedure SaveFile(const Fname : String);
    procedure CompileFile(Const FName : String);
    procedure RunFile(Const FName : String);
    procedure LoadFile(const fname : String);
    procedure NewSolution;
    procedure LoadSolution(const Fname : String);
    procedure SaveSolution(const Fname : String);
    function IsInSolution(const ToCheck : String) : Boolean;
    procedure SetBottom;
    procedure LoadHelpURL(const URL : String);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

uses uNetAssets, uAbout, uTipOfTheDay, uSettings, UNewWithWizard,
  uSolution, uGotoLine;

{ SysScript Special Functions }

procedure setSelLength(var textComponent:TSynMemo; newValue:integer);
begin
     textComponent.SelEnd := textComponent.SelStart + newValue;
end;

procedure MWrites(const s: string);
begin
  frmMain.memDebug.lines.add(s);
end;


Procedure de_refreshEditor;
begin
 if frmMain.FFilename<>'' then frmMain.LoadFile(frmMain.FFilename);
end;



function StringLoadFile(const Filename: string): string;
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(Filename, fmOpenread or fmSharedenywrite);
  try
    SetLength(Result, Stream.Size);
    Stream.Read(Result[1], Length(Result));
  finally
    Stream.Free;
  end;
end;


procedure MWritedt(d : TDateTime);
var
 s: String;
begin
  s:= DateToStr(d) + ' ' + TimeToStr(d);
  frmMain.memDebug.lines.add(s);
end;


procedure MWritei(const i: Integer);
begin
  frmMain.memDebug.lines.add(inttostr(i));
end;

procedure MVal(const s: string; var n, z: Integer);
begin
  Val(s, n, z);
end;

{
CreateDir(Dir.FUserDirectory);
CreateDir(Dir.FTemplateDirectory);
CreateDir(Dir.FSnipDirectory);
CreateDir(Dir.FToolDirectory);
CreateDir(Dir.FHelpDirectory);
CreateDir(Dir.FUnitDirectory);
CreateDir(Dir.FWizDirectory);
CreateDir(Dir.FExamDirectory);
CreateDir(Dir.FTipDirectory); }

function de_ReturnUser : String;
begin
  result := frmMain.Dir.FUserDirectory;
end;

function de_ReturnTemplate : String;
begin
  result := frmMain.Dir.FTemplateDirectory;
end;

function de_ReturnSnip : String;
begin
  result := frmMain.Dir.FSnipDirectory;
end;

function de_ReturnTool : String;
begin
  result := frmMain.Dir.FToolDirectory;
end;

function de_ReturnHelp : String;
begin
  result := frmMain.Dir.FHelpDirectory;
end;

function de_ReturnUnit : String;
begin
  result := frmMain.Dir.FUnitDirectory;
end;

function de_ReturnExam : String;
begin
  result := frmMain.Dir.FExamDirectory;
end;

function de_ReturnScript : String;
begin
  result := frmMain.FFilename;
end;

function de_ReturnScriptPath : String;
begin
  result := ExtractFilePath(frmMain.FFilename);
end;

function de_GetSelText : String;
begin
  result := frmMain.seEdit.SelText;
end;

Procedure de_SetSelText(SelText : String);
begin
  frmMain.seEdit.SelText := SelText;
end;

{ TfrmMain }

procedure TfrmMain.mnuTutorialClick(Sender: TObject);
begin
  OpenDocument(TmenuItem(Sender).hint);
end;

procedure TfrmMain.mnuTutorialsClick(Sender: TObject);
var
   mnu : TMenuItem;
   a : Integer;
   lst : TStringList;
begin
     MnuTutorials.Clear;
     lst := TStringList.create;
     try
       GetFileList(Dir.FHelpDirectory, '*.chm', lst);
       for a := 0 to lst.count - 1 do
       begin
         mnu := TMenuItem.Create(self);
         mnu.Caption := ExtractFileName(ChangeFileExt(lst[a], ''));
         mnu.hint := lst[a];
         mnu.OnClick := @mnuTutorialClick;
         mnuTutorials.add(mnu);
       end;
     finally
       lst.free;
     end;
end;

procedure TfrmMain.popMRUPopup(Sender: TObject);
var
  ini : TBigIniFile;
  A : Integer;
  lst : TStringList;
  mnu : TMenuItem;
begin
 ini := TBiginifile.create(FSettingsFile);
 try
   lst := TStringList.create;
   try
      ini.ReadNumberedList('MRU', lst, '');
      a := 0;
      popMRU.Items.Clear;
     if (lst.count-1)=-1 then exit;
      repeat
            if (not FileExists(lst[a])) then
            begin
              lst.delete(a);
              dec(a);
            end;
            inc(a);
      until a>=(lst.count-1);
      ini.WriteNumberedList('MRU', lst);
      if (lst.count-1)=-1 then exit;
      for a := 0 to lst.count -1 do
      begin
        //  Do It
        if (lowercase(extractFileExt(lst[a])) <> '.desln') then
        begin
          mnu := TMenuItem.CreatE(self);
          mnu.caption := ExtractFilename(lst[a]);
          mnu.hint := lst[a];
          mnu.OnClick := @mnuMRUClick;
          popMRU.items.add(mnu);
        end;
      end;
   finally
     lst.free;
   end;


 finally
   ini.free;
 end;

end;

procedure TfrmMain.popSolutionMRUPopup(Sender: TObject);
var
  ini : TBigIniFile;
  A : Integer;
  lst : TStringList;
  mnu : TMenuItem;
begin
 ini := TBiginifile.create(FSettingsFile);
 try
   lst := TStringList.create;
   try
      ini.ReadNumberedList('SOLMRU', lst, '');
      a := 0;
      popSolutionMRU.Items.Clear;
     if (lst.count-1)=-1 then exit;
      repeat
            if not FileExists(lst[a]) then
            begin
              lst.delete(a);
              dec(a);
            end;
            inc(a);
      until a>=(lst.count-1);
      ini.WriteNumberedList('SOLMRU', lst);
      if (lst.count-1)=-1 then exit;
      for a := 0 to lst.count -1 do
      begin
        //  Do It
        mnu := TMenuItem.CreatE(self);
        mnu.caption := ExtractFilename(lst[a]);
        mnu.hint := lst[a];
        mnu.OnClick := @mnuMRUClick;
        popSolutionMRU.items.add(mnu);
      end;
   finally
     lst.free;
   end;


 finally
   ini.free;
 end;

end;

procedure TfrmMain.popTrayPopup(Sender: TObject);
begin
  mnuQuickScriptsClick(self);
  if mnuQuickScripts.Count<=-1 then mnuQuickScripts.Visible:=false else mnuQuickScripts.Visible := true;
end;

procedure TfrmMain.actEditCommentOutExecute(Sender: TObject);
begin
 seEdit.SelText:= '{ ' + seEdit.SelText + ' }';
end;

procedure TfrmMain.actEditCopyExecute(Sender: TObject);
begin
  seEdit.CopyToClipboard;
end;

procedure TfrmMain.actEditCutExecute(Sender: TObject);
begin
  seEdit.CutToClipboard;
end;

procedure TfrmMain.actEditDeleteExecute(Sender: TObject);
begin
  seEdit.SelText := '';
end;

procedure TfrmMain.actEditFindExecute(Sender: TObject);
begin
     FPos:=0;
     dlgFind.execute;
end;

procedure TfrmMain.actEditIndentExecute(Sender: TObject);
var
   lst : TStringList;
   txt : String;
   ind : String;
   a : Integer;
   ss, se : Integer;
begin
     ind := '';
     ss := seEdit.SelStart;
     se := seEdit.SelEnd;
     for A := 0 to seEdit.TabWidth do ind := ind + ' ';
     lst := TStringList.create;
     try
       lst.text := seEdit.SelText;
       for a := 0 to lst.count - 1 do
       begin
            txt := ind + lst[a];
            lst[a] := txt;
       end;
       seEdit.SelText := lst.text;
     finally
       lst.free;
     end;
     seEdit.SelStart := ss;
     seEdit.SelEnd := se;
end;

procedure TfrmMain.actEditPasteExecute(Sender: TObject);
begin
  seEdit.PasteFromClipboard;
end;

procedure TfrmMain.actEditReplaceExecute(Sender: TObject);
begin
  Fpos := 0;
  dlgReplace.execute;
end;

procedure TfrmMain.actEditUnindentExecute(Sender: TObject);
var
   lst : TStringList;
   txt : String;
   a, b : Integer;
   Bail : Boolean;
   ss, se : Integer;
begin
     lst := TStringList.create;
     ss := seEdit.SelStart;
     se := seEdit.SelEnd;
     try
       lst.text := seEdit.SelText;
       if lst.Text = '' then exit;
       for a := 0 to lst.count - 1 do
       begin
            txt := lst[a];
            b := 1;
            Bail := False;
            repeat
                  if txt[1] = ' ' then
                  begin
                     delete(txt, 1, 1);
                     inc(b);
                  end else begin
                    Bail := true;
                  end;
            until (b >= seEdit.TabWidth) or (txt='') or (Bail);
            lst[a] := txt;
       end;
       A := 0;
       repeat
             if trim(lst[a]) = '' then
             begin
                dec(a);
                lst.delete(a);
             end;
             inc(a);
       until a>=lst.count - 1;
       seEdit.SelText := lst.text;
     finally
       lst.free;
     end;
     seEdit.SelStart := ss;
     seEdit.SelEnd := se;
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.actFileExportHTMLExecute(Sender: TObject);
begin
  if dlgExport.execute then
  begin
     sysHTML.ExportAll(seEdit.lines);
     sysHTML.SaveToFile(dlgExport.filename);
  end;
end;

procedure TfrmMain.actFileSaveAsExecute(Sender: TObject);
begin
  if dlgSave.Execute then SaveFile(dlgSave.Filename);
end;

procedure TfrmMain.actFileSaveExecute(Sender: TObject);
begin
  if FFilename = '' then actFileSaveAsExecute(self) else SaveFile(FFilename)
end;

procedure TfrmMain.actGotoLineExecute(Sender: TObject);
var
   frm : TfrmGotoLine;
   pnt : TPoint;
begin
     frm := TfrmGotoLine.create(self);
     try
       //SynEdit.CaretXY := Point(1,10);
       frm.seLine.maxValue := seEdit.lines.count - 1;
       if frm.ShowModal = mrOK then
       begin
            pnt.x := 0;
            pnt.y := frm.seLine.value;
            seEdit.CaretXY := pnt;
       end;
     finally
       frm.free;
     end;
end;

procedure TfrmMain.actHelpAboutExecute(Sender: TObject);
var
   frm : TfrmAbout;
begin
     frm := TfrmABout.create(self);
     try
       frm.ShowModal;
     finally
       frm.free;
     end;
end;

procedure TfrmMain.actHelpContentsExecute(Sender: TObject);
begin
  nbEditors.PageIndex := 1;
  SpeedButton2.down := true;
  LoadHelpFile(ExtractFilePath(ParamStr(0)) + 'Help\Index.html');
end;

procedure TfrmMain.actNewBlankExecute(Sender: TObject);
begin
     if (seEdit.Modified) and (FFilename <>'') then
     begin
          // Ask To Save, if YES, Save the bastard
          SaveAsk;
     end;
     seEdit.lines.clear;
     if FileExists(FDefaultBlank) then seEdit.lines.LoadFromFile(FDefaultBlank)
     else begin
       seEdit.Lines.add('unit Untitled;');
       seEdit.Lines.add('');
       seEdit.Lines.add('');
       seEdit.Lines.add('{ Global Variables }');
       seEdit.Lines.add('var');
       seEdit.Lines.add('    // Setup Global Variables Here');
       seEdit.Lines.add('    MyVar : String;');
       seEdit.Lines.add('');
       seEdit.Lines.add('{ User Functions/Procedures }');
       seEdit.Lines.add('// Put Functions and Procedures Here');
       seEdit.Lines.add('');
       seEdit.Lines.add('{ Main }');
       seEdit.Lines.add('begin');
       seEdit.Lines.add('    // Your script runs here');
       seEdit.Lines.add('end.');
       seEdit.Lines.add('');
       seEdit.Lines.add('{ EOF }');
       seEdit.Lines.SaveToFile(FDefaultBlank);
     end;
     FFilename := '';
     caption := 'deLite (' + FVersionInfo + ')';
     application.title := 'deLite';
     seEdit.Modified := false;
     sbar.panels[5].Text:= '';
end;

procedure TfrmMain.actNewWizardExecute(Sender: TObject);
var
   frm : TfrmNewWizard;
   WizName, FName : String;
   cmdLine : STring;
begin
  frm := TfrmNewWizard.create(self);
  try
     if frm.ShowModal=mrOk then
     begin
       if frm.lvWizards.Selected<>nil then
       begin
            WizName := frm.lvWizards.Selected.subitems[0];
            fname := frm.FileNameEdit1.filename;
            if fname<>'' then
            begin
                 cmdLine := WizName + ' "' + Fname + '"';
                 RunAndPause(CmdLine);
                 LoadFile(Fname);
            end;
       end;
     end;
  finally
    frm.free;
  end;

end;

procedure TfrmMain.actOpenFileExecute(Sender: TObject);
begin
  if dlgOpen.execute then LoadFile(dlgOpen.filename);
end;

procedure TfrmMain.actRunCompileExecute(Sender: TObject);
var
   result : Boolean;
   i : Integer;
   New : TListItem;
begin
  if seEdit.Modified then SaveAsk;
  Result := sysScript.Compile;
  lvCompiler.items.clear;
  for i:= 0 to sysScript.CompilerMessageCount - 1 do
  begin
    new := lvCompiler.items.add;
    new.Caption := IntToStr(sysScript.CompilerMessages[i].Row);
    new.SubItems.Add(IntToStr(sysScript.CompilerMessages[i].Col));
    new.SubItems.add(sysScript.CompilerMessages[i].ShortMessageToString);
     if pos('[Error]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 2
     else if pos('[Warning]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 1
     else if pos('[Hint]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 0;
  end;
  //S.Free;
  if not Result then
  begin
    if sysScript.CompilerMessageCount > 0 then
    begin
      new := lvCompiler.items.add;
      new.Caption := IntToStr(sysScript.CompilerMessages[i].Row);
      new.SubItems.Add(IntToStr(sysScript.CompilerMessages[i].Col));
      new.SubItems.add(sysScript.CompilerMessages[i].ShortMessageToString);
       if pos('[Error]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 2
       else if pos('[Warning]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 1
       else if pos('[Hint]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 0;
    end;
  end else
  begin
       New := lvCompiler.Items.add;
       new.Caption := '';
       new.SubItems.add('');
       new.Subitems.add('Compiled Fine at ' + DateTimeToStr(NOW));
       new.ImageIndex := 3;
  end;
  if lvCompiler.items.count-1 <> -1 then PageControl1.PageIndex := 1;
 SetBottom;
end;

procedure TfrmMain.actRunExecuteExecute(Sender: TObject);
begin
  if seEdit.Modified then SaveAsk;
  RunFile(FFilename);
end;

procedure TfrmMain.actSolAddExecute(Sender: TObject);
const
  strScripts = '.descript';
  strIncludes = '.inc';
  strResources = '.bmp .jpg. .jpeg .png';
var
 Root : TTreeNode;
 New : TMyTreeNode;
 a : Integer;
 fname, ext : String;
 img : Integer;
begin
     if dlgAdd.execute then
     begin
       for a := 0 to dlgAdd.files.count - 1 do
       begin
            fname := dlgAdd.Files[a];
            if not IsInSolution(fname) then
            begin
              FSolutionLoaded := true;
              ext := lowercase(extractFileExt(fname));
              if pos(ext, strScripts)>0 then
              begin
                   Root := GetSByState(0);
                   img := 0;
              end else if pos(ext, strIncludes)>0 then
              begin
                   Root := GetSByState(1);
                   img := 1;
              end else if pos(ext, strResources)>0 then
              begin
                  Root := GetSByState(2);
                  img := 2;
              end else
              begin
                Root := GetSByState(3);
                img := 3;
              end;
              new := TMyTreeNode(tvSolution.items.addChild(Root, ExtractFileName(fname)));
              new.filename := fname;
              new.ImageIndex := img;
              new.SelectedIndex := img;
            end;
       end;
     end;
end;

procedure TfrmMain.actSolDelExecute(Sender: TObject);
begin
     if tvSolution.selected<>nil then
     begin
          if tvSolution.selected.level=1 then tvSolution.selected.free;
     end;
end;

procedure TfrmMain.actSolNewExecute(Sender: TObject);
begin
  NewSolution;
end;

procedure TfrmMain.actSolOpenExecute(Sender: TObject);
begin
  if dlgOpenSolution.execute then LoadSolution(dlgOpenSolution.filename);
end;

procedure TfrmMain.actSolPropertiesExecute(Sender: TObject);
var
 ini : TBigIniFile;
 frm : TfrmSolution;
 a : Integer;
 root : TTreeNode;
 New : TMyTreeNode;
begin
  // Show Solution properties dialog
  if FSolution='' then
  begin
    ShowTip('Must save your solution before using this function');
    exit;
  end;
  ini := TBigIniFile.create(FSolution);
  try
     frm := TfrmSolution.create(self);
     try
        Root := GetSByState(0); // Scripts node;
        frm.cboMain.items.clear;
        for a := 0 to root.count - 1 do
        begin
          new := TMyTreeNode(Root.items[a]);
          frm.cboMain.items.add(new.Filename);
        end;
        frm.cboMain.text := ini.ReadString('General', 'Main', '');
        frm.chkLoadMain.checked := ini.REadBool('General', 'LoadMain', true);
        frm.chkCompress.checked := ini.ReadBool('Compile', 'CompressOutput', true);
        frm.chkIntRes.checked := ini.ReadBool('Compile', 'IntegrateRes', true);
        frm.feEXEFilename.filename := ini.readString('Compile', 'EXEFilename', '');
        frm.feEXEFilename1.filename := ini.readString('Compile', 'IcoFilename', '');
        if frm.ShowModal = mrOK then
        begin
          ini.WriteString('General', 'Main', frm.cboMain.text);
          ini.WriteBool('General', 'LoadMain', frm.chkLoadMain.checked);
          ini.WriteBool('Compile', 'CompressOutput', frm.chkCompress.checked);
          ini.WriteBool('Compile', 'IntegrateRes', frm.chkIntRes.checked);
          ini.WriteString('Compile', 'EXEFilename', frm.feEXEFilename.filename);
          ini.WriteString('Compile', 'IcoFilename', frm.feEXEFilename1.filename);
        end;
     finally
       frm.free;
     end;
  finally
    ini.free;
  end;
end;

procedure TfrmMain.actSolSaveASExecute(Sender: TObject);
begin
  if dlgSaveSolution.execute then SaveSolution(dlgSaveSolution.filename);
end;

procedure TfrmMain.actSolSaveExecute(Sender: TObject);
begin
  if FSolution<>'' then
  begin
    SaveSolution(FSolution);
  end else actSolSaveASExecute(sender);
end;

procedure TfrmMain.actToolsMakeSnipExecute(Sender: TObject);
var
   Fname : String;
   lst : TStringList;
begin
     fname := AskText('Enter Filename (No Ext)');
     if fname<>'' then
     begin
       lst := TStringList.create;
       try
          lst.text := seEdit.SelText;
          fname := Dir.FSnipDirectory + fname + '.deSnip';
          lst.SaveToFile(Fname);
       finally
         lst.free;
       end;
       MakeLists;
     end;
end;

procedure TfrmMain.actToolsMakeTemplateExecute(Sender: TObject);
var
   Fname : String;
begin
     fname := AskText('Enter Filename (No Ext)');
     if fname<>'' then
     begin
          fname := Dir.FTemplateDirectory + fname + '.deScript';
          seEdit.Lines.SaveToFIle(Fname);
          MakeLists;
     end;
end;

procedure TfrmMain.actToolsNetAssetsExecute(Sender: TObject);
var
   frm : TfrmNetAssets;
begin
     if FileExists(Dir.FUserDirectory + 'NetRes.ini') then DeleteFile(Dir.FUserDirectory + 'NetRes.ini');
     frm := TfrmNetAssets.create(self);
     try
       frm.ShowModal;
     finally
       frm.free;
     end;
     MakeLists;
end;

procedure TfrmMain.actToolsSettingsExecute(Sender: TObject);
var
   frm : TfrmSettings;
begin
     frm := TfrmSettings.create(self);
     try
       if frm.ShowModal = mrOK then
       begin
            LoadTheme(FCurrentTheme);
       end;
     finally
       frm.free;
     end;
end;

procedure TfrmMain.btnBackClick(Sender: TObject);
begin
  if cboHelp.ItemIndex > 0 then cboHelp.ItemIndex := cboHelp.ItemIndex - 1;
  LoadHElPFile(cboHelp.items[cboHelp.ItemIndex]);
end;

procedure TfrmMain.btnGoClick(Sender: TObject);
begin
  // Go
  if cboHelp.text<>'' then LoadHelpFile(cboHelp.text);
  cboHelp.ItemIndex := cboHelp.Items.count - 1;
end;

procedure TfrmMain.btnHomeClick(Sender: TObject);
begin
     LoadHelpFile(ExtractFilepath(ParamStr(0)) + 'Help\index.html');
end;

procedure TfrmMain.btnNextClick(Sender: TObject);
begin
  if cboHelp.ItemIndex < cboHelp.items.count - 1 then cboHelp.ItemIndex := cboHelp.ItemIndex + 1;
  LoadHElPFile(cboHelp.items[cboHelp.ItemIndex]);
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
begin
  if btnSearch.down then pnlHelpSEarch.visible := True else pnlHelpSearch.Visible := false;
end;

procedure TfrmMain.btnSearchHelpClick(Sender: TObject);
var
   a : Integer;
   fname : String;
   fle : TStringList;
   new : TListItem;
begin
  // Search Help
  lvHelpSearch.items.Clear;
  for a := 0 to tvHelp.items.count - 1 do
  begin
       if tvHelp.Items.item[a].level = 1 then
       begin
            fname := ExtractFilepath(ParamStr(0)) + 'Help\' + tvHelp.Items.Item[a].text + '.html';
            fle := TStringList.create;
            try
               if FileExistsUTF8(fname) then
               begin
                    fle.LoadFromFile(fname);
                    // ShowTip(fname);
                    if pos(uppercase(txtHelpSEarch.text), Uppercase(fle.text))>0 then
                    begin
                         new := lvHelpSearch.items.add;
                         new.Caption := txtHelpSEarch.text;
                         new.SubItems.add(fname);
                         new.ImageIndex := 1;
                    end;
               end;
            finally
              fle.free;
            end;
       end;
  end;
end;

procedure TfrmMain.cboHelpKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    btnGoClick(Self);
  end;
end;

procedure TfrmMain.dlgFindFind(Sender: TObject);
var
  FindS: String;
  IPos, FLen, SLen: Integer; {Internpos, Lengde søkestreng, lengde memotekst}
  Res : integer;
begin
  {FPos is global}
  Found:= False;
  FLen := Length(dlgFind.FindText);
  SLen := Length(seEdit.Text);
  FindS := dlgFind.FindText;

 //following 'if' added by mike
  if frMatchcase in dlgFind.Options then
     IPos := Pos(FindS, Copy(seEdit.Text,FPos+1,SLen-FPos))
  else
     IPos := Pos(AnsiUpperCase(FindS),AnsiUpperCase( Copy(seEdit.Text,FPos+1,SLen-FPos)));

  If IPos > 0 then begin
    FPos := FPos + IPos;
 //   Hoved.BringToFront;       {Edit control must have focus in }
    seEdit.SetFocus;
    Self.ActiveControl := seEdit;
    seEdit.SelStart:= FPos;  // -1;   mike   {Select the string found by POS}
    setSelLength(seEdit, FLen);     //seEdit.SelLength := FLen;
    Found := True;
    FPos:=FPos+FLen-1;   //mike - move just past end of found item

  end
  Else
  begin
    Res := Application.MessageBox('Text was not found!',
           'Find',  mb_OK + mb_ICONWARNING);
    FPos := 0;     //mike  nb user might cancel dialog, so setting here is not enough
  end;             //   - also do it before exec of dialog.
end;

procedure TfrmMain.dlgReplaceReplace(Sender: TObject);
var
  FindS: String;
  IPos, FLen, SLen: Integer; {Internpos, Lengde søkestreng, lengde memotekst}
  Res : integer;
begin
  {FPos is global}
  Found:= False;
  FLen := Length(dlgReplace.FindText);
  SLen := Length(seEdit.Text);
  FindS := dlgReplace.FindText;

 //following 'if' added by mike
  if frMatchcase in dlgReplace.Options then
     IPos := Pos(FindS, Copy(seEdit.Text,FPos+1,SLen-FPos))
  else
     IPos := Pos(AnsiUpperCase(FindS),AnsiUpperCase( Copy(seEdit.Text,FPos+1,SLen-FPos)));

  If IPos > 0 then begin
    FPos := FPos + IPos;
 //   Hoved.BringToFront;       {Edit control must have focus in } - what is this? mike
    seEdit.SetFocus;
    Self.ActiveControl := seEdit;
    seEdit.SelStart:= FPos;  // removed -1;   mike   {Select the string found by POS}
    setSelLength(seEdit, FLen);     //seEdit.SelLength := FLen;
    Found := True;
    FPos:=FPos+FLen-1;   //mike - move just past end of found item
    seEdit.SelText := dlgReplace.ReplaceText;
  end
  Else
  begin
    If not (dlgReplace.Options*[frReplaceAll] = [frReplaceAll]) then
      Res := Application.MessageBox('Text was not found!', 'Replace',
      mb_OK + mb_ICONWARNING);
    FPos := 0;     //mike  nb user might cancel dialog, so setting here is not enough
  end;             //   - also do it before exec of dialog.
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
   INI : TBigInifile;
begin
    ini :=  TBigIniFile.create(FSettingsFile);
    try
      // Given up trying to make it work just max the buggering thing for now
     ini.WriteInteger('Layout', 'Panel', pnlSTuff.width);
     ini.WriteInteger('Layout', 'DataPnl', pnlData.Height);
     if FSolution<>'' then
        ini.WRiteString('Files', 'LastProj', FSolution)
     else if FFIlename<>'' then
        ini.WRiteString('Files', 'LastProj', FFilename);
    finally
     ini.free;
    end;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if seEdit.Modified then SaveAsk;
  sysTray.Visible:=false;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
   ini : TBigIniFile;
   ver : TVersionInfo;
   frm : TfrmTipOfTheDay;
   fname, Verb : String;
begin
 FFirstRun := true;
 WindowState := wsMaximized;
  ver := TVersionInfo.Create(ParamStr(0));
  try
    FVersionInfo := ver.GetFileVersionWithDots;
    sbar.Panels[3].Text:=FVersionInfo;
  finally
         Ver.Free;
  end;
 Dir.FUserDirectory := ReturnSysDir('AppData');
 Dir.FUserDirectory := Dir.FUserDirectory + 'deLite\';
 Dir.FTemplateDirectory := Dir.FUserDirectory + 'Templates\';
 Dir.FSnipDirectory := Dir.FUserDirectory + 'Snips\';
 Dir.FToolDirectory := Dir.FUserDirectory + 'Tools\';
 Dir.FUnitDirectory := Dir.FUserDirectory + 'Units\';
 Dir.FHelpDirectory := Dir.FUserDirectory + 'Help\';
 Dir.FWizDirectory := Dir.FUserDirectory + 'Wizards\';
 Dir.FExamDirectory := Dir.FUserDirectory + 'Examples\';
 Dir.FTipDirectory := Dir.FUserDirectory + 'Tips\';
 Dir.FThemeDirectory := Dir.FUserDirectory + 'Themes\';
 FSettingsFile := Dir.FUserDirectory + 'deLite.Settings';
 FDefaultBlank := Dir.FUserDirectory + 'blank.deScript';
 FCurrentTheme := Dir.FUserDirectory + 'Current.theme';
 if not FileExists(FSettingsFile) then
 begin
      // Create User Profile
      CreateDir(Dir.FUserDirectory);
      CreateDir(Dir.FTemplateDirectory);
      CreateDir(Dir.FSnipDirectory);
      CreateDir(Dir.FToolDirectory);
      CreateDir(Dir.FHelpDirectory);
      CreateDir(Dir.FUnitDirectory);
      CreateDir(Dir.FWizDirectory);
      CreateDir(Dir.FExamDirectory);
      CreateDir(Dir.FTipDirectory);
      CreateDir(Dir.FThemeDirectory);
      if fileExists(ExtractFilePath(ParamStr(0)) + 'deLite.Settings') then CopyFile(ExtractFilePath(ParamStr(0)) + 'deLite.Settings', FSettingsFile);
      if fileExists(ExtractFilePath(ParamStr(0)) + 'deLite.tip') then CopyFile(ExtractFilePath(ParamStr(0)) + 'DeLite.tip', Dir.FTipDirectory + 'DeLite.tip');
      if fileExists(ExtractFilePath(ParamStr(0)) + 'Blank.deScript') then CopyFile(ExtractFilePath(ParamStr(0)) + 'Blank.deScript', FDefaultBlank);
 end;
 // Load Options
 DoVersionCheck;
 ini :=  TBigIniFile.create(FSettingsFile);
// WindowState := wsMaximized;
 try
   pnlSTuff.width := ini.ReadInteger('Layout', 'Panel', 219);
   pnlData.Height := ini.ReadInteger('Layout', 'DataPnl', 154);
   FLastProj := ini.ReadString('Files', 'LastProj', '');
   // Load Current Editor Theme
   if FileExists(FCurrentTheme) then
   begin
     LoadTheme(FCurrentTheme);
   end;
   if ini.ReadBool('General', 'ShowTips', true) then
   begin
     frm := TfrmTipOfTheDay.create(self);
     try
       frm.ShowModal;
       ini.WriteBool('General', 'ShowTips', frm.chkShowTips.checked)
     finally
            frm.free;
     end;
   end;
 finally
   ini.free;
 end;
 seEdit.Modified := false;
 actNewBlankExecute(self);
 MakeLists;

{ if ParamCount>0 then
 begin
      if ParamCount = 1 then
      begin
           fname := ParamStr(1);
           if lowercase(extractFileExt(fname)) = '.desln' then LoadSolution(Fname)
           else LoadFile(fname)
      end else if ParamCount >= 2 then
      begin
           // We Have A Command Verb
           Fname := ParamStr(1);
           Verb := lowercase(ParamStr(2));
           if verb = '/run' then
           begin
                LoadFile(Fname);
                RunFile(Fname);
                application.terminate;
           end;
      end;
 end;
} LoadHelpFile(ExtractFilePath(ParamStr(0)) + 'help\index.html');
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
   FName : String;
   Verb : String;
begin
 if FFirstRun then
 begin
      FFirstRun := false;
      // Do File Association Stuff Here
      if ParamCount>0 then
      begin
           if ParamCount = 1 then
           begin
                fname := ParamStr(1);
                if lowercase(extractFileExt(fname)) = '.desln' then LoadSolution(Fname)
                else LoadFile(fname)
           end else if ParamCount >= 2 then
           begin
                // We Have A Command Verb
                Fname := ParamStr(1);
                Verb := lowercase(ParamStr(2));
                if verb = '/run' then
                begin
                     LoadFile(Fname);
                     RunFile(Fname);
                     application.terminate;
                end;
           end;
      end else
      begin
            if FLastProj<>'' then
            begin
                if Application.MessageBox('Would you like to load Last Project?', 'Script Host', MB_ICONQUESTION + MB_YESNO) = IDNo then exit;
                if extractFileExt(lowercase(FLastProj))='.desln' then LoadSolution(FLastProj) else LoadFile(FLastProj);
            end;
      end;
 end;
end;

procedure TfrmMain.htmHelpHotClick(Sender: TObject);
var
  NodeA: TIpHtmlNodeA;
  NewFilename: String;
begin
  if htmHelp.HotNode is TIpHtmlNodeA then begin
    NodeA := TIpHtmlNodeA(htmHelp.HotNode);
    NewFilename := NodeA.HRef;
    if extractFilePath(NewFilename) = '' then NewFilename := ExtractFilePath(ParamStr(0)) + 'help\' + NewFilename;
    LoadHelpFile(NewFilename);
    self.FocusControl(TWinControl(seEDit));
  end;
end;

procedure TfrmMain.lvCompilerDblClick(Sender: TObject);
var
  pnt : TPoint;
begin
     if lvCompiler.Selected<>nil then
     begin
       if lvCompiler.Selected.Caption<>'' then
       begin
         pnt.y := StrToInt(lvCompiler.Selected.Caption);
         pnt.x := StrToInt(lvCompiler.Selected.Subitems[0]);
         if pnt.x<>-1 then
         begin
              seEdit.CaretXY := pnt;
              seEdit.Invalidate;
         end;
       end;
     end;
     ActiveControl := seEdit;
end;

procedure TfrmMain.lvExamplesDblClick(Sender: TObject);
var
   fname : String;
begin
  if lvExamples.selected = nil then exit;
  fname := Dir.FExamDirectory + lvExamples.Selected.Caption + '.deScript';
  LoadFile(Fname);
end;

procedure TfrmMain.lvHelpSearchDblClick(Sender: TObject);
begin
  if lvHelpSEarch.selected<>nil then LoadHelpFile(lvHelpSearch.selected.subItems[0]);
end;

procedure TfrmMain.lvSnipsDblClick(Sender: TObject);
var
   fname : String;
   lst : TStringList;
begin

  if lvSnips.selected = nil then exit;
  fname := Dir.FSnipDirectory + trim(lvSnips.selected.Caption) + '.deSnip';
  lst := TStringList.create;
  try
     if FileExists(Fname) then lst.LoadFromFile(Fname);
     seEdit.SelText := lst.text;
  finally
    lst.free;
  end;
  nbEditors.PageIndex := 0;
  SpeedButton1.Down := True;
end;

procedure TfrmMain.lvTemplatesDblClick(Sender: TObject);
var
   fname : String;
begin
  if lvTemplates.selected = nil then exit;
  fname := Dir.FTemplateDirectory + trim(lvTemplates.selected.Caption) + '.deScript';
  if Ask('This will overwrite current editor text' + #10#13 + 'Are You Sure?') <> mrYes then exit;
  if FileExists(Fname) then seEdit.Lines.LoadFromFile(Fname);
  nbEditors.PageIndex := 0;
  SpeedButton1.Down := True;
end;

procedure TfrmMain.MenuItem39Click(Sender: TObject);
begin
  Show;
  visible := true;
end;

procedure TfrmMain.MenuItem41Click(Sender: TObject);
begin
  Hide;
end;

procedure TfrmMain.mnuIntScriptItemClick(Sender: TObject);
begin
  if TMenuItem(Sender).hint<> '' then RunFile(TMenuItem(Sender).hint);
end;

procedure TfrmMain.mnuIntScriptsClick(Sender: TObject);
var
   mnu : TMenuItem;
   a : Integer;
   Ini : TBigIniFile;
   lst : TStringList;
begin
     mnuIntScripts.Clear;
     ini := TBigIniFile.create(FSettingsFile);
     try
       lst := TStringList.create;
       try
         ini.ReadNumberedList('IntScripts', lst, '');
         if (lst.count-1)<>-1 then
         begin
           for A := 0 to lst.count - 1 do
           begin
             mnu := TMenuItem.create(self);
             mnu.Caption := ExtractFileName(ChangeFileExt(lst[a], ''));
             mnu.hint := lst[a];
             mnu.OnClick := @mnuIntScriptItemClick;
             mnuIntScripts.Add(mnu);
           end;
         end;
       finally
         lst.free;
       end;
     finally
       ini.free;
     end;
end;

procedure TfrmMain.mnuMRUClick(Sender: TObject);
var
   fname : String;
   ext : String;
begin
  fname := TMenuItem(sender).hint;
  ext := lowercase(ExtractFileExt(Fname));
  if ext = '.desln' then LoadSolution(fname)
  else LoadFile(fname);
end;

procedure TfrmMain.mnuQuickClick(Sender: TObject);
begin
  with sender as TMenuItem do
  begin
    if hint<>'' then
    begin
         if FileExists(hint) then RunFile(Hint);
    end;
  end;
end;

procedure TfrmMain.mnuQuickScriptsClick(Sender: TObject);
var
   mnu : TMenuItem;
   a : Integer;
   Ini : TBigIniFile;
   lst : TStringList;
begin
     mnuQuickScripts.Clear;
     ini := TBigIniFile.create(FSettingsFile);
     try
       lst := TStringList.create;
       try
         ini.ReadNumberedList('Quick', lst, '');
         if (lst.count-1)<>-1 then
         begin
           for A := 0 to lst.count - 1 do
           begin
             mnu := TMenuItem.create(self);
             mnu.Caption := ExtractFileName(ChangeFileExt(lst[a], ''));
             mnu.hint := lst[a];
             mnu.OnClick := @mnuQuickClick;
             mnuQuickScripts.Add(mnu);
           end;
         end;
       finally
         lst.free;
       end;
     finally
       ini.free;
     end;
end;

procedure TfrmMain.seEditChange(Sender: TObject);
var
  lst : TStringList;
  new, root : TTreeNode;
  a : Integer;
  ps : TPoint;
begin
     ps := seEdit.CaretXY;
     Sbar.Panels[0].text := 'Col: ' + IntToStr(ps.x);
     Sbar.Panels[1].text := 'Row: ' + IntToStr(ps.y);
    if SEEdit.Modified then sbar.Panels[4].text := 'Modified' else sbar.Panels[4].text := '';
  lst := TStringList.create;
  try
     lst.assign(seEdit.lines);
     root := GetByState(1);
     root.DeleteChildren;
     root := GetByState(2);
     root.DeleteChildren;
     root := GetByState(3);
     root.DeleteChildren;
     for a := 0 to lst.count - 1 do
     begin
          if pos('function ', trim(lowercase(lst[a])))=1 then
          begin
            root := GetByState(2);
            if root <> nil then
            begin
              new := tvProject.items.AddChild(Root, lst[a]);
              new.StateIndex := 1000 + a;
              new.ImageIndex := 7;
              new.SelectedIndex:=7;
            end;
          end else if pos('procedure ', trim(lowercase(lst[a])))=1 then
          begin
            root := GetByState(1);
            if root <> nil then
            begin
              new := tvProject.items.AddChild(Root, lst[a]);
              new.StateIndex := 1000 + a;
              new.ImageIndex := 7;
              new.SelectedIndex:=7;
            end;
          end else if pos('{$I ', trim(lst[a]))=1 then
          begin
            root := GetByState(3);
            if root <> nil then
            begin
              new := tvProject.items.AddChild(Root, lst[a]);
              new.StateIndex := 1000 + a;
              new.ImageIndex := 7;
              new.SelectedIndex:=7;
            end;
          end;
     end;
  finally
    lst.free;
  end;
end;

procedure TfrmMain.seEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  seEditChange(self);
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  TSpeedButton(Sender).down := true;
  nbEditors.PageIndex := TSpeedButton(Sender).tag;
end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
begin
  memDebug.lines.clear;
  lvCompiler.items.clear;
  memTool.lines.clear;
end;

procedure TfrmMain.sysScriptCompile(Sender: TPSScript);
begin
  // System Functions (Windows Only!)
  {  Call with the following to find out the current directory for it
             Desktop
             Personal
             Fonts
             History
             Recent
             Start Menu
             AppData
             Startup
             Favorites
             Cache
             Cookies
             My Pictures
             NetHood
  }
 {$IFDEF WINDOWS}
   Sender.AddFunction(@ReturnSysDir, 'function sys_ReturnSysDir(const DirName : String) : String; ');
   Sender.AddFunction(@myGetWindowsDirectory, 'function sys_GetWindowsDirectory : String;');
   Sender.AddFunction(@myGetUserName, 'function sys_GetUserName : String;');
   Sender.AddFunction(@myGetSystemDirectory, 'function sys_GetSystemDirectory : String;');
   Sender.AddFunction(@myGetComputerName, 'function sys_GetComputerName : String;');
   Sender.AddFunction(@GetTempFile, 'function sys_MakeTempFile(const Extension: string): string;');
   Sender.AddFunction(@myGetTempPath, 'function myGetTempPath: String;');
 {$ENDIF}

 // Dialog Functions
 Sender.AddFunction(@dlg_Open, 'function dlg_Open(Title, Filter: String) : String;');
 Sender.AddFunction(@dlg_Save, 'function dlg_Save(Title, Filter, DefaultEXT : String) : String;');
 Sender.AddFunction(@ShowMessage, 'Procedure dlg_Message(text : String)');
 Sender.AddFunction(@FuncAsk, 'Function dlg_Ask(const TipText : String) : Integer;');
 Sender.AddFunction(@dlg_Color, 'function dlg_Color(Title : String) : TColor;');
 Sender.AddFunction(@AskText, 'function dlg_Text(Title : String) : String;');
 Sender.AddFunction(@EditText, 'Function dlg_Edit(const Title, Current : String) : String;');
 Sender.AddFunction(@dlg_UserPass, 'procedure dlg_UserPass(var username, password : String)');

 // Debug
 Sender.AddFunction(@MWriteS, 'procedure WriteS(const s: string)');
 Sender.AddFunction(@MVal, 'procedure Val(const s: string; var n, z: Integer)');

 // Directory Handling
 sender.AddFunction(@CreateDir, 'function CreateDir (Const NewDir : String) : Boolean;');
 sender.AddFunction(@ForceDirectories, 'Function ForceDirectories(Const Dir: string): Boolean;');
 sender.AddFunction(@RemoveDir, 'function RemoveDir (Const Dir : String) : Boolean;');

 // Other Missing Stuff
 sender.AddFunction(@ShowMessage,'Procedure ShowMessage(const MSG: string)');
 sender.AddFunction(@DateTimeToStr,'function DateTimeToStr(DateTime: TDateTime): string;');
 sender.AddFunction(@TimeToStr, 'function TimeToStr(Time: TDateTime): string;');
 sender.AddFunction(@DateToStr, 'function DateToStr(Date: TDateTime): string;');
 sender.AddFunction(@Randomize, 'procedure Randomize;');
 sender.AddFunction(@Random, 'function Random(const range : Integer) : Integer');
 sender.AddFunction(@FileExistsUTF8, 'function FileExistsUTF8(const Filename : String) : Boolean');
 sender.AddFunction(@Sleep, 'procedure Sleep(const Milliseconds : Integer)');

 // Internet
 sender.AddFunction(@URLDown,'procedure net_httpDown(filename, url: string)');
 sender.AddFunction(@ParseURL,'procedure ParseURL(const URL : String; var Proto, User, Pass, Host, Port, Path : String)');
 sender.AddFunction(@UrlEncode,'function UrlEncode(const DecodedStr: String; Pluses: Boolean): String;');
 sender.AddFunction(@UrlDecode,'function UrlDecode(const EncodedStr: String): String;');
 sender.AddFunction(@FTPPutFile2, 'function net_FtpPutFile(var lst : TStringList): Boolean;');
 sender.AddFunction(@FTPGetFile2, 'function net_FtpGetFile(var lst : TStringList): Boolean;');
 sender.AddFunction(@PingHost2, 'function net_Ping(const Host: string): Integer');
 sender.AddFunction(@TraceRouteHost2, 'function net_TraceRoute(const Host: string): string;');
 //function getIPs: Tstrings;
 sender.AddFunction(@getIPs, 'function net_GetIPS : Tstrings;');
 sender.AddFunction(@NetTime, 'function net_SyncTime(const host : String) : Boolean;');


 // String Handling
 sender.AddFunction(@SubStr,'Function SubStr(Const Source: String; Const StartPos : Integer; Const EndPos : Integer) : String;');
 sender.AddFunction(@StringReplaceAll, 'function StringReplaceAll(const S, OldPattern, NewPattern: string): string;');
 sender.AddFunction(@Fill_StringList, 'procedure Fill_StringList(var StrLst: TStringList; delimited_text: string; delimiter: Char);');
 sender.AddFunction(@StripChar, 'function StripChar(text: string; ch: char): string;');
 sender.AddFunction(@GetBetween, 'function GetBetween(const PairBegin, PairEnd, Value: string): string;');
 sender.AddFunction(@bf_Encrypt, 'function bf_Encrypt(str, password: string): string;');
 sender.AddFunction(@bf_Decrypt, 'function bf_Decrypt(str, password: string): string;');
 sender.AddFunction(@EncodeStringBase64, 'function Base64_Encode(const s:string):String;');
 sender.AddFunction(@DecodeStringBase64, 'function Base64_Decode(const s:string):String;');
 //

//

 // File Handling
 sender.AddFunction(@FileExists, 'function FileExists(const filename : String) : Boolean;');
 sender.AddFunction(@ChangeFileExt, 'function ChangeFileExt(const filename, ext : String) : String;');
 sender.AddFunction(@ExtractFilePath, 'function ExtractFilePath(const filename : String) : String;');
 sender.AddFunction(@ExtractShortPathName, 'function ExtractShortPathName(const filename : String) : String;');
 sender.AddFunction(@ExtractFileDir, 'function ExtractFileDir(const filename : String) : String;');
 sender.AddFunction(@ExtractFileName, 'function ExtractFileName(const filename : String) : String;');
 sender.AddFunction(@ExtractFileExt, 'function ExtractFileExt(const filename : String) : String;');
 sender.AddFunction(@ExtractFileDrive, 'function ExtractFileDrive(const filename : String) : String;');
 sender.AddFunction(@CopyFile, 'function CopyFile(const SrcFilename, DestFilename: string; PreserveTime: boolean): boolean;');

 // Internal Stuff

 sender.AddFunction(@de_ReturnExam, 'function de_ReturnExam : String;');
 sender.AddFunction(@de_ReturnUnit, 'function de_ReturnUnit : String;');
 sender.AddFunction(@de_ReturnHelp, 'function de_ReturnHelp : String;');
 sender.AddFunction(@de_ReturnTool, 'function de_ReturnTool : String;');
 sender.AddFunction(@de_ReturnSnip, 'function de_ReturnSnip : String;');
 sender.AddFunction(@de_ReturnTemplate, 'function de_ReturnTemplate : String;');
 sender.AddFunction(@de_ReturnUser, 'function de_ReturnUser : String;');
 sender.AddFunction(@de_ReturnScript, 'function de_ReturnScript : String;');
 sender.AddFunction(@de_ReturnScriptPath, 'function de_ReturnScriptPath : String;');

 // Internal Editor Functions
 sender.AddFunction(@de_GetSelText, 'function de_GetSelText : String;');
 sender.AddFunction(@de_SetSelText, 'Procedure de_SetSelText(SelText : String);');
 sender.AddFunction(@de_refreshEditor, 'Procedure de_refreshEditor');

 // LST_ List Functions.  List's will be important in deLite
 sender.AddFunction(@lst_RemoveDuplicates, 'procedure lst_RemoveDuplicates(var TheList : TStringList)');
 sender.AddFunction(@lst_Copy, 'procedure lst_Copy(var From, ToLst : TStringList)');
 sender.AddFunction(@GetFileList2, 'function lst_FileList(FDirectory, Filter: string; var lst : TStringList; const Recurse : Boolean): boolean;');

 // System Shell Etc
 sender.AddFunction(@OpenDocument, 'procedure OpenDocument(const doc : String)');
 sender.AddFunction(@SetWallpaper, 'procedure sys_Wallpaper(const Filename : String; const style : Integer);');

 // SND_  All to do with sounds
 sender.AddFunction(@snd_PlayASound, 'procedure snd_PlaySound(FileName: string)');
 //procedure
 sender.AddFunction(@SendMCI, 'procedure snd_MCIString(const str : String)');

 // INI Functions
 sender.AddFunction(@ini_ReadString, 'function ini_ReadString(const filename, section, variable, default : String) : String;');
 sender.AddFunction(@ini_WriteString, 'Procedure ini_WriteString(const filename, section, variable, Value : String);');
 sender.AddFunction(@ini_ReadInteger, 'function ini_ReadInteger(const filename, section, variable : String; Default : Integer) : Integer;');
 sender.AddFunction(@ini_WriteInteger, 'Procedure ini_WriteInteger(const filename, section, variable: String; Value : Integer);');
 sender.AddFunction(@ini_WriteList, 'Procedure ini_WriteList(const filename, section : String; Var Lst : TStringList);');
 sender.AddFunction(@ini_ReadList, 'Procedure ini_ReadList(const filename, section : String; Default : string; var lst : TStringList);');
end;

procedure TfrmMain.sysScriptCompImport(Sender: TObject; x: TPSPascalCompiler);
begin
 AddImportedClassVariable(x, 'Self', 'TForm');
 AddImportedClassVariable(x, 'Application', 'TApplication');
end;

function TfrmMain.sysScriptNeedFile(Sender: TObject;
  const OrginFileName: string; var FileName, Output: string): Boolean;
var
 s: string;
begin
   s := ExtractFilePath(OrginFileName);
   if s = '' then s := dir.FUnitDirectory;
   Filename := s + ExtractFileName(OrginFileName);
   if FileExistsUTF8(Filename) { *Converted from FileExists* } then
   begin
     Output := StringLoadFile(Filename);
     Result := True;
   end else
     Result := False;
end;

procedure TfrmMain.ToolButton46Click(Sender: TObject);
begin
  lvHelpSearch.items.clear;
end;

procedure TfrmMain.tvHelpClick(Sender: TObject);
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

procedure TfrmMain.tvProjectClick(Sender: TObject);
var
 root : TTreeNode;
 JumpPoint : Integer;
begin
     if tvProject.selected = nil then exit;
     Root := TvProject.selected;
     JumpPoint := -1;
     if root.level = 0 then
     begin
       if root.Text = 'Top' then JumpPoint := 0
       else if root.Text = 'Bottom' then JumpPoint := Length(trim(seEdit.Lines.text))-3
       else if root.Text = 'Global Var' then JumpPoint := pos('{ Global Variables }', seEdit.lines.text)
       else if root.Text = 'Main Program' then JumpPoint := pos('{ Main }', seEdit.lines.text);
       if JumpPoint>-1 then
       begin
         seEdit.SelStart:=JumpPoint;
         seEdit.SelEnd := JumpPoint + 3;
       end;
     end else if Root.Level = 1 then
     begin
       JumpPoint := pos(Root.text, seEdit.lines.text);
       if JumpPoint>-1 then
       begin
         seEdit.SelStart := JumpPoint;
         try
            seEdit.SelEnd := JumpPoint + length(Root.text)-1;
         Except
           // Whoops we went over the total limit.
         end;
       end;
     end;
     ActiveControl := seEdit;
end;

Function TfrmMain.GetByState(IdX : Integer) : TTreeNode;
var
  A : Integer;
begin
 result := nil;
 for a := 0 to tvProject.items.count - 1 do
 begin
      if tvProject.Items.Item[a].StateIndex = idx then
      begin
        result := tvProject.Items.Item[a];
        exit;
      end;
 end;
end;

Function TfrmMain.GetSByState(IdX : Integer) : TTreeNode;
var
  A : Integer;
begin
 result := nil;
 for a := 0 to tvSolution.items.count - 1 do
 begin
      if tvSolution.Items.Item[a].StateIndex = idx then
      begin
        result := tvSolution.Items.Item[a];
        exit;
      end;
 end;
end;

function TfrmMain.GetFileList(FDirectory, Filter: TFileName; var lst : TStringList): boolean;
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
        FindClose(ARec);
        REsult := true;
        except
              lst.clear;
              Result := false;
        end;
end;

procedure TfrmMain.RunFile(Const FName : String);
var
  result : Boolean;
  i : Integer;
  NEW : TListItem;
begin
 FOkNext := false;
 Result := false;
 memDebug.lines.clear;
 sysScript.Script.clear;
 sysScript.Script.LoadFromFile(Fname);
 Result := sysScript.Compile;
 lvCompiler.Items.clear;
 for i:= 0 to sysScript.CompilerMessageCount - 1 do
 begin
     new := lvCompiler.items.add;
     new.Caption := IntToStr(sysScript.CompilerMessages[i].Row);
     new.SubItems.Add(IntToStr(sysScript.CompilerMessages[i].Col));
     new.SubItems.add(sysScript.CompilerMessages[i].ShortMessageToString);
      if pos('[Error]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 2
      else if pos('[Warning]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 1
      else if pos('[Hint]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 0;
 end;
 //S.Free;
 if not Result then
 begin
   if sysScript.CompilerMessageCount > 0 then
   begin
     for i:= 0 to sysScript.CompilerMessageCount - 1 do
     begin
       new := lvCompiler.items.add;
       new.Caption := IntToStr(sysScript.CompilerMessages[i].Row);
       new.SubItems.Add(IntToStr(sysScript.CompilerMessages[i].Col));
       new.SubItems.add(sysScript.CompilerMessages[i].ShortMessageToString);
         if pos('[Error]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 2
         else if pos('[Warning]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 1
         else if pos('[Hint]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 0;
     end;
   end;
 end else
 begin
   if sysScript.Execute then
   begin
     New := lvCompiler.Items.add;
     New.Caption := '';
     new.SubItems.add('');
     new.SubItems.add('Executed at ' + DateTimeToStr(NOW));
     New.ImageIndex := 3;
   end;
 end;
 if lvCompiler.items.count - 1 > -1 then PageControl1.PageIndex := 1;
 FokNext := True;
 SetBottom;
end;

procedure TfrmMain.CompileFile(Const FName : String);
var
  result : Boolean;
  i : Integer;
  New : TListItem;
begin
 Result := false;
 memDebug.lines.clear;
 sysScript.Script.LoadFromFile(Fname);
 Result := sysScript.Compile;
 lvCompiler.Items.clear;
 for i:= 0 to sysScript.CompilerMessageCount - 1 do
 begin
   new := lvCompiler.items.add;
   new.Caption := IntToStr(sysScript.CompilerMessages[i].Row);
   new.SubItems.Add(IntToStr(sysScript.CompilerMessages[i].Col));
   new.SubItems.add(sysScript.CompilerMessages[i].ShortMessageToString);
   if pos('[Error]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 2
   else if pos('[Warning]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 1
   else if pos('[Hint]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 0;
 end;
 //S.Free;
 if not Result then
 begin
   if sysScript.CompilerMessageCount > 0 then
   begin
     for i:= 0 to sysScript.CompilerMessageCount - 1 do
     begin
       new := lvCompiler.items.add;
       new.Caption := IntToStr(sysScript.CompilerMessages[i].Row);
       new.SubItems.Add(IntToStr(sysScript.CompilerMessages[i].Col));
       new.SubItems.add(sysScript.CompilerMessages[i].ShortMessageToString);
       if pos('[Error]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 2
       else if pos('[Warning]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 1
       else if pos('[Hint]', sysScript.CompilerMessages[i].MessageToString)>0 then new.ImageIndex := 0;
     end;
   end;
 end;
 if lvCompiler.items.count - 1 > -1 then PageControl1.PageIndex := 1;
 new := lvCompiler.items.add;
 New.Caption := '';
 new.SubItems.add('');
 new.SubItems.add('Compile Generated at ' + DateTimeToStr(NOW));
 New.ImageIndex := 3;

end;

procedure TfrmMain.SaveAsk;
begin
  // Ask To SAve
  if Ask('Would you like to save first?') = mrNo then exit;
  if FFilename='' then
  begin
    if dlgSave.Execute then
    begin
      SaveFile(dlgSave.Filename);
    end;
  end else SaveFile(FFilename);
end;

Procedure TfrmMain.SaveFile(const Fname : String);
var
  uName : String;
begin
  if seEdit.lines.count-1 >=0 then
  begin
    if pos('unit ', seEdit.lines[0])>0 then
    begin
      uName := ExtractFileName(ChangeFileExt(fname,''));
      uName := StringReplace(uName, ' ' , '', [rfReplaceAll]);
      seEdit.lines[0] := 'unit ' + uName + ';';
    end;
  end;
  seEdit.Lines.SaveToFile(Fname);
  FFilename := FName;
  sbar.panels[5].text := FFilename;
  Application.title := ExtractFileName(FFilename);
  Caption := '[' + ExtractFileName(FFilename) + '] - deLite (' + FVersionInfo + ')';  seEdit.Modified := false;
  AddToMRU(Fname);
end;

procedure TfrmMain.LoadFile(const fname : String);
begin
 if (seEdit.Modified) and (FFilename<>'') then
 begin
   SaveAsk;
 end;
 seEdit.Lines.LoadFromFile(fname);
 FFilename := FName;
 sbar.panels[5].text := FFilename;
 Application.title := ExtractFileName(FFilename);
 Caption := '[' + ExtractFileName(FFilename) + '] - deLite (' + FVersionInfo + ')';
 seEdit.Modified := false;
 seEditChange(self);
 AddToMRU(Fname);
 nbEditors.PageIndex := 0;
 SpeedButton1.Down := True;
end;


procedure TfrmMain.DoVErsionCheck;
var
  url, LocalVersion: string;
  siteStr : TStringList;
begin
  // Version Check
  url := 'http://software.lucifael.com/deLite.html';
  LocalVersion :=  FVersionInfo;
  SiteStr := TStringList.Create;
  try
    URLDownloadStream(SiteStr, url);
    if SiteSTR.Count>=0 then
    BEGIN
      try
         FSiteVersion := SiteStr[0];
      except
            ShowMessagE('Unable to contact update server');
      end;
    end
    else
      FSiteVersion := LocalVersion;
  finally
    SiteStr.Free;
  end;
  if LocalVersion <> FSiteVersion then
  begin
//    ShowMessage('Version Update' + #10#13 + 'Local Version: ' + LocalVersion + #10#13 + 'Site Version: ' + SiteVersion);
      sbar.Panels[3].text := FVersionInfo + ' - ' + FSiteVersion;
    //ShowMessage('New Version Available');
  end
  else
  begin
    sbar.Panels[3].text := FVersionInfo + ' - ' + FSiteVersion;
  end;
end;

procedure TfrmMain.URLDownload(filename, url: string);
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

procedure TfrmMain.URLDownloadStream(filestream: TStringList; url: string);
var
  HTTP: THTTPSend;
begin
  HTTP := THTTPSend.Create;
  http.UserAgent:= 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1';
{  if fileExists(filename) then
    deleteFile(filename);
}  try
    if not HTTP.HTTPMethod('GET', url) then
    begin
      // ShowMessage('ERROR');
    end
    else
    begin
      //        ShowMessage(IntToStr(Http.Resultcode)+ ' '+ Http.Resultstring);
      //        ShowMessage(Http.headers.text);
      FileStream.LoadFromStream(http.document);
      //      http.document.SaveToStream(l);
    end;
  finally
    HTTP.Free;
    //    l.Free;
  end;
end;

procedure TfrmMain.HTMLGetImageX(Sender: TIpHtmlNode; const URL: string;
  var Picture: TPicture);
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

procedure TfrmMain.tvSolutionCreateNodeClass(Sender: TCustomTreeView;
  var NodeClass: TTreeNodeClass);
begin
     NodeClass := TMyTreeNode;
end;

procedure TfrmMain.tvSolutionDblClick(Sender: TObject);
var
  root : TTreeNode;
  sel : TMyTreeNode;
begin
  // Open the file, but only in editor if certain types alone.  Otherwise shell those out to windows
  if tvSolution.selected = nil then exit;
  if tvSolution.selected.level=0 then exit;
  root := tvSolution.selected.parent;
  sel := TMyTreeNode(tvSolution.selected);
  if (root.Text = 'Scripts') or (root.text='Includes') then
  begin
       if seEDit.Modified then SaveAsk;
       LoadFile(sel.Filename);
  end else
  begin
    OpenDocument(sel.Filename);
  end;
end;

procedure TfrmMain.txtHelpSearchKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
       // Do The Search
       btnSearchHelpClick(self);
  end;
end;

procedure TfrmMain.MakeLists;
var
   lst : TStringList;
   new : TListItem;
   A : Integer;
begin
     lvTemplates.items.clear;
     lvSnips.items.clear;
     lvExamples.clear;
     lst := TStringList.create;
     try
        lvTemplates.items.clear;
        GetFileList(dir.FTemplateDirectory, '*.deScript', lst);
        for a := 0 to lst.count - 1 do
        begin
          new := lvTemplates.items.add;
          new.Caption := ExtractFileName(ChangeFileExt(lst[a], ''));
          new.ImageIndex := 1;
        end;
        lst.clear;
        GetFileList(dir.FSnipDirectory, '*.deSnip', lst);
        for a := 0 to lst.count - 1 do
        begin
          new := lvSnips.items.add;
          new.Caption := ExtractFileName(ChangeFileExt(lst[a], ''));
          new.ImageIndex := 0;
        end;
        lst.clear;
        GetFileList(dir.FExamDirectory, '*.deScript', lst);
        for a := 0 to lst.count - 1 do
        begin
          new := lvExamples.items.add;
          new.Caption := ExtractFileName(ChangeFileExt(lst[a], ''));
          new.ImageIndex := 2;
        end;
        lst.clear;
     finally
       lst.free;
     end;
end;

procedure TfrmMain.ADDToMRU(const fname : String);
var
  ini : TBigInifile;
  lst : TStringList;
begin
     ini := TBigIniFile.create(FSettingsFile);
     try
        if ini.ReadBool('General', 'MRU', true) then
        begin
          lst := TStringList.create;
          try
             ini.ReadNumberedList('MRU', lst, '');
             if lst.IndexOf(fname) = -1 then lst.add(fname);
             ini.WriteNumberedList('MRU', lst);
          finally
            lst.free;
          end;
        end;
     finally
       ini.free;
     end;

end;

procedure TfrmMain.ADDToSolMRU(const fname : String);
var
  ini : TBigInifile;
  lst : TStringList;
begin
     ini := TBigIniFile.create(FSettingsFile);
     try
        if ini.ReadBool('General', 'SolMRU', true) then
        begin
          lst := TStringList.create;
          try
             ini.ReadNumberedList('SOLMRU', lst, '');
             if lst.IndexOf(fname) = -1 then lst.add(fname);
             ini.WriteNumberedList('SOLMRU', lst);
          finally
            lst.free;
          end;
        end;
     finally
       ini.free;
     end;
end;

procedure TfrmMain.LoadHelpURL(const URL : String);
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

procedure TfrmMain.LoadHelpFile(const filename : String);
var
  fs: TFileStream;
  NewHTML: TSimpleIpHtml;
begin
  //ShowMessage(ExtractFilePath(ParamStr(0)) + 'Help\Blank.html');
 if pos('HTTP:', uppercase(filename))>0 then LoadHelpURL(Filename);
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
      ShowTip('Unable to open HTMLFile' + #10#13 + ExtractFilename(Filename));
    end;
  end;
  end else
  begin
      ShowTip('Missing ' + Filename + #10#13 + 'For Loading into HTML Viewer');
  end;
end;


procedure TfrmMain.LoadTheme(Const filename : String);
var
  ini : TBiginiFile;
begin
     ini := TBigIniFile.create(filename);
     try
        { Editor}
        seEdit.Font.Name := ini.ReadString('Editor', 'FontName', 'Courier New');
        seEdit.Font.Size := ini.ReadInteger('Editor', 'FontSize', 10);
        if ini.ReadBool('Editor', 'Bold', False) then seEdit.Font.Style := seEdit.Font.Style + [fsBold];
        if ini.ReadBool('Editor', 'Italic', False) then seEdit.Font.Style := seEdit.Font.Style + [fsItalic];
        if ini.ReadBool('Editor', 'Underline', False) then seEdit.Font.Style := seEdit.Font.Style + [fsUnderline];
        seEdit.Font.Color := ini.ReadColor('Editor', 'Foreground', clWindowText);
        seEdit.Color:= ini.ReadColor('Editor', 'BackColor', clWindowText);
        { Comment }
        if ini.ReadBool('Comment', 'Bold', False) then  synPas.CommentAttri.Style := synPas.CommentAttri.Style + [fsBold];
        if ini.ReadBool('Comment', 'Italic', False) then synPas.CommentAttri.Style := synPas.CommentAttri.Style + [fsItalic];
        if ini.ReadBool('Comment', 'Underline', False) then synPas.CommentAttri.Style := synPas.CommentAttri.Style + [fsUnderline];
        synPas.CommentAttri.ForeGround := ini.ReadColor('Comment', 'Foreground', clWindowText);
        synPas.CommentAttri.BackGround := ini.ReadColor('Comment', 'BackColor', clWindow);
        { Keyword }
        if ini.ReadBool('Keyword', 'Bold', False) then  synPas.KeyAttri.Style := synPas.KeyAttri.Style + [fsBold];
        if ini.ReadBool('Keyword', 'Italic', False) then synPas.KeyAttri.Style := synPas.KeyAttri.Style + [fsItalic];
        if ini.ReadBool('Keyword', 'Underline', False) then synPas.KeyAttri.Style := synPas.KeyAttri.Style + [fsUnderline];
        synPas.KeyAttri.ForeGround := ini.ReadColor('Keyword', 'Foreground', clWindowText);
        synPas.KeyAttri.Background := ini.ReadColor('Keyword', 'BackColor', clWindow);
        { Numbers }
        if ini.ReadBool('Numbers', 'Bold', False) then  synPas.NumberAttri.Style := synPas.NumberAttri.Style + [fsBold];
        if ini.ReadBool('Numbers', 'Italic', False) then synPas.NumberAttri.Style := synPas.NumberAttri.Style + [fsItalic];
        if ini.ReadBool('Numbers', 'Underline', False) then synPas.NumberAttri.Style := synPas.NumberAttri.Style + [fsUnderline];
        synPas.NumberAttri.Foreground := ini.ReadColor('Numbers', 'Foreground', clWindowText);
        synPas.NumberAttri.Background := ini.ReadColor('Numbers', 'BackColor', clWindow);
        { Strings }
        if ini.ReadBool('Strings', 'Bold', False) then synPas.StringAttri.Style := synPas.StringAttri.Style + [fsBold];
        if ini.ReadBool('Strings', 'Italic', False) then synPas.StringAttri.Style := synPas.StringAttri.Style + [fsItalic];
        if ini.ReadBool('Strings', 'Underline', False) then synPas.StringAttri.Style := synPas.StringAttri.Style + [fsUnderline];
        synPas.StringAttri.Foreground := ini.ReadColor('Strings', 'Foreground', clWindowText);
        synPas.StringAttri.Background := ini.ReadColor('Strings', 'BackColor', clWindow);
        { Symbols }
        if ini.ReadBool('Symbols', 'Bold', False) then synPas.SymbolAttri.Style := synPas.SymbolAttri.Style + [fsBold];
        if ini.ReadBool('Symbols', 'Italic', False) then synPas.SymbolAttri.Style := synPas.SymbolAttri.Style + [fsItalic];
        if ini.ReadBool('Symbols', 'Underline', False) then synPas.SymbolAttri.Style := synPas.SymbolAttri.Style + [fsUnderline];
        synPas.SymbolAttri.Foreground := ini.ReadColor('Symbols', 'Foreground', clWindowText);
        synPas.SymbolAttri.BackGround := ini.ReadColor('Symbols', 'BackColor', clWindow);
     finally
       ini.free;
     end;
end;

procedure TfrmMain.NewSolution;
var
  root : TTreeNode;
begin
     FSolution := '';
     Root := GetSByState(0);
     Root.DeleteChildren;
     Root := GetSByState(1);
     Root.DeleteChildren;
     Root := GetSByState(2);
     Root.DeleteChildren;
     Root := GetSByState(3);
     Root.DeleteChildren;
     FSolutionLoaded := false;
end;

procedure TfrmMain.LoadSolution(const Fname : String);
var
  root : TTreeNode;
  ini : TBigInifile;
  new : TMyTreeNode;
  lst : TStringList;
  FMain : String;
  a : Integer;
begin
     NewSolution;
     FSolution := fname;
     FSolutionLoaded := true;
     ADDToSolMRU(FSolution);
     PageControl2.PageIndex := 1;
     ini := TBigIniFile.create(Fname);
     try
        FMain := ini.ReadString('General', 'Main','');
        if ini.ReadBool('General', 'LoadMain', true) then
        begin
             if FMain<>'' then LoadFile(FMain);
        end;
        lst := TStringList.create;
        try
          // Get Scripts
          lst.clear;
          Root := GetSByState(0);
          ini.ReadNumberedList('Scripts', lst, '');
          for a := 0 to lst.count - 1 do
          begin
               new := TMyTreeNode(tvSolution.items.AddChild(Root, ExtractFilename(lst[a])));
               new.Filename := lst[a];
               new.ImageIndex := 0;
               new.SelectedIndex := 0;
          end;

          // Get Includes
          lst.clear;
          Root := GetSByState(1);
          ini.ReadNumberedList('Includes', lst, '');
          for a := 0 to lst.count - 1 do
          begin
               new := TMyTreeNode(tvSolution.items.AddChild(Root, ExtractFilename(lst[a])));
               new.Filename := lst[a];
               new.ImageIndex := 1;
               new.SelectedIndex := 1;
          end;

          // Get Resources
          lst.clear;
          Root := GetSByState(2);
          ini.ReadNumberedList('Resources', lst, '');
          for a := 0 to lst.count - 1 do
          begin
               new := TMyTreeNode(tvSolution.items.AddChild(Root, ExtractFilename(lst[a])));
               new.Filename := lst[a];
               new.ImageIndex := 2;
               new.SelectedIndex := 2;
          end;

          // Get Other
          lst.clear;
          Root := GetSByState(3);
          ini.ReadNumberedList('Other', lst, '');
          for a := 0 to lst.count - 1 do
          begin
               new := TMyTreeNode(tvSolution.items.AddChild(Root, ExtractFilename(lst[a])));
               new.Filename := lst[a];
               new.ImageIndex := 3;
               new.SelectedIndex := 3;
          end;
        finally
          lst.free;
        end;
     finally
       ini.free;
     end;
end;

procedure TfrmMain.SaveSolution(const Fname : String);
var
  root : TTreeNode;
  ini : TBigInifile;
  lst : TStringList;
  a : Integer;
begin
     FSolution := fname;
     ADDToSolMRU(FSolution);
     FSolutionLoaded := true;
     ini := TBigIniFile.create(Fname);
     try
        lst := TStringList.create;
        try
          // Get Scripts
          Root := GetSByState(0);
          lst.clear;

          for a := 0 to Root.count - 1 do lst.add(TMyTreeNode(Root.items[a]).Filename);
          ini.WriteNumberedList('Scripts', lst);

          // Get Includes
          lst.clear;
          Root := GetSByState(1);
          for a := 0 to Root.count - 1 do lst.add(TMyTreeNode(Root.items[a]).Filename);
          ini.WriteNumberedList('Includes', lst);

          // Get Resources
          lst.clear;
          Root := GetSByState(2);
          for a := 0 to Root.count - 1 do lst.add(TMyTreeNode(Root.items[a]).Filename);
          ini.WriteNumberedList('Resources', lst);

          // Get Other
          lst.clear;
          Root := GetSByState(3);
          for a := 0 to Root.count - 1 do lst.add(TMyTreeNode(Root.items[a]).Filename);
          ini.WriteNumberedList('Other', lst);
        finally
          lst.free;
        end;
     finally
       ini.free;
     end;
end;

function TfrmMain.IsInSolution(const ToCheck : String) : Boolean;
var
  a : Integer;
  sel : TMyTreeNode;
begin
 result := false;
 for a := 0 to tvSolution.items.count - 1 do
 begin
   sel := TMyTreeNode(tvSolution.items.item[a]);
   if sel.level=1 then
   begin
        if lowercase(sel.filename) = lowercase(ToCheck) then result := true;
   end;
 end;
end;

procedure TfrmMain.SetBottom;
var
  I : Integer;
begin
 for i := 1 to lvCompiler.Items.count - 1 do
    SendMessage(lvCompiler.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

end.

