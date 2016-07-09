unit uSettings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynMemo, SynHighlighterPas, Forms, Controls,
  Graphics, Dialogs, ComCtrls, Buttons, ExtCtrls, StdCtrls, types,
  BigIni, uMain, utip, uAsk, iniFiles;

type

  { TfrmSettings }

  TfrmSettings = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    btnCommentBG1: TColorButton;
    btnCommentBG2: TColorButton;
    btnCommentBG3: TColorButton;
    btnCommentBG4: TColorButton;
    btnCommentBG5: TColorButton;
    btnCommentBold1: TSpeedButton;
    btnCommentBold2: TSpeedButton;
    btnCommentBold3: TSpeedButton;
    btnCommentBold4: TSpeedButton;
    btnCommentBold5: TSpeedButton;
    btnCommentFG1: TColorButton;
    btnCommentFG2: TColorButton;
    btnCommentFG3: TColorButton;
    btnCommentFG4: TColorButton;
    btnCommentFG5: TColorButton;
    btnCommentItalic1: TSpeedButton;
    btnCommentItalic2: TSpeedButton;
    btnCommentItalic3: TSpeedButton;
    btnCommentItalic4: TSpeedButton;
    btnCommentItalic5: TSpeedButton;
    btnCommentUnderline1: TSpeedButton;
    btnCommentUnderline2: TSpeedButton;
    btnCommentUnderline3: TSpeedButton;
    btnCommentUnderline4: TSpeedButton;
    btnCommentUnderline5: TSpeedButton;
    chkMRU: TCheckBox;
    chkTips: TCheckBox;
    btnCommentBG: TColorButton;
    btnCommentFG: TColorButton;
    btnCommentBold: TSpeedButton;
    btnCommentItalic: TSpeedButton;
    btnCommentUnderline: TSpeedButton;
    cboThemes: TComboBox;
    dlgFont: TFontDialog;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    ilThemes: TImageList;
    lvThemes: TListView;
    SpeedButton1: TSpeedButton;
    ToolBar6: TToolBar;
    ToolBar7: TToolBar;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    txtComment: TEdit;
    GroupBox1: TGroupBox;
    ilSettings: TImageList;
    ilScriptIcon: TImageList;
    Label3: TLabel;
    lblTitle: TLabel;
    lvQuick: TListView;
    lvHourly: TListView;
    lvLaunch: TListView;
    lvClose: TListView;
    lvInterface: TListView;
    nbSettings: TNotebook;
    dlgScript: TOpenDialog;
    Page1: TPage;
    PageControl1: TPageControl;
    pgSceheduled: TPage;
    Page3: TPage;
    Page4: TPage;
    Page5: TPage;
    Page6: TPage;
    Page7: TPage;
    Panel1: TPanel;
    Panel2: TPanel;
    seDefault: TSynMemo;
    SynPasSyn1: TSynPasSyn;
    ToolBar3: TToolBar;
    ToolBar4: TToolBar;
    ToolBar5: TToolBar;
    ToolButton10: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    tsOnClose: TTabSheet;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    tsHourly: TTabSheet;
    tsOnLaunch: TTabSheet;
    TreeView1: TTreeView;
    txtKeyword: TEdit;
    txtNumbers: TEdit;
    txtStrings: TEdit;
    txtSymbols: TEdit;
    txtEditor: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnCommentBGColorChanged(Sender: TObject);
    procedure btnCommentBoldClick(Sender: TObject);
    procedure btnCommentFGColorChanged(Sender: TObject);
    procedure btnCommentItalicClick(Sender: TObject);
    procedure btnCommentUnderlineClick(Sender: TObject);
    procedure cboThemesChange(Sender: TObject);
    procedure cboThemesDropDown(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
  private
    { private declarations }
    procedure MakeThemeList;
  public
    { public declarations }
    procedure LoadSettings;
    procedure SaveSettings;
    procedure LoadTheme(Const filename : String);
    procedure SaveTheme(Const filename : String);
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.lfm}

{ TfrmSettings }

procedure TfrmSettings.TreeView1Click(Sender: TObject);
begin
  if TreeView1.Selected = nil then exit;
  if TreeView1.Selected.StateIndex <> -1 then nbSettings.PageIndex := treeview1.Selected.StateIndex;
  lblTitle.Caption := treeview1.selected.text;
