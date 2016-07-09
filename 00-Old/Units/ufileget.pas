unit uFileGet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  Buttons;

function dlgfOpen(const Title, Filter : String) : String;
function dlgfSave(const Title, Filter, DefaultEXT : String) : String;

type

  { TfrmFilenameGet }

  TfrmFilenameGet = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    feFilename: TFileNameEdit;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmFilenameGet: TfrmFilenameGet;

implementation

{$R *.lfm}

function dlgfOpen(const Title, Filter : String) : String;
var
  frm : TfrmFilenameGet;
begin
     result := '';
     frm := TfrmFilenameGet.create(application);
     try
        frm.caption := Title;
        frm.feFilename.DialogTitle:=Title;
        frm.feFilename.DefaultExt:='';
        frm.feFilename.DialogKind:=dkOpen;
        frm.feFilename.Filter := filter;
        if frm.ShowModal = mrOK then
        begin
          result := frm.feFilename.filename;
        end;
     finally
       frm.free;
     end;
end;

function dlgfSave(const Title, Filter, DefaultEXT : String) : String;
var
  frm : TfrmFilenameGet;
begin
     result := '';
     frm := TfrmFilenameGet.create(application);
     try
        frm.caption := Title;
        frm.feFilename.DialogTitle:=Title;
        frm.feFilename.DefaultExt:=DefaultEXT;
        frm.feFilename.DialogKind:=dkSave;
        frm.feFilename.Filter := filter;
        if frm.ShowModal = mrOK then
        begin
          result := frm.feFilename.filename;
        end;
     finally
       frm.free;
     end;
end;

end.

