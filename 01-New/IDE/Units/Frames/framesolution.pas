unit frameSolution;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, ComCtrls, ExtCtrls,
  frameSolutionProperties, clipbrd, laz2_XMLRead,
  laz2_DOM, laz2_XMLWrite, base64, zstream;

type

  { TframeSolution }

  TframeSolution = class(TFrame)
    frameSolutionProperties1: TframeSolutionProperties;
    ilSolution: TImageList;
    Splitter1: TSplitter;
    tbSolution: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    tvSolution: TTreeView;
  private
    { private declarations }

  public
    { public declarations }
    FFilename : String;
    FModified : Boolean;
    procedure LoadFromFile(Const fname : String);
    procedure SaveToFile(Const fname : String);
    procedure CheckSave;
  end;

implementation

{$R *.lfm}


procedure TframeSolution.LoadFromFile(Const fname : String);
begin
     //
end;

procedure TframeSolution.SaveToFile(Const fname : String);
begin
    //
end;

procedure TframeSolution.CheckSave;
begin
  if FModified then
  begin
    // Ask to save
  end;
end;

end.