end;


procedure TfrmSettings.ToolButton1Click(Sender: TObject);
var
  new : TListItem;
  fname : STring;
begin
  if dlgScript.execute then
  begin
    fname := dlgScript.filename;
    new := lvHourly.items.add;
    new.Caption := ExtractFileName(ChangeFileExt(fname, ''));
    new.SubItems.Add(fname);
    new.ImageIndex := 0;
  end;

end;

procedure TfrmSettings.ToolButton10Click(Sender: TObject);
begin
  if lvInterface.Selected = nil then exit;
  lvInterface.items.Delete(lvInterface.Selected.Index);
end;

procedure TfrmSettings.ToolButton11Click(Sender: TObject);
var
  fname : String;
begin
  fname := AskText('Enter Filename (no ext)');
  if fname = '' then exit;
  fname := frmMain.Dir.FThemeDirectory + fname + '.deTheme';
  ShowMessage(Fname);
  SaveTheme(Fname);
  MakeThemeList;
end;

procedure TfrmSettings.ToolButton13Click(Sender: TObject);
var
  fname : String;
begin
     if lvThemes.Selected = nil then exit;
     fname := lvThemes.Selected.SubItems[0];
     if Ask('Are you sure?') = mrYes then
     begin
       deleteFile(Fname);
       lvThemes.Selected.free;
     end;
end;

procedure TfrmSettings.ToolButton14Click(Sender: TObject);
var
  fname : String;
begin
  if lvThemes.Selected = nil then;
  fname := AskText('Enter Filename (no ext)');
  if fname = '' then exit;
  fname := frmMain.Dir.FThemeDirectory + fname + '.deTheme';
  CopyFile(lvThemes.selected.SubItems[0], Fname);
  MakeThemeList;
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
begin
     MakeThemeList;
     LoadSettings;
end;

procedure TfrmSettings.SpeedButton1Click(Sender: TObject);
var
  fnt : TFont;
begin
     dlgFont.font := txtEditor.Font;
     if dlgFont.execute then
     begin
       fnt := dlgFont.Font;
       txtEditor.font.Name:=fnt.Name;
       txtEditor.Font.Size := fnt.Size;
       txtEditor.Font.Style:= fnt.Style;
     end;
end;

procedure TfrmSettings.BitBtn1Click(Sender: TObject);
begin
  SaveSettings;
  // Apply Editor Settings
end;

procedure TfrmSettings.btnCommentBGColorChanged(Sender: TObject);
begin
  if TColorButton(sender).hint = 'Comment' then txtComment.Color := TColorButton(sender).buttonColor
  else if TColorButton(sender).hint = 'Keyword' then txtKeyWord.Color := TColorButton(sender).buttonColor
  else if TColorButton(sender).hint = 'Numbers' then txtNumbers.Color := TColorButton(sender).buttonColor
  else if TColorButton(sender).hint = 'Strings' then txtStrings.Color := TColorButton(sender).buttonColor
  else if TColorButton(sender).hint = 'Symbols' then txtSymbols.Color := TColorButton(sender).buttonColor
  else if TColorButton(sender).hint = 'Editor' then txtEditor.Color := TColorButton(sender).buttonColor
end;

procedure TfrmSettings.btnCommentBoldClick(Sender: TObject);
begin
  if TSpeedButton(Sender).tag = 0 then TSpeedButton(Sender).tag := 1 else TSpeedButton(Sender).tag := 0;
  TSpeedButton(Sender).down := TSpeedButton(Sender).tag = 1;
  if TSpeedButton(Sender).hint = 'Comment' then
  begin
     if TSpeedButton(Sender).tag = 1 then txtComment.Font.Style:= txtComment.Font.Style + [fsBold] else txtComment.Font.Style:= txtComment.Font.Style - [fsBold];
  end else if TSpeedButton(Sender).hint = 'Keyword' then
  begin
     if TSpeedButton(Sender).tag = 1 then txtKeyword.Font.Style:= txtKeyword.Font.Style + [fsBold] else txtKeyword.Font.Style:= txtKeyword.Font.Style - [fsBold];
  end else if TSpeedButton(Sender).hint = 'Numbers' then
  begin
     if TSpeedButton(Sender).tag = 1 then txtNumbers.Font.Style:= txtNumbers.Font.Style + [fsBold] else txtNumbers.Font.Style:= txtNumbers.Font.Style - [fsBold];
  end else if TSpeedButton(Sender).hint = 'Strings' then
  begin
     if TSpeedButton(Sender).tag = 1 then txtStrings.Font.Style:= txtStrings.Font.Style + [fsBold] else txtStrings.Font.Style:= txtStrings.Font.Style - [fsBold];
  end else if TSpeedButton(Sender).hint = 'Symbols' then
  begin
     if TSpeedButton(Sender).tag = 1 then txtSymbols.Font.Style:= txtSymbols.Font.Style + [fsBold] else txtSymbols.Font.Style:= txtSymbols.Font.Style - [fsBold];
  end else if TSpeedButton(Sender).hint = 'Editor' then
  begin
     if TSpeedButton(Sender).tag = 1 then txtEditor.Font.Style:= txtEditor.Font.Style + [fsBold] else txtEditor.Font.Style:= txtEditor.Font.Style - [fsBold];
  end;

