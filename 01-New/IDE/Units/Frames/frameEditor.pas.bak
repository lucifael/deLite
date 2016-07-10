unit frameEditor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynEdit, SynPluginSyncroEdit, SynHighlighterPas,
  SynHighlighterMulti, SynHighlighterAny, Forms, Controls, ExtCtrls, ComCtrls,
  StdCtrls, Buttons, Dialogs, uBigIni, uAsk;

type
  THistoryEntry = record
    Date : TDate;
    Time : TTime;
    Notes : String;
    Commit : TStringList;
end;


type

  { TframeEditor }

  TframeEditor = class(TFrame)
    btnShowHistory: TSpeedButton;
    dlgSave: TSaveDialog;
    lbHistory: TListBox;
    Panel4: TPanel;
    Panel5: TPanel;
    pnlHistory: TPanel;
    SpeedButton1: TSpeedButton;
    synHist: TSynEdit;
    ToolBar1: TToolBar;
    btnRevert: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    txtQuickSearch: TEdit;
    ilProject: TImageList;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnQuickSearch: TSpeedButton;
    Splitter1: TSplitter;
    SynAnySyn1: TSynAnySyn;
    SynEdit1: TSynEdit;
    SynMultiSyn1: TSynMultiSyn;
    SynPasSyn1: TSynPasSyn;
    tvCodeBrowser: TTreeView;
    procedure btnQuickSearchClick(Sender: TObject);
    procedure btnRevertClick(Sender: TObject);
    procedure btnShowHistoryClick(Sender: TObject);
    procedure lbHistoryClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SynEdit1Change(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure txtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Panel3Click(Sender: TObject);
  private
    { private declarations }
    fpos : Integer;
    HistArray : array[0..10] of THistoryEntry;
    H_FFilename : String;
    H_Current : Integer;
    procedure SetModified(state : Boolean);
    procedure MoveDown;
    procedure AddEntry(str : TStringList);
    procedure H_LoadFromFile;
    procedure H_SaveToFile;
  public
    { public declarations }
    FFilename : String;
    ParentTab : TTabSheet;
    procedure LoadFromFile(const fname : String);
    procedure SaveToFile(Const Fname : String);
    procedure CheckSave;
  end;

implementation

{$R *.lfm}

// Local function for finding length in Editor
procedure setSelLength(var textComponent:TSynEdit; newValue:integer);
begin
     textComponent.SelEnd := textComponent.SelStart + newValue;
end;

procedure TframeEditor.SetModified(state : Boolean);
begin
     if not assigned(ParentTab) then exit;
     if state then ParentTab.Caption:=ExtractFileName(FFilename) + ' *'
     else ParentTab.Caption := ExtractFileName(FFilename);
     synEdit1.Modified := state;
end;

procedure TframeEditor.Panel3Click(Sender: TObject);
begin

end;

procedure TframeEditor.txtQuickSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
       // Do Quick search from currrent caret point.
    btnQuickSearchClick(self);
  end;
end;



procedure TframeEditor.btnQuickSearchClick(Sender: TObject);
var
  FindS: String;
  IPos, FLen, SLen: Integer; {Internpos, Lengde søkestreng, lengde memotekst}
begin
  {FPos is global}
  // Only finds the first occurance
  // Do Search from current caret point
  FPos := synEdit1.SelStart;
  FLen := Length(txtQuickSearch.text);
  SLen := Length(txtQuickSearch.text);
  FindS := txtQuickSearch.text;
  IPos := Pos(AnsiUpperCase(FindS),AnsiUpperCase( Copy(synEdit1.Text,FPos+1,SLen-FPos)));
  If IPos > 0 then begin
    FPos := FPos + IPos;
    synEdit1.SetFocus;
//    Self.ActiveControl := synEdit1;
    synEdit1.SelStart:= FPos;  // -1;   mike   {Select the string found by POS}
    setSelLength(synEdit1, FLen);     //seEdit.SelLength := FLen;
    FPos:=FPos+FLen-1;   //mike - move just past end of found item
  end
end;

procedure TframeEditor.btnRevertClick(Sender: TObject);
begin
  if Ask('Are you sure you want to revert to this history entry?') = mrYes then
  begin
    // Revert the source editor to the current entry
    if H_Current<>-1 then
    begin
         if Assigned(HistArray[H_Current].Commit) then
         begin
            synEdit1.Lines.assign(HistArray[H_Current].Commit);
            SetModified(TRUE);
         end
         else ShowMessage('Nothing to roll back to');
    end else
    begin
         ShowMessage('Nothing to roll back to');
    end;
  end;
end;

procedure TframeEditor.btnShowHistoryClick(Sender: TObject);
begin
  // Show Versioning History Panel
     pnlHistory.visible := true;
end;

procedure TframeEditor.lbHistoryClick(Sender: TObject);
begin
  if lbHistory.ItemIndex<>-1 then
  begin
    H_Current := lbHistory.ItemIndex;
    if assigned(HistArray[H_Current].Commit) then synHist.Lines.assign(HistArray[H_Current].Commit);
  end;
end;

procedure TframeEditor.SpeedButton1Click(Sender: TObject);
begin
  pnlHistory.visible := false;
end;

procedure TframeEditor.SynEdit1Change(Sender: TObject);
begin
     setModified(synEdit1.Modified);
end;

procedure TframeEditor.ToolButton2Click(Sender: TObject);
var
  A : Integer;
begin
  if Ask('Are you sure you want to clear ALL the history?'+#13#10+'This will also destroy the history file!') = mrYes then
  begin
    if FileExists(H_FFilename) then deleteFile(H_FFilename);
    for a := low(HistArray) to high(HistArray) do
    begin
      HistArray[a].Date := TDate(Now);
      HistArray[a].Time := TTime(Now);
      HistArray[a].Notes := '';
      if assigned(HistArray[a].Commit) then HistArray[a].Commit.Clear;
    end;
  end;
end;

procedure TframeEditor.LoadFromFile(const fname : String);
begin
    FFilename := fname;
    synEdit1.lines.LoadFromfile(FFilename);
    synEdit1.Modified := false;
    H_FFilename := changeFileExt(FFilename, '.delHist');
    if fileExists(H_FFilename) then H_LoadFromFile;
    SetModified(false);
end;

procedure TframeEditor.SaveToFile(Const Fname : String);
begin
     if Fname = 'Untitled' then
     begin
          if dlgSave.Execute then
          begin
               FFilename := dlgSave.Filename;
          end else exit;
     end else
     begin
       FFilename := Fname;
     end;
     if FFilename<>'Untitled' then
     begin
          synEdit1.lines.savetofile(FFilename);
          synEdit1.Modified := false;
          h_FFilename := ChangeFileExt(FFilename, '.delHist');
          H_SaveToFile;
          SetModified(False);
     end else
     begin
       ShowMessage('No filename to save to, please try again');
     end;
end;

procedure TframeEditor.CheckSave;
begin
    if synEdit1.Modified then
    begin
         // Ask to save
         if Ask('Would you like to save first?')=mrYes then SaveToFile(FFilename);
    end;
end;

procedure TframeEditor.MoveDown;
var
  A : Integer;
begin
     for a := High(HistArray) downto Low(HistArray) do
     begin
       if a < high(HistArray) then
       begin
            HistArray[a+1] := HistArray[a];
       end;
     end;
end;

procedure TframeEditor.AddEntry(str : TStringList);
begin
     // First Move the Array Down
    MoveDown;
    HistArray[0].Date := TDate(NOW);
    HistArray[0].Time := TTime(Now);
    HistArray[0].Notes := 'History Updated on Save @ ' + TimeToStr(NOW);
    if not assigned(HistArray[0].Commit) then
    begin
         HistArray[0].Commit := TStringList.create;
         HistArray[0].Commit.assign(str);
    end;
end;

procedure TframeEditor.H_LoadFromFile;
var
  fname : String;
  A : Integer;
  ini : TBigInifile;
begin
     if not FileExists(FFilename) then exit;
     fname := ChangeFileExt(FFilename, '.delHist');
     ini := TBigIniFile.Create(Fname);
     try
        for A := low(HistArray) to High(HistArray) do
        begin
          HistArray[a].Date := StrToDate(ini.ReadString('Entry' + IntToStr(a), 'Date', DateToStr(TDate(Now))));
          HistArray[a].Time := StrToTime(ini.ReadString('Entry' + IntToStr(a), 'Time', DateToStr(TTime(Now))));
          HistArray[a].Notes := ini.ReadString('Entry' + IntToStr(a), 'Notes', '');
          if not assigned(HistArray[a].Commit) then
          begin
               HistArray[a].Commit := TStringList.create;
          end;
          ini.ReadNumberedList('Commit' + IntToStr(a), histArray[a].Commit, '');
        end;
     finally
       ini.free;
     end;
     H_FFilename := Fname;
end;

procedure TframeEditor.H_SaveToFile;
var
  fname : String;
  A : Integer;
  ini : TBigIniFile;
begin
     if Not FileExists(FFilename) then exit;
     fname := ChangeFileExt(FFilename, '.delHist');
     ini := TBiginiFile.create(fname);
     try
        ini.WriteString('Header', 'SourceFile', FFilename);
        for a := low(HistArray) to high(HistArray) do
        begin
          ini.WriteString('Entry' + IntToStr(a), 'Date', DateToStr(HistArray[a].Date));
          ini.WriteString('Entry' + IntToStr(a), 'Time', DateToStr(HistArray[a].Time));
          ini.WriteString('Entry' + IntToStr(a), 'Notes', HistArray[a].Notes);
          if not assigned(HistArray[a].Commit) then
          begin
               HistArray[a].Commit := TStringList.create;
          end;
          ini.WriteNumberedList('Commit' + IntToStr(a), HistArray[a].Commit);
        end;
     finally
       ini.free;
     end;
     lbHistory.items.clear;
     for a := low(HistArray) to high(HistArray) do
     begin
       lbHistory.items.add(DateToStr(HistArray[a].Date) + ' - ' + TimeToStr(HistArray[a].Time) + ' - ' + HistArray[a].Notes);
     end;
end;


end.

