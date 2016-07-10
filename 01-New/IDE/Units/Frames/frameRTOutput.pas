unit frameRTOutput;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, ComCtrls, Buttons, StdCtrls;

type

  { TframeOutput }

  TframeOutput = class(TFrame)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    ilOutput: TImageList;
    lvAll: TListView;
    lvFilter: TListView;
    lvErrors: TListView;
    lvWarnings: TListView;
    lvComments: TListView;
    pcOutput: TPageControl;
    ToolButton1: TToolButton;
    tsAll: TTabSheet;
    tsComments: TTabSheet;
    tsWarnings: TTabSheet;
    tsErrors: TTabSheet;
    tsFilter: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton4: TToolButton;
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

end.