end;

procedure TfrmSettings.btnCommentFGColorChanged(Sender: TObject);
begin
     if TColorButton(sender).Hint = 'Comment' then txtComment.Font.color := TColorButton(Sender).buttonColor
     else if TColorButton(sender).Hint = 'Keyword' then txtKeyword.Font.color := TColorButton(Sender).buttonColor
     else if TColorButton(sender).Hint = 'Numbers' then txtNumbers.Font.color := TColorButton(Sender).buttonColor
     else if TColorButton(sender).Hint = 'Strings' then txtStrings.Font.color := TColorButton(Sender).buttonColor
     else if TColorButton(sender).Hint = 'Symbols' then txtSymbols.Font.color := TColorButton(Sender).buttonColor
     else if TColorButton(sender).Hint = 'Editor' then txtEditor.Font.color := TColorButton(Sender).buttonColor
end;

procedure TfrmSettings.btnCommentItalicClick(Sender: TObject);
begin
  if TSpeedButton(Sender).tag = 0 then TSpeedButton(Sender).tag := 1 else TSpeedButton(Sender).tag := 0;
  TSpeedButton(Sender).down := TSpeedButton(Sender).tag = 1;
  if TSpeedButton(Sender).hint = 'Comment' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtComment.Font.Style:= txtComment.Font.Style + [fsItalic] else txtComment.Font.Style:= txtComment.Font.Style - [fsItalic]
  end else if TSpeedButton(Sender).hint = 'Keyword' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtKeyWord.Font.Style:= txtKeyWord.Font.Style + [fsItalic] else txtKeyword.Font.Style:= txtKeyword.Font.Style - [fsItalic]
  end else if TSpeedButton(Sender).hint = 'Numbers' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtNumbers.Font.Style:= txtNumbers.Font.Style + [fsItalic] else txtNumbers.Font.Style:= txtNumbers.Font.Style - [fsItalic]
  end else if TSpeedButton(Sender).hint = 'Strings' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtStrings.Font.Style:= txtStrings.Font.Style + [fsItalic] else txtStrings.Font.Style:= txtStrings.Font.Style - [fsItalic]
  end else if TSpeedButton(Sender).hint = 'Symbols' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtSymbols.Font.Style:= txtSymbols.Font.Style + [fsItalic] else txtSymbols.Font.Style:= txtSymbols.Font.Style - [fsItalic]
  end else if TSpeedButton(Sender).hint = 'Editor' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtEditor.Font.Style:= txtEditor.Font.Style + [fsItalic] else txtEditor.Font.Style:= txtEditor.Font.Style - [fsItalic]
  end;
end;

