unit frameScriptOutput;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, ComCtrls, StdCtrls, Dialogs;

type

  { TframeScriptOutput }

  TframeScriptOutput = class(TFrame)
    ilScriptOutput: TImageList;
    memLog: TMemo;
    dlgSaveLog: TSaveDialog;
    ToolBar1: TToolBar;
    btnClearLog: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure btnClearLogClick(Sender: TObject);
    procedure memLogChange(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    FFilename : String;
    procedure LoadFromFile(const fname : String);
    procedure SaveToFile(const fname : String);
    procedure CopyToClipboard;
    procedure AddLine(const str : String);
  end;

implementation

{$R *.lfm}

procedure TframeScriptOutput.AddLine(const str : String);
begin
  memLog.lines.add(str);
  memLogChange(self);
end;

procedure TframeScriptOutput.btnClearLogClick(Sender: TObject);
begin
  memLog.lines.clear;
  FFilename := '';
end;

procedure TframeScriptOutput.memLogChange(Sender: TObject);
var
  pnt : TPoint;
begin
  pnt.x := 0;
  pnt.y := memLog.Lines.count-1;
  memLog.CaretPos := pnt;
  memLog.Repaint;
end;

procedure TframeScriptOutput.ToolButton2Click(Sender: TObject);
begin
  if dlgSaveLog.execute then SaveToFile(dlgSaveLog.Filename)
end;

procedure TframeScriptOutput.LoadFromFile(const fname : String);
begin
  memLog.Lines.LoadFromFile(fname);
  FFilename := fname;
end;

procedure TframeScriptOutput.SaveToFile(const fname : String);
begin
  memLog.Lines.SaveToFile(fname);
  FFilename := fname;
end;

procedure TframeScriptOutput.CopyToClipboard;
begin
  memLog.CopyToClipboard;
end;

end.

