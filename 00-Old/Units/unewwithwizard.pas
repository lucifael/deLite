unit uNewWithWizard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Buttons, EditBtn, StdCtrls, uMain;

type

  { TfrmNewWizard }

  TfrmNewWizard = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    FileNameEdit1: TFileNameEdit;
    ilWizard: TImageList;
    Label1: TLabel;
    lvWizards: TListView;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmNewWizard: TfrmNewWizard;

implementation

{$R *.lfm}

{ TfrmNewWizard }

procedure TfrmNewWizard.FormCreate(Sender: TObject);
var
  new : TListItem;
  lst : TStringList;
  A : Integer;
begin
  lst := TStringList.create;
  try
    frmMain.GetFileList(frmMain.Dir.FWizDirectory, '*.exe', lst);
    for a := 0 to lst.count - 1 do
    begin
      New := lvWizards.items.add;
      new.caption := ExtractFileName(ChangeFileExt(lst[a],''));
      new.subitems.add(lst[a]);
      new.ImageIndex := 0;
    end;
  finally
    lst.free;
  end;
end;

procedure TfrmNewWizard.BitBtn1Click(Sender: TObject);
begin
  if lvWizards.selected=nil then
  begin
    ModalResult := mrNone;
    ShowMessage('Please select a wizard');
  end;
  if FileNameEdit1.Filename='' then
  begin
    ModalResult := mrNone;
    ShowMessage('Please ensure you have selected a filename for your script');
  end;
end;

end.