procedure TfrmSettings.btnCommentUnderlineClick(Sender: TObject);
begin
  if TSpeedButton(Sender).tag = 0 then TSpeedButton(Sender).tag := 1 else TSpeedButton(Sender).tag := 0;
  TSpeedButton(Sender).down := TSpeedButton(Sender).tag = 1;
  if TSpeedButton(Sender).hint = 'Comment' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtComment.Font.Style:= txtComment.Font.Style + [fsUnderline] else txtComment.Font.Style:= txtComment.Font.Style - [fsUnderline]
  end else if TSpeedButton(Sender).hint = 'Keyword' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtKeyword.Font.Style:= txtKeyword.Font.Style + [fsUnderline] else txtKeyword.Font.Style:= txtKeyword.Font.Style - [fsUnderline]
  end else if TSpeedButton(Sender).hint = 'Numbers' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtNumbers.Font.Style:= txtNumbers.Font.Style + [fsUnderline] else txtNumbers.Font.Style:= txtNumbers.Font.Style - [fsUnderline]
  end else if TSpeedButton(Sender).hint = 'Strings' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtStrings.Font.Style:= txtStrings.Font.Style + [fsUnderline] else txtStrings.Font.Style:= txtStrings.Font.Style - [fsUnderline]
  end else if TSpeedButton(Sender).hint = 'Symbols' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtSymbols.Font.Style:= txtSymbols.Font.Style + [fsUnderline] else txtSymbols.Font.Style:= txtSymbols.Font.Style - [fsUnderline]
  end else if TSpeedButton(Sender).hint = 'Editor' then
  begin
       if TSpeedButton(sender).tag  = 1 then txtEditor.Font.Style:= txtEditor.Font.Style + [fsUnderline] else txtEditor.Font.Style:= txtEditor.Font.Style - [fsUnderline]
  end;
end;

procedure TfrmSettings.cboThemesChange(Sender: TObject);
begin
  if cboThemes.ItemIndex = -1 then exit;
  LoadTheme(frmMain.Dir.FThemeDirectory + cboThemes.Items[cboThemes.ItemIndex]);
end;

procedure TfrmSettings.cboThemesDropDown(Sender: TObject);
var
  lst : TStringList;
  a : Integer;
begin
  lst := TStringList.create;
  cboThemes.Items.clear;
  try
    frmMain.GetFileList(frmMain.Dir.FThemeDirectory, '*.deTheme', lst);
    for a := 0 to lst.count - 1 do
    begin
         cboThemes.Items.add(ExtractFilename(lst[a]));
    end;
  finally
    lst.free;
  end;

end;

procedure TfrmSettings.ToolButton2Click(Sender: TObject);
begin
     if lvHourly.Selected = nil then exit;
     lvHourly.items.Delete(lvHourly.Selected.Index);
end;

procedure TfrmSettings.ToolButton3Click(Sender: TObject);
var
  new : TListItem;
  fname : STring;
begin
  if dlgScript.execute then
  begin
    fname := dlgScript.filename;
    new := lvLaunch.items.add;
    new.Caption := ExtractFileName(ChangeFileExt(fname, ''));
    new.SubItems.Add(fname);
    new.ImageIndex := 0;
  end;
end;

procedure TfrmSettings.ToolButton4Click(Sender: TObject);
begin
  if lvLaunch.Selected = nil then exit;
  lvLaunch.items.Delete(lvLaunch.Selected.Index);
end;

procedure TfrmSettings.ToolButton5Click(Sender: TObject);
var
  new : TListItem;
  fname : STring;
begin
  if dlgScript.execute then
  begin
    fname := dlgScript.filename;
    new := lvClose.items.add;
    new.Caption := ExtractFileName(ChangeFileExt(fname, ''));
    new.SubItems.Add(fname);
    new.ImageIndex := 0;
  end;
end;

procedure TfrmSettings.ToolButton6Click(Sender: TObject);
begin
  if lvLaunch.Selected = nil then exit;
  lvLaunch.items.Delete(lvLaunch.Selected.Index);
end;

procedure TfrmSettings.ToolButton7Click(Sender: TObject);
var
  new : TListItem;
  fname : STring;
begin
  if dlgScript.execute then
  begin
    fname := dlgScript.filename;
    new := lvQuick.items.add;
    new.Caption := ExtractFileName(ChangeFileExt(fname, ''));
    new.SubItems.Add(fname);
    new.ImageIndex := 0;
  end;
end;

procedure TfrmSettings.ToolButton8Click(Sender: TObject);
begin
  if lvQuick.Selected = nil then exit;
  lvQuick.items.Delete(lvQuick.Selected.Index);
end;

procedure TfrmSettings.ToolButton9Click(Sender: TObject);
var
  new : TListItem;
  fname : STring;
begin
  if dlgScript.execute then
  begin
    fname := dlgScript.filename;
    new := lvInterface.items.add;
    new.Caption := ExtractFileName(ChangeFileExt(fname, ''));
    new.SubItems.Add(fname);
    new.ImageIndex := 0;
  end;
