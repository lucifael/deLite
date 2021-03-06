unit uUserPass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons;

procedure dlg_UserPass(var username, password : String);


type

  { TfrmUserPass }

  TfrmUserPass = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    txtUsername: TEdit;
    GroupBox1: TGroupBox;
    txtPassword: TEdit;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmUserPass: TfrmUserPass;

implementation

procedure dlg_UserPass(var username, password : String);
var
  frm : TfrmUserPass;
begin
  frm := TfrmUserPass.create(application);
  try
    frm.txtUsername.text := Username;
    frm.txtPassword.text := Password;
    if frm.ShowModal = mrOK then
    begin
      username := frm.txtUsername.text;
      password := frm.txtPassword.text;
    end else
    begin
      username := '';
      password := '';
    end;
  finally
    frm.free;
  end;
end;

{$R *.lfm}

end.

