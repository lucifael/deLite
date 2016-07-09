unit uTipOfTheDay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, uMain, bigIni;

type

  { TfrmTipOfTheDay }

  TfrmTipOfTheDay = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    chkShowTips: TCheckBox;
    Image1: TImage;
    Label1: TLabel;
    memTip: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Timer1: TTimer;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
    TipList : TStringList;
    ToHide : Integer;
    function GetFileList(FDirectory, Filter: TFileName; var lst : TStringList): boolean;
  public
    { public declarations }
    Procedure LoadTip(Index : Integer);
  end;

var
  frmTipOfTheDay: TfrmTipOfTheDay;

implementation

{$R *.lfm}

{ TfrmTipOfTheDay }


procedure TfrmTipOfTheDay.FormCreate(Sender: TObject);
begin
     TipList := TStringList.create;
     GetFileList(frmMain.Dir.FTipDirectory, '*.tips', TipList);
     LoadTip(Random(TipList.count-1));
     ToHide := 30;
     if (TipList.count-1)<=-1 then
     begin
       ToHide := 1;
       close;
     end;
end;

procedure TfrmTipOfTheDay.Label1Click(Sender: TObject);
begin
  Timer1.Enabled := Not Timer1.Enabled;
  ToHide := 30;
end;

procedure TfrmTipOfTheDay.Timer1Timer(Sender: TObject);
begin
  dec(ToHide);
  label1.Caption:=IntToStr(ToHide) + ' Seconds until close';
  if ToHide<=0 then close;
end;

Procedure TfrmTipOfTheDay.LoadTip(Index : Integer);
var
  ini : TBigIniFile;
  fname : String;
  Entry, Count : Integer;
begin
     memTip.lines.clear;
     ToHide := 30;
//     ShowMessage('Index ' + IntToStr(Index));
     if Index>(TipList.count-1) then exit;
     if IndeX<0 then exit;
     if TipList.count - 1 = 0 then Index := 0;
     Fname := TipList[Index];
     ini := TBiginiFile.create(fname);
     try
        count := ini.ReadInteger('Header', 'Count', -1);
        if count<>-1 then
        begin
          Entry := Random(Count-1);
          ini.ReadNumberedList('Entry' + IntToStr(Entry), memTip.lines, '');
        end else
        begin
          memTip.lines.clear;
          memTip.Lines.text := 'Problem with Tips File ' + Fname + #10#13 + 'Check website at http://seshat.lucifael.com for updates or use Internet Assets Dialog in application itself';
        end;
     finally
       ini.free;
     end;
end;

procedure TfrmTipOfTheDay.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
       TipList.free;
end;

procedure TfrmTipOfTheDay.BitBtn2Click(Sender: TObject);
begin
     LoadTip(Random(TipList.count-1));
end;

function TfrmTipOfTheDay.GetFileList(FDirectory, Filter: TFileName; var lst : TStringList): boolean;
var
   ARec: TSearchRec;
   Res: Integer;
begin
     if FDirectory[Length(FDirectory)] <> '\' then FDirectory := FDirectory + '\';
     try
        Res := FindFirst(FDirectory + Filter, faAnyFile and faDirectory , ARec);
        if Res=0 then
        begin
          repeat
            if FileExists(FDirectory + ARec.Name) then
            begin
                 if lowercase(ExtractFileExt(ARec.Name)) = '.tips' then
                 begin
                     lst.Add(FDirectory + ARec.Name);
                 end;
            end;
{            if (ARec.Attr and faDirectory) = faDirectory then
               if ARec.Name <> '.' then
                  if ARec.Name<>'..' then GetFileList(FDirectory + ARec.NAme, filter, lst);
}
          until FindNExt(ARec)<>0;
        end;
        FindClose(ARec);
        Result := true;
        except
              lst.clear;
              Result := false;
        end;
end;


end.