end;

procedure TfrmSettings.LoadSettings;
var
  ini : TBigIniFile;
  a : Integer;
  lst : TStringList;
  new : TListItem;
begin
     seDefault.lines.clear;
     lvHourly.items.clear;
     lvLaunch.items.clear;
     lvClose.Items.clear;
     lvQuick.items.clear;
     lvInterface.Items.clear;
     if FileExists(frmMain.FCurrentTheme) then LoadTheme(frmMain.FCurrentTheme);
     if FileExists(frmMain.FDefaultBlank) then seDefault.Lines.LoadFromFile(frmMain.FDefaultBlank);
     ini := TBigIniFile.create(frmMain.FSettingsFile);
     try
       chkMRU.checked := ini.ReadBool('General' ,'MRU', True);
       chkTips.checked := ini.ReadBool('General', 'ShowTips', true);
       lst := TStringList.create;
       try
          lst.clear;
          ini.ReadNumberedList('Hourly', lst, '');
          for A := 0 to lst.count - 1 do
          begin
            new := lvHourly.items.add;
            new.caption := ExtractFileName(ChangeFileExt(lst[a], ''));
            new.SubItems.add(lst[a]);
          end;
          lst.clear;
          ini.ReadNumberedList('Launch', lst, '');
          for A := 0 to lst.count - 1 do
          begin
            new := lvLaunch.items.add;
            new.caption := ExtractFileName(ChangeFileExt(lst[a], ''));
            new.SubItems.add(lst[a]);
          end;
          lst.clear;
          ini.ReadNumberedList('Close', lst, '');
          for A := 0 to lst.count - 1 do
          begin
            new := lvClose.items.add;
            new.caption := ExtractFileName(ChangeFileExt(lst[a], ''));
            new.SubItems.add(lst[a]);
          end;
          lst.clear;
          ini.ReadNumberedList('Quick', lst, '');
          for A := 0 to lst.count - 1 do
          begin
            new := lvQuick.items.add;
            new.caption := ExtractFileName(ChangeFileExt(lst[a], ''));
            new.SubItems.add(lst[a]);
          end;
          lst.clear;
          ini.ReadNumberedList('IntScripts', lst, '');
          for A := 0 to lst.count - 1 do
          begin
            new := lvInterface.items.add;
            new.caption := ExtractFileName(ChangeFileExt(lst[a], ''));
            new.SubItems.add(lst[a]);
          end;
          // Load The Editor Settings Here!

       finally
         lst.free;
       end;
     finally
       ini.free;
     end;
end;

procedure TfrmSettings.SaveSettings;
var
  ini : TBigIniFile;
  a : Integer;
  lst : TStringList;
  new : TListItem;
begin
    seDefault.Lines.SaveToFile(frmMain.FDefaultBlank);
    ini := TBigIniFile.create(frmMain.FSettingsFile);
    SaveTheme(frmMain.FCurrentTheme);
    try
       lst := TStringList.create;
       try
         lst.clear;
         for A := 0 to lvHourly.items.count - 1 do lst.add(lvHourly.items.item[a].SubItems[0]);
         ini.WriteNumberedList('Hourly', lst);
         lst.clear;
         for A := 0 to lvLaunch.items.count - 1 do lst.add(lvLaunch.items.item[a].SubItems[0]);
         ini.WriteNumberedList('Launch', lst);
         lst.clear;
         for A := 0 to lvCLose.items.count - 1 do lst.add(lvCLose.items.item[a].SubItems[0]);
         ini.WriteNumberedList('Close', lst);
         lst.clear;
         for A := 0 to lvQuick.items.count - 1 do lst.add(lvQuick.items.item[a].SubItems[0]);
         ini.WriteNumberedList('Quick', lst);
         lst.clear;
         for A := 0 to lvInterface.items.count - 1 do lst.add(lvInterface.items.item[a].SubItems[0]);
         ini.WriteNumberedList('IntScripts', lst);
         ini.WriteBool('General', 'MRU', chkMRU.checked);
         ini.WriteBool('General', 'ShowTips', chkTips.checked);
       finally
         lst.free;
       end;
    finally
      ini.free;
    end;

end;

procedure TfrmSettings.LoadTheme(Const filename : String);
var
  ini : TBiginiFile;
