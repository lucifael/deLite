unit uAsk;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;

Function Ask(const TipText : String) : TModalResult;
Function funcAsk(const TipText : String) : Integer;


type

  { TfrmAsk }

  TfrmAsk = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Image1: TImage;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAsk: TfrmAsk;

implementation

{$R *.lfm}

Function Ask(const TipText : String) : TModalResult;
var
  frm : TfrmAsk;
  res : TModalResult;
begin
  res := mrNone;
  frm := TfrmAsk.create(application);
  try
    frm.memo1.text := TipText;
    res := frm.ShowModal;
  finally
    frm.free;
  end;
  result := res;
end;

Function funcAsk(const TipText : String) : Integer;
var
  frm : TfrmAsk;
  res : TModalResult;
begin
  res := mrNone;
  frm := TfrmAsk.create(application);
  try
    frm.memo1.text := TipText;
    res := frm.ShowModal;
    if res = mrYes then result := 1 else result := 0;
  finally
    frm.free;
  end;
end;


end.

