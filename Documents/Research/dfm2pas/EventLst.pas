(*
The Component Event Lister Expert for
the DFM2PAS utility by Alexei Hmelnov.
----------------------------------------------------------------------------
E-Mail: alex@monster.icc.ru
http://monster.icc.ru/~alex/
----------------------------------------------------------------------------

To obtain the file "classes.lst" corresponding to the current state of your
component library do the following (it was tested in Delphi 3.0 and may
slightly differ for other Delphi versions):

1. Select "Component/Install Component..." in Delphi menu.

2. Press "Browse" button, select the file "EventLst.pas" and press Ok.

3. Answer Yes to the prompt to rebuild the package.

4. Select "Help/Get Component Event List" in Delphi menu.
  The message will appear reporting where the resulting file will be stored -
  press Ok.

5. Copy resulting file to the DFM2Pas directory.

6. In the package window Remove the EventLst file and Compile the package.

The structure of the classes.lst file:

{
<Component Unit Name>':' NL
{
<Component name> '(' <Ancestor name> ')' NL
  {<Event Name> ':' <Event Type Name> NL }*
  NL
}*
}*
'type'
{<Event Type Name> '=' <Procedure type declaration> NL}

See the file "readme.txt" for more details.

------------------------------------------------------------------------
                             IMPORTANT NOTE:
This software is provided 'as-is', without any expressed or implied warranty.
In no event will the author be held liable for any damages arising from the
use of this software.
Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:
1. The origin of this software must not be misrepresented, you must not
   claim that you wrote the original software.
2. Altered source versions must be plainly marked as such, and must not
   be misrepresented as being the original software.
3. This notice may not be removed or altered from any source
   distribution.
*)

unit EventLst;

interface

uses
  Windows,SysUtils,ToolIntf,TypInfo,Classes,Dialogs;

procedure GetStdComponents;

procedure Register;

implementation

uses
  ExptIntf,VirtIntf;

procedure GetStdComponents;
var
  im,ic: integer;
  ModuleName,UnitName: String;
  i: integer;

var
  EvtTbl: TStringList;

  procedure ReportComponent(Name: String);
  var
    CRef,CPRef: TClass;
    TypeInf,PropTI: PTypeInfo;
    TypeData,PropTD: PTypeData;
    CName: String;
    PropList: PPropList;
    PropName: String;
    i,PropNum: integer;
  begin
    CRef := TClass(GetClass(Name));
    if CRef=Nil then
      Exit;
    TypeInf := CRef.ClassInfo;
    TypeData := GetTypeData(TypeInf);
    if UnitName<>TypeData^.UnitName then begin
      UnitName := TypeData^.UnitName;
      Writeln(UnitName,':');
      Writeln;
    end ;
    CName := CRef.ClassName;
    Write({'  ',}CName);
    if (CName<>'TComponent') then begin
      CPRef := CRef.ClassParent;
      if CPRef<>Nil then begin
        Write('(',CPRef.ClassName,')');
      end ;
    end ;
    Writeln;
    PropNum := TypeData^.PropCount;
    GetMem(PropList,PropNum*SizeOf(Pointer));
    try
      GetPropInfos(TypeInf,PropList);
      for i:=0 to PropNum-1 do with PropList^[i]^ do begin
        PropTI := PropType^;
        if PropTI^.Kind<>tkMethod then
          Continue;
        EvtTbl.AddObject(PropTI^.Name,Pointer(PropTI));
        Writeln({'    ',}'  ',Name,': ',PropTI^.Name);
        {
        PropTD := GetTypeData(PropTI);
        Write('    ',Name,': ',PropTI^.Name,'=',
          LowerCase(Copy(GetEnumName(TypeInfo(TMethodKind),integer(PropTD^.MethodKind)),3,255)));
        SP := @PropTD^.ParamList;
        }
      end ;
      Writeln;
    finally
      FreeMem(PropList,PropNum*SizeOf(Pointer));
    end ;
  end ;

  procedure ReportEvent(PropTI: PTypeInfo);
  var
    PropTD: PTypeData;
    j: integer;
    SepCh: PChar;
    SP: Pointer;
    NP,TP: PShortString;
    PF: TParamFlags;

    procedure PutFlag(F: TParamFlags; S: String);
    begin
      if PF*F<>[] then
        Write(S);
    end ;

  begin
    PropTD := GetTypeData(PropTI);
    Write({'  ',}PropTI^.Name,'=',
      LowerCase(Copy(GetEnumName(TypeInfo(TMethodKind),integer(PropTD^.MethodKind)),3,255)));
    SP := @PropTD^.ParamList;
    if PropTD^.ParamCount>0 then begin
      SepCh := '(';
      for j:=0 to PropTD^.ParamCount-1 do begin
        PF := TParamFlags(SP^);
        Write(SepCh);
        PutFlag([pfVar],'var ');
        PutFlag([pfConst],'const ');
        PutFlag([pfOut],'out ');
        PutFlag([pfReference],'ref ');
      //PutFlag([pfAddress],'adr ');
        Inc(PChar(SP),SizeOf(TParamFlags));
        NP := SP;
        Inc(PChar(SP),Length(NP^)+1);
        TP := SP;
        Inc(PChar(SP),Length(TP^)+1);
        Write(NP^,': ');
        PutFlag([pfArray],'array of ');
        Write(TP^);
        SepCh := '; ';
      end ;
      Write(')');
    end ;
    if PropTD^.MethodKind=mkFunction then
      Write(': ',PShortString(SP)^);
    Writeln(';');
  end ;