begin
     ini := TBigIniFile.create(filename);
     try
        { Editor}
        txtEditor.Font.Name := ini.ReadString('Editor', 'FontName', 'Courier New');
        txtEditor.Font.Size := ini.ReadInteger('Editor', 'FontSize', 10);
        if ini.ReadBool('Editor', 'Bold', False) then txtEditor.Font.Style := txtEditor.Font.Style + [fsBold];
        if ini.ReadBool('Editor', 'Italic', False) then txtEditor.Font.Style := txtEditor.Font.Style + [fsItalic];
        if ini.ReadBool('Editor', 'Underline', False) then txtEditor.Font.Style := txtEditor.Font.Style + [fsUnderline];
        txtEditor.Font.Color := StringToColor(ini.ReadString('Editor', 'Foreground', 'clWindowText'));
        txtEditor.Color:= StringToColor(ini.ReadString('Editor', 'BackColor', 'clWindow'));
        { Comment }
        if ini.ReadBool('Comment', 'Bold', False) then txtComment.Font.Style := txtComment.Font.Style + [fsBold];
        if ini.ReadBool('Comment', 'Italic', False) then txtComment.Font.Style := txtComment.Font.Style + [fsItalic];
        if ini.ReadBool('Comment', 'Underline', False) then txtComment.Font.Style := txtComment.Font.Style + [fsUnderline];
        txtComment.Font.Color := StringToColor(ini.ReadString('Comment', 'Foreground', 'clWindowText'));
        txtComment.Color:= StringToColor(ini.ReadString('Comment', 'BackColor', 'clWindow'));
        { Keyword }
        if ini.ReadBool('Keyword', 'Bold', False) then txtKeyword.Font.Style := txtKeyword.Font.Style + [fsBold];
        if ini.ReadBool('Keyword', 'Italic', False) then txtKeyword.Font.Style := txtKeyword.Font.Style + [fsItalic];
        if ini.ReadBool('Keyword', 'Underline', False) then txtKeyword.Font.Style := txtKeyword.Font.Style + [fsUnderline];
        txtKeyword.Font.Color := StringToColor(ini.ReadString('Keyword', 'Foreground', 'clWindowText'));
        txtKeyword.Color:= StringToColor(ini.ReadString('Keyword', 'BackColor', 'clWindow'));
        { Numbers }
        if ini.ReadBool('Numbers', 'Bold', False) then txtNumbers.Font.Style := txtNumbers.Font.Style + [fsBold];
        if ini.ReadBool('Numbers', 'Italic', False) then txtNumbers.Font.Style := txtNumbers.Font.Style + [fsItalic];
        if ini.ReadBool('Numbers', 'Underline', False) then txtNumbers.Font.Style := txtNumbers.Font.Style + [fsUnderline];
        txtNumbers.Font.Color := StringToColor(ini.ReadString('Numbers', 'Foreground', 'clWindowText'));
        txtNumbers.Color:= StringToColor(ini.ReadString('Numbers', 'BackColor', 'clWindow'));
        { Strings }
        if ini.ReadBool('Strings', 'Bold', False) then txtStrings.Font.Style := txtStrings.Font.Style + [fsBold];
        if ini.ReadBool('Strings', 'Italic', False) then txtStrings.Font.Style := txtStrings.Font.Style + [fsItalic];
        if ini.ReadBool('Strings', 'Underline', False) then txtStrings.Font.Style := txtStrings.Font.Style + [fsUnderline];
        txtStrings.Font.Color := StringToColor(ini.ReadString('Strings', 'Foreground', 'clWindowText'));
        txtStrings.Color:= StringToColor(ini.ReadString('Strings', 'BackColor', 'clWindow'));
        { Symbols }
        if ini.ReadBool('Symbols', 'Bold', False) then txtSymbols.Font.Style := txtSymbols.Font.Style + [fsBold];
        if ini.ReadBool('Symbols', 'Italic', False) then txtSymbols.Font.Style := txtSymbols.Font.Style + [fsItalic];
        if ini.ReadBool('Symbols', 'Underline', False) then txtSymbols.Font.Style := txtSymbols.Font.Style + [fsUnderline];
        txtSymbols.Font.Color := StringToColor(ini.ReadString('Symbols', 'Foreground', 'clWindowText'));
        txtSymbols.Color:= StringToColor(ini.ReadString('Symbols', 'BackColor', 'clWindow'));
     finally
       ini.free;
     end;
