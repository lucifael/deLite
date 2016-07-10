unit uIDE;

{$mode objfpc}{$H+}



interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Menus, ActnList, frameBrowser;

type
  TProfile = record
    UserName : String;
    SnipDir, TemplateDir, WizardDir, TutorialDir, DesktopDir : String;
end;
type
    TTabManager = record
      Name : String;                 // A Nice name to search by
      Tab : TTabSheet;               // Keep record of the tab sheet for deleting later
      Frame : TFrame;                // Keep record of the frame to cast into our types
      tabType : Byte;                // Keep record of the type of Tab it is.
end;

type

  { TfrmIDE }

  TfrmIDE = class(TForm)
    actFileNewScriptFromTemplate: TAction;
    actFileClose: TAction;
    actFileNewFormLayout: TAction;
    actFileNewFormFromTemplate: TAction;
    actFileUndoLastClose: TAction;
    actEditCut: TAction;
    actEditCopy: TAction;
    actEditPaste: TAction;
    actEditGotoLine: TAction;
    actEditTranspose: TAction;
    actEditCommentLine: TAction;
    actEditCommentBlock: TAction;
    actEditFind: TAction;
    actEditReplace: TAction;
    actEditInsertFromFile: TAction;
    actEditInsertTimeStamp: TAction;
    actEditSelectAll: TAction;
    actHelpLanguageManual: TAction;
    actHelpContents: TAction;
    actHelpLicenses: TAction;
    actHelpAbout: TAction;
    actFileExit: TAction;
    actDesktopNew: TAction;
    actDesktopOpen: TAction;
    actDesktopSave: TAction;
    actDesktopSaveAs: TAction;
    actDesktopOther: TAction;
    actFileNewLevel: TAction;
    actFileNewLevelFromTemplate: TAction;
    actProjectExportProject: TAction;
    actViewSolutionOutput: TAction;
    actProjectOpen: TAction;
    actViewHome: TAction;
    actViewRuntimeOutput: TAction;
    actViewLog: TAction;
    actViewSnippet: TAction;
    actViewToolOutput: TAction;
    actViewSolutionManager: TAction;
    actToolsTutorialRepo: TAction;
    actToolsPreferences: TAction;
    actToolsInstallTools: TAction;
    actToolsCleanupTemp: TAction;
    actToolsLibInst: TAction;
    actToolsExampleRepo: TAction;
    actToolsConfigureExternalTools: TAction;
    actRunBind: TAction;
    actRunRun: TAction;
    actRunSyntaxCheck: TAction;
    actProjectSettings: TAction;
    actProjectCleanUp: TAction;
    actProjectImportProject: TAction;
    actProjectClose: TAction;
    actProjectSaveProject: TAction;
    actFileNewEmptyScript: TAction;
    actProjectNew: TAction;
    actFileSaveCurrent: TAction;
    alCappo: TActionList;
    ilActions: TImageList;
    MenuItem73: TMenuItem;
    MenuItem74: TMenuItem;
    MenuItem75: TMenuItem;
    MenuItem76: TMenuItem;
    MenuItem77: TMenuItem;
    MenuItem78: TMenuItem;
    MenuItem79: TMenuItem;
    MenuItem80: TMenuItem;
    MenuItem81: TMenuItem;
    MenuItem82: TMenuItem;
    MenuItem83: TMenuItem;
    MenuItem84: TMenuItem;
    MenuItem85: TMenuItem;
    MenuItem86: TMenuItem;
    MenuItem87: TMenuItem;
    MenuItem88: TMenuItem;
    MenuItem89: TMenuItem;
    MenuItem90: TMenuItem;
    MenuItem91: TMenuItem;
    MenuItem92: TMenuItem;
    MenuItem93: TMenuItem;
    MenuItem94: TMenuItem;
    MenuItem95: TMenuItem;
    sysApp: TApplicationProperties;
    CoolBar1: TCoolBar;
    MainMenu1: TMainMenu;
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
    MenuItem26: TMenuItem;
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
    MenuItem40: TMenuItem;
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
    MenuItem65: TMenuItem;
    MenuItem66: TMenuItem;
    MenuItem67: TMenuItem;
    MenuItem68: TMenuItem;
    MenuItem69: TMenuItem;
    MenuItem70: TMenuItem;
    MenuItem71: TMenuItem;
    MenuItem72: TMenuItem;
    mnuTutorials: TMenuItem;
    mnuTools: TMenuItem;
    mnuMRUP: TMenuItem;
    mnuMRU: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    pcBottom: TPageControl;
    pcSource: TPageControl;
    pcProject: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    tsMain: TTabSheet;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolBar3: TToolBar;
    ToolBar4: TToolBar;
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
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure actToolsPreferencesExecute(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure pcSourceChange(Sender: TObject);
    procedure sysHTMLClick(Sender: TObject);
  private
    { private declarations }
    procedure TM_Init;
    function TM_FindFree(typ : byte) : Integer;
    procedure TM_CreateTab(const nme, fname : String; tabType : Byte);
    procedure TM_DeleteTab(const IDX : Integer; typ : Byte);
    function TM_FindByName(const nme : String; typ : Byte) : Integer;
    function TM_TabExists(const idx : Integer; typ : Byte) : Boolean;
    function TM_FindByFilename(const fname : String; typ : Byte) : Integer;
    procedure TM_MakeActiveTab(const IDX : Integer; typ : Byte);
  public
    { public declarations }
    profRecord : TProfile;
    TM_EditorTab : array[0..1024] of TTabManager;
    TM_BottomTab : array[0..100] of TTabManager;
    TM_ProjectTab : array[0..255] of TTabManager;
    TM_Editor_TopIDX : Integer;
    TM_Bottom_TopIDX : Integer;
    TM_Project_TopIDX : Integer;
  end;

var
  frmIDE: TfrmIDE;

CONST ProgName                       = 'Cappuccino deLite IDE';
CONST ProgVer                        = 'v1.0 pre-alpha';
CONST TT_Editor                      = 0;
CONST TT_Bottom                      = 1;
CONST TT_Project                     = 2;
CONST TM_Browser                     = 0;
CONST TM_Editor                      = 1;

implementation

{$R *.lfm}

uses frameEditor, frameRTOutput, frameScriptOutput, frameToolOutput, frameSolution,
  frameSnip;

{ TfrmIDE }

procedure TfrmIDE.MenuItem2Click(Sender: TObject);
var
  ts : TTabSheet;
  fra : TframeEditor;
begin
  // Try stuff here
  ts := pcSource.AddTabSheet;
  fra := TframeEditor.Create(ts);
  fra.Parent := ts;
  fra.FFilename := 'Untitled';
  fra.ParentTab := ts;
  fra.Align := alClient;
  ts.Caption := 'Untitled';
  ts.Tag := 1;
end;

procedure TfrmIDE.actToolsPreferencesExecute(Sender: TObject);
begin

end;

procedure TfrmIDE.pcSourceChange(Sender: TObject);
begin

end;

procedure TfrmIDE.sysHTMLClick(Sender: TObject);
begin

end;

procedure TfrmIDE.TM_Init;
begin

end;

function TfrmIDE.TM_FindFree(typ : byte) : Integer;
var
  i, rtn : Integer;
  ok : Boolean;
begin
  rtn := -1;
  if typ = 0 then                        // Editor Pane
  begin
    ok := false;
    for i := 0 to high(TM_EditorTab) do
    begin
      if tm_EditorTab[i].Name = '' then
      begin
        ok := true;
        rtn := i;
        break;
      end;
    end;
  end else if typ = 1 then                 // Bottom
  begin
    for i := 0 to high(TM_BottomTab) do
    begin
      if tm_BottomTab[i].Name = '' then
      begin
        ok := true;
        rtn := i;
        break;
      end;
    end;
  end else if typ = 2 then                 // Solution Pane
  begin
    for i := 0 to high(TM_ProjectTab) do
    begin
      if TM_ProjectTab[i].Name = '' then
      begin
        ok := true;
        rtn := i;
        break;
      end;
    end;
  end;
  if ok then result := rtn else result := -1;
end;
procedure TfrmIDE.TM_CreateTab(const nme, fname : String; tabType : Byte);
var
  ts : TTabsheet;
  idx : Integer;
  Fra_Browser : TframeBrowser;
  Fra_RuntimeOutput : TframeOutput;
  Fra_ScriptOutput : TframeScriptOutput;
  Fra_ToolOutput : TframeToolOutput;
  Fra_Output : TframeOutput;
  Fra_Solution : TframeSolution;
  Fra_Editor : TframeEditor;
  Fra_Snip : TframeSnip;
begin
     if tabType = 0 then                                          // Browser/Help Browser Tab
     begin
       idx := TM_FindFree(TT_Editor);
       if idx = -1 then
       begin
            // Change this to some sort of raise event!!!
            ShowMessage('Unable to add another tab of the editor type');
            exit;
       end;
       ts := pcSource.AddTabSheet;
       ts.Caption := nme;
       fra_Browser := TframeBrowser.create(ts);
       fra_Browser.Parent := ts;
       fra_Browser.LoadFromFile(fname);
       TM_EditorTab[IDX].Name := Nme;
       TM_EditorTab[IDX].Tab := ts;
       TM_EditorTab[IDX].Frame := fra_Browser;
       TM_EditorTab[IDX].tabType := tabType;
     end else if tabType = 1 then                                 // Normal Script Editor
     begin
       idx := TM_FindFree(TT_Editor);
       if idx = -1 then
       begin
            // Change this to some sort of raise event!!!
            ShowMessage('Unable to add another tab of the editor type');
            exit;
       end;
       ts := pcSource.AddTabSheet;
       ts.Caption := nme;
       fra_Editor := TframeEditor.create(ts);
       fra_Editor.Parent := ts;
       fra_Editor.LoadFromFile(fname);
       Fra_Editor.align := alClient;
       TM_EditorTab[IDX].Name := Nme;
       TM_EditorTab[IDX].Tab := ts;
       TM_EditorTab[IDX].Frame := fra_Editor;
       TM_EditorTab[IDX].tabType := tabType;
     end else if tabType = 2 then                                 // Run Time Output, Bottom Bar
     begin
       idx := TM_FindFree(TT_Bottom);
       if idx = -1 then
       begin
            // Change this to some sort of raise event!!!
            ShowMessage('Unable to add another tab of the Bottom Pane type');
            exit;
       end;
       ts := pcBottom.AddTabSheet;
       ts.Caption := nme;
       Fra_RuntimeOutput := TframeOutput.create(ts);
       Fra_RuntimeOutput.Parent := ts;
       Fra_RuntimeOutput.align := alClient;
       TM_BottomTab[IDX].Name := Nme;
       TM_BottomTab[IDX].Tab := ts;
       TM_BottomTab[IDX].Frame := Fra_RuntimeOutput;
       TM_BottomTab[IDX].tabType := tabType;
     end else if tabType = 3 then                                 // Script Output Bar
     begin
       idx := TM_FindFree(TT_Bottom);
       if idx = -1 then
       begin
            // Change this to some sort of raise event!!!
            ShowMessage('Unable to add another tab of the Bottom Pane type');
            exit;
       end;
       ts := pcBottom.AddTabSheet;
       ts.Caption := nme;
       Fra_ScriptOutput := TframeScriptOutput.create(ts);
       Fra_ScriptOutput.Parent := ts;
       Fra_ScriptOutput.align := alClient;
       TM_BottomTab[IDX].Name := Nme;
       TM_BottomTab[IDX].Tab := ts;
       TM_BottomTab[IDX].Frame := Fra_ScriptOutput;
       TM_BottomTab[IDX].tabType := tabType;
     end else if tabType = 4 then                                 // Tool Output Bar
     begin
       idx := TM_FindFree(TT_Bottom);
       if idx = -1 then
       begin
            // Change this to some sort of raise event!!!
            ShowMessage('Unable to add another tab of the Bottom Pane type');
            exit;
       end;
       ts := pcBottom.AddTabSheet;
       ts.Caption := nme;
       Fra_ToolOutput := TframeToolOutput.create(ts);
       Fra_ToolOutput.Parent := ts;
       Fra_ToolOutput.align := alClient;
       TM_BottomTab[IDX].Name := Nme;
       TM_BottomTab[IDX].Tab := ts;
       TM_BottomTab[IDX].Frame := Fra_ToolOutput;
       TM_BottomTab[IDX].tabType := tabType;
     end else if tabType = 5 then                                 // Solution Editor
     begin
       idx := TM_FindFree(TT_Project);
       if idx = -1 then
       begin
            // Change this to some sort of raise event!!!
            ShowMessage('Unable to add another tab of the Project Pane type');
            exit;
       end;
       ts := pcProject.AddTabSheet;
       ts.Caption := nme;
       Fra_Solution := TframeSolution.create(ts);
       Fra_Solution.Parent := ts;
       Fra_Solution.LoadFromFile(Fname);
       Fra_Solution.align := alClient;
       TM_ProjectTab[IDX].Name := Nme;
       TM_ProjectTab[IDX].Tab := ts;
       TM_ProjectTab[IDX].Frame := Fra_Solution;
       TM_ProjectTab[IDX].tabType := tabType;
     end else if tabType = 6 then                                 // Snips Browser
     begin
       idx := TM_FindFree(TT_Project);
       if idx = -1 then
       begin
            // Change this to some sort of raise event!!!
            ShowMessage('Unable to add another tab of the Project Pane type');
            exit;
       end;
       ts := pcProject.AddTabSheet;
       ts.Caption := nme;
       Fra_Snip := TframeSnip.create(ts);
       Fra_Snip.Parent := ts;
       Fra_Snip.align := alClient;
       TM_ProjectTab[IDX].Name := Nme;
       TM_ProjectTab[IDX].Tab := ts;
       TM_ProjectTab[IDX].Frame := Fra_Snip;
       TM_ProjectTab[IDX].tabType := tabType;
     end else if tabType = 7 then                                 // General Multi Syn Editor
     begin
          // General Editor File
       idx := TM_FindFree(TT_Editor);
       if idx = -1 then
       begin
            // Change this to some sort of raise event!!!
            ShowMessage('Unable to add another tab of the Editor Pane type');
            exit;
       end;
       ts := pcSource.AddTabSheet;
       ts.Caption := nme;
       Fra_Snip := TframeSnip.create(ts);
       Fra_Snip.Parent := ts;
       Fra_Snip.align := alClient;
       TM_EditorTab[IDX].Name := Nme;
       TM_EditorTab[IDX].Tab := ts;
       TM_EditorTab[IDX].Frame := Fra_Snip;
       TM_EditorTab[IDX].tabType := tabType;
     end else if tabType = 8 then                                 // Output Output
     begin
       idx := TM_FindFree(TT_Bottom);
       if idx = -1 then
       begin
            // Change this to some sort of raise event!!!
            ShowMessage('Unable to add another tab of the Bottom Pane type');
            exit;
       end;
       ts := pcBottom.AddTabSheet;
       ts.Caption := nme;
       Fra_Output := TframeOutput.create(ts);
       Fra_Output.Parent := ts;
       Fra_Output.align := alClient;
       TM_BottomTab[IDX].Name := Nme;
       TM_BottomTab[IDX].Tab := ts;
       TM_BottomTab[IDX].Frame := Fra_Output;
       TM_BottomTab[IDX].tabType := tabType;
     end;
end;

procedure TfrmIDE.TM_DeleteTab(const IDX : Integer; typ : Byte);
const
  toSave = [1,7,5];
begin
  if typ = TT_Editor then
  begin
    if TM_EditorTab[idx].tabType in toSave then TframeEditor(TM_EditorTab[idx].Frame).CheckSave;
    TM_EditorTab[idx].Frame.Free;
    TM_EditorTab[idx].Tab.Free;
  end else if typ = TT_Bottom then
  begin
    TM_BottomTab[idx].Frame.Free;
    TM_BottomTab[idx].Tab.Free;
  end else if typ = TT_Project then
  begin
    if TM_ProjectTab[idx].tabType in toSave then TframeSolution(TM_ProjectTab[idx].Frame).CheckSave;
    TM_ProjectTab[idx].Frame.Free;
    TM_ProjectTab[idx].Tab.Free;
  end;

end;

procedure TfrmIDE.TM_MakeActiveTab(const IDX : Integer; typ : Byte);
begin
  if typ = TT_Editor then
  begin
    pcSource.ActivePage := TM_EditorTab[idx].Tab;
  end else if typ = TT_Bottom then
  begin
    pcBottom.ActivePage := TM_BottomTab[idx].Tab;
  end else if typ = TT_Project then
  begin
    pcProject.ActivePage := TM_ProjectTab[idx].Tab;
  end;
end;


function TfrmIDE.TM_FindByName(const nme : String; typ : Byte) : Integer;
var
  ok : Boolean;
  i, idx : Integer;
begin
  ok := false;
  idx := -1;
  if typ = TT_Editor then
  begin
      for i := low(TM_EDitorTab) to high(TM_EDitorTab) do
      begin
        if tm_EDitorTab[i].name = nme then
          begin
            idx := i;
            ok := true;
            break;
          end;
      end;
  end else if typ = TT_Bottom then
  begin
    for i := low(TM_BottomTab) to high(TM_BottomTab) do
    begin
      if TM_BottomTab[i].name = nme then
        begin
          idx := i;
          ok := true;
          break;
        end;
    end;
  end else if typ = TT_Project then
  begin
    for i := low(TM_ProjectTab) to high(TM_ProjectTab) do
    begin
      if TM_ProjectTab[i].name = nme then
        begin
          idx := i;
          ok := true;
          break;
        end;
    end;
  end;
  if ok then result := idx else result := -1;
end;

function TfrmIDE.TM_TabExists(const idx : Integer; typ : Byte) : Boolean;
begin
     result := false;
     if typ = TT_Editor then result := assigned(TM_EditorTab[idx].Tab)
     else if typ = TT_Bottom then result := assigned(TM_BottomTab[idx].tab)
     else if typ = TT_Project then result := assigned(TM_ProjectTab[idx].tab);
end;

function TfrmIDE.TM_FindByFilename(const fname : String; typ : Byte) : Integer;
var
  ok : Boolean;
  i, idx : Integer;
const
  toSave = [1,7,5];
begin
  idx := -1;
  ok := false;
     if typ = TT_Editor then
     begin
       for i := low(TM_EditorTab) to high(TM_EditorTab) do
       begin
         if TM_EditorTab[i].tabType in ToSave then
         begin
              if TframeEditor(TM_EditorTab[i].Frame).FFilename = fname then
              begin
                idx := i;
                ok := true;
                break;
              end;
         end;
       end;
     end else if typ = TT_Project then
     begin
       for i := low(TM_ProjectTab) to high(TM_ProjectTab) do
       begin
         if TM_ProjectTab[i].tabType in ToSave then
         begin
              if TframeSolution(TM_ProjectTab[i].Frame).FFilename = fname then
              begin
                idx := i;
                ok := true;
                break;
              end;
         end;
       end;
     end;
     if ok then result := idx else result := -1;
end;



end.