begin
  if ToolServices=Nil then
    Exit;
  EvtTbl := TStringList.Create;
  try
    EvtTbl.Sorted := true;
    EvtTbl.Duplicates := dupIgnore;
    UnitName := '';
    for im := 0 to ToolServices.GetModuleCount-1 do begin
      {ModuleName := ToolServices.GetModuleName(im);
      Writeln(ModuleName,':');}
      for ic := 0 to ToolServices.GetComponentCount(im)-1 do
        ReportComponent(ToolServices.GetComponentName(im,ic));
    end ;
    ReportComponent('TForm');
    ReportComponent('TDataModule');
    ReportComponent('TWebModule');
    Writeln;
    Writeln('type');
    Writeln;
    for i:=0 to EvtTbl.Count-1 do begin
      ReportEvent(Pointer(EvtTbl.Objects[i]));
    end ;
  finally
    EvtTbl.Free;
  end ;
end ;

type

TComponentEventLister = class(TIExpert)
  function GetName:String; override;
  function GetStyle:TExpertStyle; override;
  function GetState:TExpertState; override;
  function GetIDString:String; override;
  function GetMenuText:String; override;
  procedure Execute; override;
end ;

{ TComponentEventLister. }
function TComponentEventLister.GetName:String;
begin
  Result := 'ComponentEventLister';
end ;

function TComponentEventLister.GetStyle:TExpertStyle;
begin
  Result := esStandard;
end ;

function TComponentEventLister.GetState:TExpertState;
begin
  Result := [esEnabled];
end ;

function TComponentEventLister.GetIDString:String;
begin
  Result := 'AX.ComponentEventLister';
end ;

function TComponentEventLister.GetMenuText:String;
begin
  Result := 'Get Component Event List';
end ;

procedure TComponentEventLister.Execute;
var
  SaveOut: TTextRec;
  Buf: array[0..MAX_PATH]of Char;
  TempStr: String;
  L: DWORD;
begin
  try
    SaveOut := TTextRec(Output);
    try
      L := GetTempPath(SizeOf(Buf),Buf);
      SetString(TempStr,Buf,L);
      if TempStr='' then
        TempStr := 'c:';
      L := Length(TempStr);
      if TempStr[L]='\' then
        SetLength(TempStr,L-1);
      TempStr := TempStr+'\classes.lst';
      ShowMessage(Format('Event List will be written to "%s".',[TempStr]));
      AssignFile(Output,TempStr);
      Rewrite(Output);
      try
        GetStdComponents;
      finally
        CloseFile(Output);
      end ;
    finally
      TTextRec(Output) := SaveOut;
    end ;
  except
    ToolServices.RaiseException(ReleaseException);
  end ;
end ;

procedure Register;
begin
  RegisterLibraryExpert(TComponentEventLister.Create);
end ;

end.