end;

procedure TfrmSettings.SaveTheme(Const filename : String);
var
  ini : TIniFile;
begin
     ini := TIniFile.create(filename);
     try
        { Editor}
        ini.WriteString('Editor', 'FontName', txtEditor.Font.Name);
        ini.WriteInteger('Editor', 'FontSize', txtEditor.Font.Size);
        ini.WriteBool('Editor', 'Bold', (fsBold in txtEditor.Font.Style));
        ini.WriteBool('Editor', 'Italic', (fsItalic in txtEditor.Font.Style));
        ini.WriteBool('Editor', 'Underline', (fsUnderline in txtEditor.Font.Style));
        ini.WriteString('Editor', 'Foreground', ColorToString(txtEditor.Font.Color));
        ini.WriteString('Editor', 'BackColor', ColorToString(txtEditor.Color));
        { Comment }
        ini.WriteBool('Comment', 'Bold', (fsBold in txtComment.Font.Style));
        ini.WriteBool('Comment', 'Italic', (fsItalic in txtComment.Font.Style));
        ini.WriteBool('Comment', 'Underline', (fsUnderline in txtComment.Font.Style));
        ini.WriteString('Comment', 'Foreground', ColorToString(txtComment.Font.Color));
        ini.WriteString('Comment', 'BackColor', ColorToString(txtComment.Color));
        { Keyword }
        ini.WriteBool('Keyword', 'Bold', (fsBold in txtKeyWord.Font.Style));
        ini.WriteBool('Keyword', 'Italic', (fsItalic in txtKeyWord.Font.Style));
        ini.WriteBool('Keyword', 'Underline', (fsUnderline in txtKeyWord.Font.Style));
        ini.WriteString('Keyword', 'Foreground', ColorToString(txtKeyWord.Font.Color));
        ini.WriteString('Keyword', 'BackColor', ColorToString(txtKeyWord.Color));
        { Numbers }
        ini.WriteBool('Numbers', 'Bold', (fsBold in txtNumbers.Font.Style));
        ini.WriteBool('Numbers', 'Italic', (fsItalic in txtNumbers.Font.Style));
        ini.WriteBool('Numbers', 'Underline', (fsUnderline in txtNumbers.Font.Style));
        ini.WriteString('Numbers', 'Foreground', ColorToString(txtNumbers.Font.Color));
        ini.WriteString('Numbers', 'BackColor', ColorToString(txtNumbers.Color));
        { Strings }
        ini.WriteBool('Strings', 'Bold', (fsBold in txtStrings.Font.Style));
        ini.WriteBool('Strings', 'Italic', (fsItalic in txtStrings.Font.Style));
        ini.WriteBool('Strings', 'Underline', (fsUnderline in txtStrings.Font.Style));
        ini.WriteString('Strings', 'Foreground', ColorToString(txtStrings.Font.Color));
        ini.WriteString('Strings', 'BackColor', ColorToString(txtStrings.Color));
        { Symbols }
        ini.WriteBool('Symbols', 'Bold', (fsBold in txtSymbols.Font.Style));
        ini.WriteBool('Symbols', 'Italic', (fsItalic in txtSymbols.Font.Style));
        ini.WriteBool('Symbols', 'Underline', (fsUnderline in txtSymbols.Font.Style));
        ini.WriteString('Symbols', 'Foreground', ColorToString(txtSymbols.Font.Color));
        ini.WriteString('Symbols', 'BackColor', ColorToString(txtSymbols.Color));
     finally
       ini.free;
     end;
end;

procedure TfrmSettings.MakeThemeList;
var
  lst : TStringList;
  new : TListItem;
  a : Integer;
begin
  lst := TstringList.create;
  try
     lvThemes.items.clear;
     frmMain.GetFileList(frmMain.Dir.FThemeDirectory, '*.deTheme', lst);
     for a := 0 to lst.count - 1 do
     begin
       new := lvThemes.items.add;
       new.Caption := ExtractFileName(ChangeFileExt(lst[a],''));
       new.SubItems.add(lst[a]);
       new.ImageIndex:=0;
     end;
  finally
    lst.free;
  end;
end;

end.

