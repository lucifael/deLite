unit uDesign;

{$mode objfpc}{$H+}

interface

uses
  Classes, windows, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, uMain;

type

  { TfrmDesign }

  TfrmDesign = class(TForm)
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
  private
    { private declarations }
    inReposition : boolean;
    oldPos : TPoint;
  public
    { public declarations }
    Selected : TWinControl;
  end;

var
  frmDesign: TfrmDesign;

implementation

{$R *.lfm}

{ TfrmDesign }

procedure TfrmDesign.Button1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Sender is TWinControl) then
  begin
    Selected := TWinControl(Sender);
    frmMain.SetProperties(Selected);
    inReposition:=True;
    SetCapture(TWinControl(Sender).Handle);
    GetCursorPos(oldPos);
  end;
end;

procedure TfrmDesign.Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  minWidth = 20;
  minHeight = 20;
var
  newPos: TPoint;
  frmPoint : TPoint;
begin
  if inReposition then
  begin
    with TWinControl(Sender) do
    begin
      GetCursorPos(newPos);
      if ssShift in Shift then
      begin //resize
        Screen.Cursor := crSizeNWSE;
        frmPoint := ScreenToClient(Mouse.CursorPos);
        if frmPoint.X > minWidth then
          Width := frmPoint.X;
        if frmPoint.Y > minHeight then
          Height := frmPoint.Y;
      end
      else //move
      begin
        Screen.Cursor := crSize;
        Left := Left - oldPos.X + newPos.X;
        Top := Top - oldPos.Y + newPos.Y;
        oldPos := newPos;
      end;
    end;
  end;
end;

procedure TfrmDesign.Button1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if inReposition then
  begin
    Screen.Cursor := crDefault;
    ReleaseCapture;
    inReposition := False;
  end;
end;

procedure TfrmDesign.FormClick(Sender: TObject);
begin
  ReleaseCapture;
  InReposition := false;
  Selected := nil;
  frmMain.SetProperties(Selected);
end;

procedure TfrmDesign.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caNone;
end;

procedure TfrmDesign.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := false;
end;

procedure TfrmDesign.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   prnt : TWinControl;
begin
  if Selected=nil then exit;
  if key = vk_delete then
  begin
      TControl(Selected).Name:='';
      TControl(Selected).tag:=-1;
      if TControl(Selected).Parent.Name <> 'frmDesign' then
      begin
        prnt := TWinControl(Selected).Parent;
        prnt.RemoveControl(TWinControl(Selected));
      end else
      begin
        try
           RemoveControl(TControl(Selected));
        except
          // Dunno!
        end;
      end;
      selected := nil;
  end else if key = vk_escape then
  begin
    if (TControl(selected).Parent<>nil) and (TControl(selected).Parent.Name<>'frmDesigner') then
    begin
      try
         selected := TControl(selected).parent;
         frmMain.SetProperties(selected);
      except
        ShowMessage('Unable to find parent');
      end;
    end;
  end;
end;

procedure TfrmDesign.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  frmPoint : TPoint;
  cntl : TObject;
begin
  frmPoint := ScreenToClient(Mouse.CursorPos);
  frmMain.lblPos.caption := 'X: ' + IntToStr(frmPoint.x) + ' Y: ' + IntToStr(frmPoint.y);
  cntl := self.ControlAtPos(frmPoint, true);
  if cntl<>nil then
  begin
    if cntl is TWinControl then
       frmMain.lblPos.caption := frmMain.LblPos.caption + #10#13 + TWinControl(cntl).name;
  end;

end;

procedure TfrmDesign.FormPaint(Sender: TObject);
const
  Space = 8;
var
  x, y, col, row, RDot, CDot : Integer;
begin
  col := 0;
  row := 0;
  RDot := 0;
  CDot := 0;
  for x := 0 to self.width*2 do
  begin
    if Col=space then
    begin
         Row := 0;
         RDot := 0;
         for y := 0 to self.Height*2 do
         begin
            inc(Row);
            if Row = space then
            begin
               if (RDot = space) then
               begin
                  self.canvas.Pen.Color:=clRed;
                  if RDot = Space then RDot := 0;
               end else
               begin
                 self.canvas.Pen.Color:=clBlack;
               end;
               self.Canvas.Line(x,y,x+1,y);
               Row := 0;
               inc(RDot);
               if CDot mod space = 0 then
               begin
                 self.canvas.pen.color := clGreen;
                 self.Canvas.Line(x,y,x+1,y);
                 CDot := 0;
                 self.canvas.pen.color := clBlack;
               end;
            end;
            inc(CDot);
         end;
         Col := 0;
    end;
    inc(Col);
  end;
end;

end.

