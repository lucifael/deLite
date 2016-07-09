unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, Menus, ActnList;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    lblPos: TLabel;
    ilControls: TImageList;
    ilActions: TImageList;
    PageControl1: TPageControl;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    btnNewForm: TToolButton;
    ToolBar3: TToolBar;
    ToolBar4: TToolBar;
    btnButton: TToolButton;
    btnMemo: TToolButton;
    btnCheck: TToolButton;
    btnLabel: TToolButton;
    btnEdit: TToolButton;
    btnPanel: TToolButton;
    ToolBar5: TToolBar;
    btnListBox: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    btnMakeScript: TToolButton;
    btnImage: TToolButton;
    tsGeneral: TTabSheet;
    tsMore: TTabSheet;
    tsOther: TTabSheet;
    procedure btnCheckClick(Sender: TObject);
    procedure btnNewFormClick(Sender: TObject);
    procedure btnPanelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLabelClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnButtonClick(Sender: TObject);
    procedure btnMemoClick(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure btnListBoxClick(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure btnMakeScriptClick(Sender: TObject);
    procedure btnImageClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    Vr, fnc, evnt : TStringList;
    Output : TStringList;
    FFilename : String;
    procedure SetProperties(Obj : TObject);
    procedure CheckSel;
    procedure DoControlWrite(const Indent : String; const Prnt : TWinControl);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

uses uDesign, uProperties;

{ TfrmMain }


procedure lst_Copy(var From, ToLst : TStringList);
var
  A : Integer;
begin
 for a := 0 to From.count - 1 do toLst.add(from[a]);
end;


procedure TfrmMain.btnNewFormClick(Sender: TObject);
begin
  if assigned(frmDesign) then
  begin
    frmDesign.show;
  end else
  begin
    frmDesign := TfrmDesign.create(self);
    frmDesign.show;
  end;
end;

procedure TfrmMain.btnCheckClick(Sender: TObject);
var
  btn : TCheckBox;
begin
  checkSel;
  if assigned(frmDesign) then
  begin
    if frmDesign.Selected<>nil then
    begin
      if (frmDesign.Selected is TWinControl) and (TWinControl(frmDesign).tag=0) and (TWinControl(frmDesign).tag<>-1) then
      begin
        try
          btn := TCheckBox.create(frmDesign.Selected);
          btn.parent := frmDesign.Selected;
        except
          btn := TCheckBox.create(frmDesign);
          btn.parent := frmDesign;
        end;
      end else
      begin
           btn := TCheckBox.create(frmDesign);
           btn.parent := frmDesign;
      end;
    end else
    begin
         btn := TCheckBox.create(frmDesign);
         btn.parent := frmDesign;
    end;
    btn.setBounds(0,0,80,25);
//    btn.transparent := false;
    btn.Name := 'Checkbox' + IntToStr(frmDesign.ControlCount) + '_' + IntToStr(Random(10000));
    btn.Caption := btn.Name;
    btn.OnMouseDown := @frmDesign.Button1MouseDown;
    btn.OnMouseUp := @frmDesign.Button1MouseUp;
    btn.OnMouseMove := @frmDesign.Button1MouseMove;
    btn.OnKeyDown := @frmDesign.FormKeyDown;
    btn.visible := true;
  end;
end;

procedure TfrmMain.btnPanelClick(Sender: TObject);
var
  btn : TPanel;
begin
  checkSel;
  if assigned(frmDesign) then
  begin
    if frmDesign.Selected<>nil then
    begin
      if (frmDesign.Selected is TWinControl) and (TWinControl(frmDesign).tag=0) and (TWinControl(frmDesign).tag<>-1) then
      begin
        try
          btn := TPanel.create(frmDesign.Selected);
          btn.parent := frmDesign.Selected;
        except
          btn := TPanel.create(frmDesign);
          btn.parent := frmDesign;
        end;
      end else
      begin
           btn := TPanel.create(frmDesign);
           btn.parent := frmDesign;
      end;
    end else
    begin
         btn := TPanel.create(frmDesign);
         btn.parent := frmDesign;
    end;
    btn.setBounds(0,0,250,150);
//    btn.transparent := false;
    btn.Name := 'Panel' + IntToStr(frmDesign.ControlCount) + '_' + IntToStr(Random(10000));
    btn.Caption := btn.Name;
    btn.OnMouseDown := @frmDesign.Button1MouseDown;
    btn.OnMouseUp := @frmDesign.Button1MouseUp;
    btn.OnMouseMove := @frmDesign.Button1MouseMove;
    btn.OnKeyDown := @frmDesign.FormKeyDown;
    btn.visible := true;
    btn.tag := 0;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Randomize;
  if ParamCount>=1 then
  begin
    FFilename := ParamStr(1);
    Caption := ExtractFileName(ParamStr(1)) + ' - Form Wizard';
    application.title := ExtractFileName(ParamStr(1));
  end;
end;

procedure TfrmMain.SetProperties(Obj : TObject);
begin
  if obj<>nil then
  begin
    frmProperties.lblSel.caption := 'Top: ' + IntToStr(TWinControl(obj).Top) + #10#13 +
    'Left: ' + IntToStr(TWinControl(obj).Left) + #10#13 +
    'Width: ' + IntToStr(TWinControl(obj).Width) + #10#13 +
    'Height: ' + IntToStr(TWinControl(obj).Height) + #10#13 +
    'Name: ' + TWinControl(obj).name;
  end else begin
    // Do The Form Instead;
    frmProperties.lblSel.caption := 'Top: ' + IntToStr(frmDesign.Top) + #10#13 +
    'Left: ' + IntToStr(frmDesign.Left) + #10#13 +
    'Width: ' + IntToStr(frmDesign.Width) + #10#13 +
    'Height: ' + IntToStr(frmDesign.Height) + #10#13 +
    'Name: ' + frmDesign.hint;
  end;
  FrmProperties.CanChange := false;
  if obj=nil then
  begin
    with frmDesign do
    begin
      frmProperties.seTop.value := top;
      frmProperties.seLeft.Value := left;
      frmProperties.seWidth.value := Width;
      frmProperties.seHeight.Value := Height;
      frmProperties.txtName.text := Name;
      FrmProperties.CanChange := false;
    end;
  end;
  if Obj<>nil then
  begin
    with obj as TWinControl do
    begin
        frmProperties.seTop.value := top;
        frmProperties.seLeft.Value := left;
        frmProperties.seWidth.value := Width;
        frmProperties.seHeight.Value := Height;
        frmProperties.txtName.text := Name;
        FrmProperties.CanChange := true;
    end;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  frmProperties.show;
  frmDesign.show;
  frmProperties.top := top + height + 40;
  frmProperties.left := left + 10;
  frmProperties.height := (screen.height - frmProperties.top) - 100;

end;

procedure TfrmMain.btnLabelClick(Sender: TObject);
var
  btn : TPanel;
begin
  checkSel;
  if assigned(frmDesign) then
  begin
    if frmDesign.Selected<>nil then
    begin
      if (frmDesign.Selected is TWinControl) and (TWinControl(frmDesign).tag=0) and (TWinControl(frmDesign).tag<>-1) then
      begin
        try
          btn := TPanel.create(frmDesign.Selected);
          btn.parent := frmDesign.Selected;
        except
          btn := TPanel.create(frmDesign);
          btn.parent := frmDesign;
        end;
      end else
      begin
           btn := TPanel.create(frmDesign);
           btn.parent := frmDesign;
      end;
    end else
    begin
         btn := TPanel.create(frmDesign);
         btn.parent := frmDesign;
    end;
    btn.setBounds(0,0,80,25);
//    btn.transparent := false;
    btn.Name := 'Label' + IntToStr(frmDesign.ControlCount) + '_' + IntToStr(Random(10000));
    btn.Caption := btn.Name;
    btn.OnMouseDown := @frmDesign.Button1MouseDown;
    btn.OnMouseUp := @frmDesign.Button1MouseUp;
    btn.OnMouseMove := @frmDesign.Button1MouseMove;
    btn.OnKeyDown := @frmDesign.FormKeyDown;
    btn.visible := true;
    btn.tag := 1;
  end;
end;

procedure TfrmMain.btnEditClick(Sender: TObject);
var
  btn : TEdit;
begin
  checkSel;
  if assigned(frmDesign) then
  begin
    if assigned(frmDesign) then
    begin
      if frmDesign.Selected<>nil then
      begin
        if (frmDesign.Selected is TWinControl) and (TWinControl(frmDesign).tag=0) and (TWinControl(frmDesign).tag<>-1) then
        begin
          try
            btn := TEdit.create(frmDesign.Selected);
            btn.parent := frmDesign.Selected;
          except
            btn := TEdit.create(frmDesign);
            btn.parent := frmDesign;
          end;
        end else
        begin
             btn := TEdit.create(frmDesign);
             btn.parent := frmDesign;
        end;
      end else
      begin
           btn := TEdit.create(frmDesign);
           btn.parent := frmDesign;
      end;
    end;
    btn.setBounds(0,0,85,25);
    btn.Name := 'Edit' + IntToStr(frmDesign.ControlCount) + '_' + IntToStr(Random(10000));
    btn.Caption := btn.Name;
    btn.OnMouseDown := @frmDesign.Button1MouseDown;
    btn.OnMouseUp := @frmDesign.Button1MouseUp;
    btn.OnMouseMove := @frmDesign.Button1MouseMove;
    btn.OnKeyDown := @frmDesign.FormKeyDown;
    btn.ReadOnly := true;
    btn.visible := true;
  end;
end;

procedure TfrmMain.btnButtonClick(Sender: TObject);
var
  btn : TButton;
begin
  checkSel;
  if assigned(frmDesign) then
  begin
    if assigned(frmDesign) then
    begin
      if frmDesign.Selected<>nil then
      begin
        if (frmDesign.Selected is TWinControl) and (TWinControl(frmDesign).tag=0) and (TWinControl(frmDesign).tag<>-1) then
        begin
          try
            btn := TButton.create(frmDesign.Selected);
            btn.parent := frmDesign.Selected;
          except
            btn := TButton.create(frmDesign);
            btn.parent := frmDesign;
          end;
        end else
        begin
             btn := TButton.create(frmDesign);
             btn.parent := frmDesign;
        end;
      end else
      begin
           btn := TButton.create(frmDesign);
           btn.parent := frmDesign;
      end;
    end;
    btn.setBounds(0,0,75,35);
    btn.Name := 'Button' + IntToStr(frmDesign.ControlCount) + '_' + IntToStr(Random(10000));
    btn.Caption := btn.Name;
    btn.OnMouseDown := @frmDesign.Button1MouseDown;
    btn.OnMouseUp := @frmDesign.Button1MouseUp;
    btn.OnMouseMove := @frmDesign.Button1MouseMove;
    btn.OnKeyDown := @frmDesign.FormKeyDown;
    btn.visible := true;
  end;
end;

procedure TfrmMain.btnMemoClick(Sender: TObject);
var
  btn : TMemo;
begin
  checkSel;
  if assigned(frmDesign) then
  begin
    if frmDesign.Selected<>nil then
    begin
      if (frmDesign.Selected is TWinControl) and (TWinControl(frmDesign).tag=0) and (TWinControl(frmDesign).tag<>-1) then
      begin
        try
          btn := TMemo.create(frmDesign.Selected);
          btn.parent := frmDesign.Selected;
        except
          btn := TMemo.create(frmDesign);
          btn.parent := frmDesign;
        end;
      end else
      begin
           btn := TMemo.create(frmDesign);
           btn.parent := frmDesign;
      end;
    end else
    begin
         btn := TMemo.create(frmDesign);
         btn.parent := frmDesign;
    end;
    btn.setBounds(0,0,250,150);
//    btn.transparent := false;
    btn.Name := 'Memo' + IntToStr(frmDesign.ControlCount) + '_' + IntToStr(Random(10000));
    btn.lines.text := btn.Name;
    btn.OnMouseDown := @frmDesign.Button1MouseDown;
    btn.OnMouseUp := @frmDesign.Button1MouseUp;
    btn.OnMouseMove := @frmDesign.Button1MouseMove;
    btn.OnKeyDown := @frmDesign.FormKeyDown;
    btn.ReadOnly := true;
    btn.visible := true;
    btn.tag := 0;
  end;
end;

procedure TfrmMain.ToolButton15Click(Sender: TObject);
var
  btn : TPanel;
begin
  checkSel;
  if assigned(frmDesign) then
  begin
    if frmDesign.Selected<>nil then
    begin
      if (frmDesign.Selected is TWinControl) and (TWinControl(frmDesign).tag=0) and (TWinControl(frmDesign).tag<>-1) then
      begin
        try
          btn := TPanel.create(frmDesign.Selected);
          btn.parent := frmDesign.Selected;
        except
          btn := TPanel.create(frmDesign);
          btn.parent := frmDesign;
        end;
      end else
      begin
           btn := TPanel.create(frmDesign);
           btn.parent := frmDesign;
      end;
    end else
    begin
         btn := TPanel.create(frmDesign);
         btn.parent := frmDesign;
    end;
    btn.setBounds(0,0,80,25);
//    btn.transparent := false;
    btn.Name := 'ComboBox' + IntToStr(frmDesign.ControlCount) + '_' + IntToStr(Random(10000));
    btn.caption := btn.Name;
    btn.OnMouseDown := @frmDesign.Button1MouseDown;
    btn.OnMouseUp := @frmDesign.Button1MouseUp;
    btn.OnMouseMove := @frmDesign.Button1MouseMove;
    btn.OnKeyDown := @frmDesign.FormKeyDown;
//    btn.ReadOnly := true;
    btn.visible := true;
    btn.tag := 2;
  end;
end;

procedure TfrmMain.btnListBoxClick(Sender: TObject);
var
  btn : TListBox;
begin
  checkSel;
  if assigned(frmDesign) then
  begin
    if frmDesign.Selected<>nil then
    begin
      if (frmDesign.Selected is TWinControl) and (TWinControl(frmDesign).tag=0) and (TWinControl(frmDesign).tag<>-1) then
      begin
        try
          btn := TListBox.create(frmDesign.Selected);
          btn.parent := frmDesign.Selected;
        except
          btn := TListBox.create(frmDesign);
          btn.parent := frmDesign;
        end;
      end else
      begin
           btn := TListBox.create(frmDesign);
           btn.parent := frmDesign;
      end;
    end else
    begin
         btn := TListBox.create(frmDesign);
         btn.parent := frmDesign;
    end;
    btn.setBounds(0,0,250,150);
//    btn.transparent := false;
    btn.Name := 'ListBox' + IntToStr(frmDesign.ControlCount) + '_' + IntToStr(Random(10000));
    btn.items.text := btn.Name;
    btn.OnMouseDown := @frmDesign.Button1MouseDown;
    btn.OnMouseUp := @frmDesign.Button1MouseUp;
    btn.OnMouseMove := @frmDesign.Button1MouseMove;
    btn.OnKeyDown := @frmDesign.FormKeyDown;
    btn.visible := true;
    btn.tag := 0;
  end;
end;

procedure TfrmMain.ToolButton3Click(Sender: TObject);
begin
  frmDesign.free;
  frmDesign := TfrmDesign.create(self);
  frmDesign.visible := true;
  frmDesign.show;
end;

procedure TfrmMain.btnMakeScriptClick(Sender: TObject);
var
  a : Integer;
  cnt : Integer;
  obj : TControl;
  spc : String;
begin
     fnc := TStringList.create;
     spc := '       ';
     try
       fnc.Add('procedure Create'+FrmDesign.hint + 'Form;');
       fnc.Add('begin');
       fnc.add('       MyForm := TForm.create(self)');
       fnc.Add('       MyForm.Top := ' + IntToStr(FrmDesign.top) + ';');
       fnc.Add('       MyForm.Left := ' + IntToStr(FrmDesign.Left) + ';');
       fnc.Add('       MyForm.Width := ' + IntToStr(FrmDesign.Width) + ';');
       fnc.Add('       MyForm.Height := ' + IntToStr(FrmDesign.Height) + ';');
       cnt := frmDesign.ControlCount;
       vr := TStringList.create;
       evnt := TStringList.create;
       try
         vr.add(spc + 'MyForm : TForm;');
         DoControlWrite(spc, TWinControl(frmDesign));



         fnc.add('// End Of Form Definition');
         fnc.Add('End;');
         fnc.add('');
         fnc.add('');
         fnc.Add('{ Main }');
         fnc.add('begin');
         fnc.add('        ' + 'Create'+FrmDesign.hint + 'Form;');
         fnc.add('        MyForm.ShowModal;');
         fnc.add('end.');
         fnc.add('');
         fnc.add('');
         fnc.add('{ EOF }');

         // Generate the final file
         OutPut := TStringList.create;
         try
            Output.add('unit MyForm;');
            Output.add('');
            Output.add('');
            Output.add('{ Global Variables }');
            Output.add('var');
            Output.add('      // Setup Global Variables Here');
            // Copy in the variable list;
            lst_Copy(vr, Output);
            Output.add('');
            Output.add('{ User Functions/Procedures }');
            Output.adD('// Put Functions and Procedures Here');
            Output.add('');

            lst_copy(evnt, Output);
            Output.add('');
            Output.add('//End Form Events');
            Output.add('');
            Output.add('// Create Form by Form Wizard');
            // Copy the form definition procedure here
            lst_Copy(fnc, output);
            // Now Save it to the filename if we have one,
            // other wise for testing just save to root
            if FFilename<>'' then
            begin
              if fileExists(FFilename) then
              begin
                ShowMessage('File will be overwritten, a back up will be made to filename + ''.bak''');
                CopyFile(FFilename, changeFileExt(FFilename, '.BAK'), true);
              end;
              Output.SaveToFile(FFilename)
            end else Output.SaveToFile('c:\MyForm.deScript');
         finally
           Output.free;
         end;
       finally
         vr.free;
         evnt.free;
       end;
     finally
       fnc.free;
     end;
end;

procedure TfrmMain.btnImageClick(Sender: TObject);
var
  btn : TPanel;
begin
  checkSel;
  if assigned(frmDesign) then
  begin
    if frmDesign.Selected<>nil then
    begin
      if (frmDesign.Selected is TWinControl) and (TWinControl(frmDesign).tag=0) and (TWinControl(frmDesign).tag<>-1) then
      begin
        try
          btn := TPanel.create(frmDesign.Selected);
          btn.parent := frmDesign.Selected;
        except
          btn := TPanel.create(frmDesign);
          btn.parent := frmDesign;
        end;
      end else
      begin
           btn := TPanel.create(frmDesign);
           btn.parent := frmDesign;
      end;
    end else
    begin
         btn := TPanel.create(frmDesign);
         btn.parent := frmDesign;
    end;
    btn.setBounds(0,0,250,150);
//    btn.transparent := false;
    btn.Name := 'Image' + IntToStr(frmDesign.ControlCount) + '_' + IntToStr(Random(10000));
    btn.Caption := btn.Name;
    btn.OnMouseDown := @frmDesign.Button1MouseDown;
    btn.OnMouseUp := @frmDesign.Button1MouseUp;
    btn.OnMouseMove := @frmDesign.Button1MouseMove;
    btn.OnKeyDown := @frmDesign.FormKeyDown;
    btn.visible := true;
    btn.tag := 3;
  end;
end;

procedure TFrmMain.CheckSel;
var
  ok : Boolean;
begin
  ok := False;
  if frmDesign.selected=nil then exit;
  ok := ((frmDesign.selected is TPanel) and (TWinControl(frmDesign.selected).tag=0));
  if not ok then frmDesign.selected := nil;
end;

procedure TfrmMain.DoControlWrite(const Indent : String; const Prnt : TWinControl);
var
  a : Integer;
  count : Integer;
  obj : TControl;
  spc : String;
begin
 count := Prnt.ControlCount;
 spc := Indent + #9;
 for a := 0 to count - 1 do
 begin
      obj := Prnt.Controls[a];
      if obj is TButton then
      begin
        vr.Add('        ' + obj.Name + ': TButton;');
        fnc.add(spc + '// Begin ' + Prnt.name + ' Indentation');
        fnc.Add(spc + '// Begin ' + obj.name + ' Definition');
        if (obj.Parent<>nil) and (obj.Parent.Name <> 'frmDesign') then
        begin
          fnc.Add(spc + obj.Name + ' := TButton.create(' + obj.Parent.Name + ');');
          fnc.Add(spc + obj.Name + '.Parent := ' + obj.Parent.Name + ';');
        end else
        begin
             fnc.Add(spc + obj.Name + ' := TButton.create(MyForm);');
             fnc.Add(spc + obj.Name + '.Parent := MyForm;');
        end;
        fnc.Add(spc + Obj.Name + '.SetBounds('+ IntToStr(obj.left)+','+IntToStr(obj.top)+','+IntToStr(obj.Width)+','+ IntToStr(obj.Height)+');');
        fnc.adD(spc + obj.Name + '.Width := ' + intToStr(obj.width) + ';');
        fnc.adD(spc + obj.Name + '.Height := ' + intToStr(obj.Height) + ';');
        fnc.Add(spc + Obj.Name + '.Name := ''' + obj.Name + ''';');
        fnc.Add(spc + Obj.Name + '.Caption := ''' + TButton(obj).Caption + ''';');
        if TWinControl(obj).align = alNone then fnc.add(spc + obj.Name + '.Align := alNone;')
        else if TWinControl(obj).align = alTop then fnc.add(spc + obj.Name + '.Align := alTop;')
        else if TWinControl(obj).align = alBottom then fnc.add(spc + obj.Name + '.Align := alBottom;')
        else if TWinControl(obj).align = alLeft then fnc.add(spc + obj.Name + '.Align := alLeft;')
        else if TWinControl(obj).align = alRight then fnc.add(spc + obj.Name + '.Align := alRight;')
        else if TWinControl(obj).align = alClient then fnc.add(spc + obj.Name + '.Align := alClient;')
        else fnc.add(spc + obj.Name + '.Align := alNone;');
        evnt.Add('procedure ' + obj.Name + 'Click(Sender : TObject);');
        evnt.add('begin');
        evnt.add('        //');
        evnt.add('end;');
        evnt.add('');
        fnc.add(spc + obj.Name + '.OnClick := @' +obj.Name + 'Click;');
        fnc.Add(spc + '// End ' + obj.name + ' Definition');
      end else if obj is TEdit then
      begin
        vr.Add(spc + obj.Name + ': TEdit;');
        fnc.Add(spc + '// Begin ' + obj.name + ' Definition');
        if (obj.Parent<>nil) and (obj.Parent.Name <> 'frmDesign') then
        begin
          fnc.Add(spc + obj.Name + ' := TEdit.create(' + obj.Parent.Name + ');');
          fnc.Add(spc + obj.Name + '.Parent := ' + obj.Parent.Name + ';');
        end else
        begin
             fnc.Add(spc + obj.Name + ' := TEdit.create(MyForm);');
             fnc.Add(spc + obj.Name + '.Parent := MyForm;');
        end;
        fnc.Add(spc + Obj.Name + '.SetBounds('+ IntToStr(obj.left)+','+IntToStr(obj.top)+','+IntToStr(obj.Width)+','+IntToStr(obj.Height)+');');
        fnc.Add(spc + Obj.Name + '.Name := ''' + obj.Name + ''';');
        fnc.adD(spc + obj.Name + '.Width := ' + intToStr(obj.width) + ';');
        fnc.adD(spc + obj.Name + '.Height := ' + intToStr(obj.Height) + ';');
        fnc.Add(spc + Obj.Name + '.Text := ''' + TEdit(obj).text + ''';');
        if TWinControl(obj).align = alNone then fnc.add(spc + obj.Name + '.Align := alNone;')
        else if TWinControl(obj).align = alTop then fnc.add(spc + obj.Name + '.Align := alTop;')
        else if TWinControl(obj).align = alBottom then fnc.add(spc + obj.Name + '.Align := alBottom;')
        else if TWinControl(obj).align = alLeft then fnc.add(spc + obj.Name + '.Align := alLeft;')
        else if TWinControl(obj).align = alRight then fnc.add(spc + obj.Name + '.Align := alRight;')
        else if TWinControl(obj).align = alClient then fnc.add(spc + obj.Name + '.Align := alClient;')
        else fnc.add(spc + obj.Name + '.Align := alNone;');
        fnc.Add(spc + '// End ' + obj.name + ' Definition');
      end else if (obj is TPanel) and (TWinControl(Obj).tag = 1) then
      begin
        vr.Add(spc + obj.Name + ': TLabel;');
        fnc.Add(spc + '// Begin ' + obj.name + ' Definition');
        if (obj.Parent<>nil) and (obj.Parent.Name <> 'frmDesign') then
        begin
          fnc.Add(spc + obj.Name + ' := TLabel.create(' + obj.Parent.Name + ');');
          fnc.Add(spc + obj.Name + '.Parent := ' + obj.Parent.Name + ';');
        end else
        begin
             fnc.Add(spc + obj.Name + ' := TLabel.create(MyForm);');
             fnc.Add(spc + obj.Name + '.Parent := MyForm;');
        end;
        fnc.Add(spc + Obj.Name + '.SetBounds('+ IntToStr(obj.left)+','+IntToStr(obj.top)+','+IntToStr(obj.Width)+','+IntToStr(obj.Height)+');');
        fnc.adD(spc + obj.Name + '.Width := ' + intToStr(obj.width) + ';');
        fnc.adD(spc + obj.Name + '.Height := ' + intToStr(obj.Height) + ';');
        fnc.Add(spc + Obj.Name + '.Name := ''' + obj.Name + ''';');
        fnc.Add(spc + Obj.Name + '.Caption := ''' + TPanel(obj).Caption + ''';');
        if TWinControl(obj).align = alNone then fnc.add(spc + obj.Name + '.Align := alNone;')
        else if TWinControl(obj).align = alTop then fnc.add(spc + obj.Name + '.Align := alTop;')
        else if TWinControl(obj).align = alBottom then fnc.add(spc + obj.Name + '.Align := alBottom;')
        else if TWinControl(obj).align = alLeft then fnc.add(spc + obj.Name + '.Align := alLeft;')
        else if TWinControl(obj).align = alRight then fnc.add(spc + obj.Name + '.Align := alRight;')
        else if TWinControl(obj).align = alClient then fnc.add(spc + obj.Name + '.Align := alClient;')
        else fnc.add(spc + obj.Name + '.Align := alNone;');
        evnt.Add('procedure ' + obj.Name + 'Click(Sender : TObject);');
        evnt.add('begin');
        evnt.add('        //');
        evnt.add('end;');
        evnt.add('');
        fnc.add(spc + obj.Name + '.OnClick := @' +obj.Name + 'Click;');
        fnc.Add(spc + '// End ' + obj.name + ' Definition');
      end else if (obj is TPanel) and (TWinControl(Obj).tag = 2) then
      begin
        vr.Add(spc + obj.Name + ': TComboBox;');
        fnc.Add(spc + '// Begin ' + obj.name + ' Definition');
        if (obj.Parent<>nil) and (obj.Parent.Name <> 'frmDesign') then
        begin
          fnc.Add(spc + obj.Name + ' := TComboBox.create(' + obj.Parent.Name + ');');
          fnc.Add(spc + obj.Name + '.Parent := ' + obj.Parent.Name + ';');
        end else
        begin
             fnc.Add(spc + obj.Name + ' := TComboBox.create(MyForm);');
             fnc.Add(spc + obj.Name + '.Parent := MyForm;');
        end;
        fnc.Add(spc + Obj.Name + '.SetBounds('+ IntToStr(obj.left)+','+IntToStr(obj.top)+','+IntToStr(obj.Width)+','+IntToStr(obj.Height)+');');
        fnc.adD(spc + obj.Name + '.Width := ' + intToStr(obj.width) + ';');
        fnc.adD(spc + obj.Name + '.Height := ' + intToStr(obj.Height) + ';');
        fnc.Add(spc + Obj.Name + '.Name := ''' + obj.Name + ''';');
        fnc.Add(spc + Obj.Name + '.text := ''' + TPanel(obj).Caption + ''';');
        if TWinControl(obj).align = alNone then fnc.add(spc + obj.Name + '.Align := alNone;')
        else if TWinControl(obj).align = alTop then fnc.add(spc + obj.Name + '.Align := alTop;')
        else if TWinControl(obj).align = alBottom then fnc.add(spc + obj.Name + '.Align := alBottom;')
        else if TWinControl(obj).align = alLeft then fnc.add(spc + obj.Name + '.Align := alLeft;')
        else if TWinControl(obj).align = alRight then fnc.add(spc + obj.Name + '.Align := alRight;')
        else if TWinControl(obj).align = alClient then fnc.add(spc + obj.Name + '.Align := alClient;')
        else fnc.add(spc + obj.Name + '.Align := alNone;');
        evnt.Add('procedure ' + obj.Name + 'Click(Sender : TObject);');
        evnt.add('begin');
        evnt.add('        //');
        evnt.add('end;');
        evnt.add('');
        fnc.add(spc + obj.Name + '.OnClick := @' +obj.Name + 'Click;');
        fnc.Add(spc + '// End ' + obj.name + ' Definition');
      end else if (obj is TPanel) and (TWinControl(Obj).tag = 3) then
      begin
        vr.Add(spc + obj.Name + ': TImage;');
        fnc.Add(spc + '// Begin ' + obj.name + ' Definition');
        if (obj.Parent<>nil) and (obj.Parent.Name <> 'frmDesign') then
        begin
          fnc.Add(spc + obj.Name + ' := TImage.create(' + obj.Parent.Name + ');');
          fnc.Add(spc + obj.Name + '.Parent := ' + obj.Parent.Name + ';');
        end else
        begin
             fnc.Add(spc + obj.Name + ' := TImage.create(MyForm);');
             fnc.Add(spc + obj.Name + '.Parent := MyForm;');
        end;
        fnc.Add(spc + Obj.Name + '.SetBounds('+ IntToStr(obj.left)+','+IntToStr(obj.top)+','+IntToStr(obj.Width)+','+IntToStr(obj.Height)+');');
        fnc.adD(spc + obj.Name + '.Width := ' + intToStr(obj.width) + ';');
        fnc.adD(spc + obj.Name + '.Height := ' + intToStr(obj.Height) + ';');
        fnc.Add(spc + Obj.Name + '.Name := ''' + obj.Name + ''';');
        if TWinControl(obj).align = alNone then fnc.add(spc + obj.Name + '.Align := alNone;')
        else if TWinControl(obj).align = alTop then fnc.add(spc + obj.Name + '.Align := alTop;')
        else if TWinControl(obj).align = alBottom then fnc.add(spc + obj.Name + '.Align := alBottom;')
        else if TWinControl(obj).align = alLeft then fnc.add(spc + obj.Name + '.Align := alLeft;')
        else if TWinControl(obj).align = alRight then fnc.add(spc + obj.Name + '.Align := alRight;')
        else if TWinControl(obj).align = alClient then fnc.add(spc + obj.Name + '.Align := alClient;')
        else fnc.add(spc + obj.Name + '.Align := alNone;');
        evnt.Add('procedure ' + obj.Name + 'Click(Sender : TObject);');
        evnt.add('begin');
        evnt.add('        //');
        evnt.add('end;');
        evnt.add('');
        fnc.add(spc + obj.Name + '.OnClick := @' +obj.Name + 'Click;');
        fnc.Add(spc + '// End ' + obj.name + ' Definition');
      end else if (obj is TMemo) then
      begin
        vr.Add(spc + obj.Name + ': TMemo;');
        fnc.Add(spc + '// Begin ' + obj.name + ' Definition');
        if (obj.Parent<>nil) and (obj.Parent.Name <> 'frmDesign') then
        begin
          fnc.Add(spc + obj.Name + ' := TMemo.create(' + obj.Parent.Name + ');');
          fnc.Add(spc + obj.Name + '.Parent := ' + obj.Parent.Name + ';');
        end else
        begin
             fnc.Add(spc + obj.Name + ' := TMemo.create(MyForm);');
             fnc.Add(spc + obj.Name + '.Parent := MyForm;');
        end;
        fnc.Add(spc + Obj.Name + '.SetBounds('+ IntToStr(obj.left)+','+IntToStr(obj.top)+','+IntToStr(obj.Width)+','+IntToStr(obj.Height)+');');
        fnc.adD(spc + obj.Name + '.Width := ' + intToStr(obj.width) + ';');
        fnc.adD(spc + obj.Name + '.Height := ' + intToStr(obj.Height) + ';');
        fnc.Add(spc + Obj.Name + '.Name := ''' + obj.Name + ''';');
        fnc.Add(spc + Obj.Name + '.lines.text := ''' + TMemo(obj).lines.text + ''';');
        if TWinControl(obj).align = alNone then fnc.add(spc + obj.Name + '.Align := alNone;')
        else if TWinControl(obj).align = alTop then fnc.add(spc + obj.Name + '.Align := alTop;')
        else if TWinControl(obj).align = alBottom then fnc.add(spc + obj.Name + '.Align := alBottom;')
        else if TWinControl(obj).align = alLeft then fnc.add(spc + obj.Name + '.Align := alLeft;')
        else if TWinControl(obj).align = alRight then fnc.add(spc + obj.Name + '.Align := alRight;')
        else if TWinControl(obj).align = alClient then fnc.add(spc + obj.Name + '.Align := alClient;')
        else fnc.add(spc + obj.Name + '.Align := alNone;');
        evnt.Add('procedure ' + obj.Name + 'Click(Sender : TObject);');
        evnt.add('begin');
        evnt.add('        //');
        evnt.add('end;');
        evnt.add('');
        fnc.add(spc + obj.Name + '.OnClick := @' +obj.Name + 'Click;');
        fnc.Add(spc + '// End ' + obj.name + ' Definition');
      end else if (obj is TCheckBox) then
      begin
        vr.Add(spc + obj.Name + ': TCheckBox;');
        fnc.Add(spc + '// Begin ' + obj.name + ' Definition');
        if (obj.Parent<>nil) and (obj.Parent.Name <> 'frmDesign') then
        begin
          fnc.Add(spc + obj.Name + ' := TCheckBox.create(' + obj.Parent.Name + ');');
          fnc.Add(spc + obj.Name + '.Parent := ' + obj.Parent.Name + ';');
        end else
        begin
             fnc.Add(spc + obj.Name + ' := TCheckBox.create(MyForm);');
             fnc.Add(spc + obj.Name + '.Parent := MyForm;');
        end;
        fnc.Add(spc + Obj.Name + '.SetBounds('+ IntToStr(obj.left)+','+IntToStr(obj.top)+','+IntToStr(obj.Width)+','+IntToStr(obj.Height)+');');
        fnc.adD(spc + obj.Name + '.Width := ' + intToStr(obj.width) + ';');
        fnc.adD(spc + obj.Name + '.Height := ' + intToStr(obj.Height) + ';');
        fnc.Add(spc + Obj.Name + '.Name := ''' + obj.Name + ''';');
        fnc.Add(spc + Obj.Name + '.caption := ''' + TCheckBox(obj).Caption + ''';');
        if TWinControl(obj).align = alNone then fnc.add(spc + obj.Name + '.Align := alNone;')
        else if TWinControl(obj).align = alTop then fnc.add(spc + obj.Name + '.Align := alTop;')
        else if TWinControl(obj).align = alBottom then fnc.add(spc + obj.Name + '.Align := alBottom;')
        else if TWinControl(obj).align = alLeft then fnc.add(spc + obj.Name + '.Align := alLeft;')
        else if TWinControl(obj).align = alRight then fnc.add(spc + obj.Name + '.Align := alRight;')
        else if TWinControl(obj).align = alClient then fnc.add(spc + obj.Name + '.Align := alClient;')
        else fnc.add(spc + obj.Name + '.Align := alNone;');
        evnt.Add('procedure ' + obj.Name + 'Click(Sender : TObject);');
        evnt.add('begin');
        evnt.add('        //');
        evnt.add('end;');
        evnt.add('');
        fnc.add(spc + obj.Name + '.OnClick := @' +obj.Name + 'Click;');
        fnc.Add(spc + '// End ' + obj.name + ' Definition');
      end else if (obj is TListBox) then
      begin
        vr.Add(spc + obj.Name + ': TListBox;');
        fnc.Add(spc + '// Begin ' + obj.name + ' Definition');
        if (obj.Parent<>nil) and (obj.Parent.Name <> 'frmDesign') then
        begin
          fnc.Add(spc + obj.Name + ' := TListBox.create(' + obj.Parent.Name + ');');
          fnc.Add(spc + obj.Name + '.Parent := ' + obj.Parent.Name + ';');
        end else
        begin
             fnc.Add(spc + obj.Name + ' := TListBox.create(MyForm);');
             fnc.Add(spc + obj.Name + '.Parent := MyForm;');
        end;
        fnc.Add(spc + Obj.Name + '.SetBounds('+ IntToStr(obj.left)+','+IntToStr(obj.top)+','+IntToStr(obj.Width)+','+IntToStr(obj.Height)+');');
        fnc.adD(spc + obj.Name + '.Width := ' + intToStr(obj.width) + ';');
        fnc.adD(spc + obj.Name + '.Height := ' + intToStr(obj.Height) + ';');
        fnc.Add(spc + Obj.Name + '.Name := ''' + obj.Name + ''';');
        fnc.Add(spc + Obj.Name + '.items.text := ''' + trim(TListBox(obj).Items.text) + ''';');
        if TWinControl(obj).align = alNone then fnc.add(spc + obj.Name + '.Align := alNone;')
        else if TWinControl(obj).align = alTop then fnc.add(spc + obj.Name + '.Align := alTop;')
        else if TWinControl(obj).align = alBottom then fnc.add(spc + obj.Name + '.Align := alBottom;')
        else if TWinControl(obj).align = alLeft then fnc.add(spc + obj.Name + '.Align := alLeft;')
        else if TWinControl(obj).align = alRight then fnc.add(spc + obj.Name + '.Align := alRight;')
        else if TWinControl(obj).align = alClient then fnc.add(spc + obj.Name + '.Align := alClient;')
        else fnc.add(spc + obj.Name + '.Align := alNone;');
        evnt.Add('procedure ' + obj.Name + 'Click(Sender : TObject);');
        evnt.add('begin');
        evnt.add('        //');
        evnt.add('end;');
        evnt.add('');
        fnc.add(spc + obj.Name + '.OnClick := @' +obj.Name + 'Click;');
        fnc.Add(spc + '// End ' + obj.name + ' Definition');
      end else if (obj is TPanel) and (obj.tag = 0) then
      begin
        vr.Add(spc + obj.Name + ': TPanel;');
        fnc.Add(spc + '// Begin ' + obj.name + ' Definition');
        if (obj.Parent<>nil) and (obj.Parent.Name <> 'frmDesign') then
        begin
          fnc.Add(spc + obj.Name + ' := TPanel.create(' + obj.Parent.Name + ');');
          fnc.Add(spc + obj.Name + '.Parent := ' + obj.Parent.Name + ';');
        end else
        begin
             fnc.Add(spc + obj.Name + ' := TPanel.create(MyForm);');
             fnc.Add(spc + obj.Name + '.Parent := MyForm;');
        end;
        fnc.Add(spc + Obj.Name + '.SetBounds('+ IntToStr(obj.left)+','+IntToStr(obj.top)+','+IntToStr(obj.Width)+','+IntToStr(obj.Height)+');');
        fnc.adD(spc + obj.Name + '.Width := ' + intToStr(obj.width) + ';');
        fnc.adD(spc + obj.Name + '.Height := ' + intToStr(obj.Height) + ';');
        fnc.Add(spc + Obj.Name + '.Name := ''' + obj.Name + ''';');
        fnc.Add(spc + Obj.Name + '.caption := ''' + TPanel(obj).Caption + ''';');
        if TWinControl(obj).align = alNone then fnc.add(spc + obj.Name + '.Align := alNone;')
        else if TWinControl(obj).align = alTop then fnc.add(spc + obj.Name + '.Align := alTop;')
        else if TWinControl(obj).align = alBottom then fnc.add(spc + obj.Name + '.Align := alBottom;')
        else if TWinControl(obj).align = alLeft then fnc.add(spc + obj.Name + '.Align := alLeft;')
        else if TWinControl(obj).align = alRight then fnc.add(spc + obj.Name + '.Align := alRight;')
        else if TWinControl(obj).align = alClient then fnc.add(spc + obj.Name + '.Align := alClient;')
        else fnc.add(spc + obj.Name + '.Align := alNone;');
        fnc.Add(spc + '// End ' + obj.name + ' Definition');
        if TWinControl(obj).ControlCount>-1 then DoControlWrite(spc, TWinControl(obj));
      end;
      fnc.add(spc + '// End ' + Prnt.name + ' Indentation');
 end;
end;

end.

