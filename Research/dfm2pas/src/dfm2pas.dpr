{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE CONSOLE}
program DFM2Pas;
(*
The main module of the DFM2PAS utility by Alexei Hmelnov.
----------------------------------------------------------------------------
E-Mail: alex@monster.icc.ru
http://monster.icc.ru/~alex/
----------------------------------------------------------------------------

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
uses
  SysUtils,
  Classes,
  MethProp in 'MethProp.pas';

{$R *.RES}

  procedure WriteUsage;
  begin
    Writeln(
    'Usage:'#13#10+
    '  RES2DFM <Source file> <Target file> [<parent name> [<ParentUnit>]]'#13#10+
    ' or'#13#10+
    '  RES2DFM <Source file>.DFM [<parent name> [<ParentUnit>]]');
  end ;

var
  MainClassName, MainObjectName: String;
  MainFlags: TFilerFlags;

procedure GeneratePas(S: TMemoryStream; PasFName,ParentName,ParentUnit: String);
const
  B1: array[boolean] of Char = ' {';
  B2: array[boolean] of PChar = ('','}');
var
  NestingLevel: integer;
  Reader: TReader;
  PasF: System.Text;
  UnitName: String;
  PropList,MethodList,UsesList: TStringList;

  function WasUsed(S: String): boolean;
  begin
    Result := UsesList.IndexOf(S)>=0;
  end ;

  procedure AddUses(S: String);
  begin
    if WasUsed(S) then
      Exit;
    UsesList.Add(S);
  end ;

  function ConvertHeader: TComponentInfo;
  var
    pfxFlags: TFilerFlags;
    pfxPos: Integer;
    ClassName, ObjectName: String;
  begin
    Result := Nil;
    Reader.ReadPrefix(pfxFlags, pfxPos);
    ClassName := Reader.ReadStr;
    ObjectName := Reader.ReadStr;
    if ObjectName='' then
      Exit;
    if NestingLevel>0 then begin
      PropList.Add(Format(' %s%s: %s;%s',[B1[ffInherited in pfxFlags],
           ObjectName,ClassName,B2[ffInherited in pfxFlags]]));
     end
    else begin
      MainFlags := pfxFlags;
      MainClassName := ClassName;
      MainObjectName := ObjectName;
    end ;
    Result := GetComponentInfo(ClassName);
    if (Result<>Nil)and(Result.UnitName<>'') then
      AddUses(Result.UnitName);
  end ;

  procedure ConvertProperty(CI: TComponentInfo); forward;

  procedure ConvertBinary;
  const
    BytesPerLine = 32;
  var
    I: Integer;
    Count: Longint;
    Buffer: array[0..BytesPerLine - 1] of Char;
  begin
    Reader.ReadValue;
    Inc(NestingLevel);
    Reader.Read(Count, SizeOf(Count));
    while Count > 0 do
    begin
      if Count >= 32 then I := 32 else I := Count;
      Reader.Read(Buffer, I);
      Dec(Count, I);
    end;
    Dec(NestingLevel);
  end;

  function ConvertValue: String;
  var
    S: string;
  begin
    Result := '';
    case Reader.NextValue of
      vaList:
        begin
          Reader.ReadValue;
          Inc(NestingLevel);
          while not Reader.EndOfList do
            ConvertValue;
          Reader.ReadListEnd;
          Dec(NestingLevel);
        end;
      vaInt8, vaInt16, vaInt32:
        Reader.ReadInteger;
      vaExtended:
        Reader.ReadFloat;
      vaString, vaLString:
        Reader.ReadString;
      vaIdent:
        Result := Reader.ReadIdent;
      vaFalse, vaTrue, vaNil:
        Reader.ReadIdent;
      vaBinary:
        ConvertBinary;
      vaSet:
        begin
          Reader.ReadValue;
          while True do
          begin
            S := Reader.ReadStr;
            if S = '' then Break;
          end;
        end;
      vaCollection:
        begin
          Reader.ReadValue;
          Inc(NestingLevel);
          while not Reader.EndOfList do
          begin
            if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
            begin
              ConvertValue;
            end;
            //Reader.CheckValue(vaList);
            if Reader.ReadValue<>vaList then {Ignore};
            Inc(NestingLevel);
            while not Reader.EndOfList do ConvertProperty(Nil);
            Reader.ReadListEnd;
            Dec(NestingLevel);
          end;
          Reader.ReadListEnd;
          Dec(NestingLevel);
        end;
    end;
  end;

  procedure ConvertProperty(CI: TComponentInfo);
  var
    Name,V,M: String;
  begin
    Name := Reader.ReadStr;
    V := ConvertValue;
    if CI=Nil then
      Exit;
    if (Name='')or(V='') then
      Exit;
    M := CI.GetPropertyMethod(Name,V);
    if M<>'' then
      MethodList.Add(M);
  end;

  procedure ConvertObject;
  var
    CI: TComponentInfo;
  begin
    CI := ConvertHeader;
    Inc(NestingLevel);
    while not Reader.EndOfList do ConvertProperty(CI);
    Reader.ReadListEnd;
    while not Reader.EndOfList do ConvertObject;
    Reader.ReadListEnd;
    Dec(NestingLevel);
  end;

  procedure WriteUsesList;
  const
    Sep: array[boolean] of PChar = (', ',','#13#10'  ');
  var
    i: integer;
  begin
    for i:=0 to UsesList.Count-1 do
      Write(PasF,Sep[(i mod 6)=0],UsesList[i])
  end ;

  procedure WriteHdrList(S0: String; L: TStrings);
  var
    i: integer;
  begin
    for i:=0 to L.Count-1 do
      Writeln(PasF,S0,L[i]);
  end ;

  procedure WriteBodyMethods;
  var
    i: integer;
    S: String;
    CP: PChar;
    NameP: String;
  begin
    NameP := MainClassName+'.';
    for i:=0 to MethodList.Count-1 do begin
      S := MethodList[i];
      CP := StrScan(PChar(S),' ');
      if CP<>Nil then
        Insert(NameP,S,CP-PChar(S)+2);
      Writeln(PasF,S,#13#10'begin'#13#10'  {Auto}'#13#10'end ;'#13#10);
    end ;
  end ;

begin
  PasFName := ChangeFileExt(PasFName,'.pas');
  AssignFile(PasF,PasFName);
 {$I-}
  rewrite(PasF);
 {$I+}
  if IOResult<>0 then
    raise Exception.CreateFmt('Can''t open "%s"',[PasFName]);
  try
    LoadComponentDescrs;
    try
      MethodList := TStringList.Create;
      PropList := TStringList.Create;
      UsesList := TStringList.Create;
      try
        MethodList.Sorted := true;
        MethodList.Duplicates := DupIgnore;
        {UsesList.Sorted := true;
        UsesList.Duplicates := DupIgnore;}
        AddUses('Controls');
        AddUses('Forms');
        AddUses('Dialogs');
        UnitName := ExtractFileName(PasFName);
        UnitName := ChangeFileExt(UnitName,'');
        Write(PasF,
        'unit ',UnitName,';'#13#10+
        #13#10+
        'interface'#13#10+
        #13#10+
        'uses'#13#10+
        '  Windows, Messages, SysUtils, Classes, Graphics');
        Reader := TReader.Create(S, 4096);
        try
          NestingLevel := 0;
          Reader.ReadSignature;
          ConvertObject;
          if (ffInherited in MainFlags)or(ParentUnit<>'') then
            AddUses(ParentUnit);
          WriteUsesList;
          Writeln(PasF,';'#13#10#13#10'type');
          if not(ffInherited in MainFlags)and(ParentName='') then
            ParentName := 'TForm';
          Writeln(PasF,'  ',MainClassName,'=class(',ParentName,')');
          WriteHdrList('  ',PropList);
          WriteHdrList('    ',MethodList);
          Writeln(PasF,
          '  private'#13#10+
          '    { Private declarations }'#13#10+
          '  public'#13#10+
          '    { Public declarations }'#13#10+
          '  end ;'#13#10);
          if MainObjectName<>'' then begin
            Writeln(PasF,'var'#13#10'  ',MainObjectName,': ',MainClassName,';'#13#10);
          end ;
        finally
          Reader.Free;
        end;
        Writeln(PasF,
        'implementation'#13#10+
        #13#10+
        '{$R *.DFM}'#13#10+
        #13#10);
        WriteBodyMethods;
        Writeln(PasF,'end.');
        Writeln(Format('PAS with %s was generated (%d components, %d events).',
          [MainClassName,PropList.Count,MethodList.Count]));
      finally
        UsesList.Free;
        MethodList.Free;
        PropList.Free;
      end ;
    finally
      FreeComponentDescrs;
    end ;
  finally
    Close(PasF);
  end ;
end ;

procedure GenerateDFM(S: TMemoryStream; FName,MainClassName: String);
type
  TDFMHdr = packed record
    bFF: byte;
    w10: word;
    ResName: array[byte]of Char;
  end ;

  TDFMHdr1 = packed record
    w1030: word;
    ImageSize: LongInt;
  end ;
//ends: assert[@.bFF=0xFF,@.w10=10,@.w1030=0x1030,@.ImageSize=FileSize-@:Size]

var
  ResF: File;
  Sz: LongInt;
  Hdr: TDFMHdr;
  Hdr1: TDFMHdr1;
begin
  Assign(ResF,FName);
 {$I-}
  Rewrite(ResF,1);
 {$I+}
  if IOResult<>0 then
    raise Exception.CreateFmt('Can''t open "%s"',[FName]);
  try
    Hdr.bFF := $FF;
    Hdr.w10 := 10;
    StrPCopy(Hdr.ResName,PChar(UpperCase(MainClassName)));
    BlockWrite(ResF,Hdr,SizeOf(Hdr)-SizeOf(Hdr.ResName)+1+Length(MainClassName));
    Hdr1.w1030 := $1030;
    Sz := S.Size;
    Hdr1.ImageSize := Sz;
    BlockWrite(ResF,Hdr1,SizeOf(Hdr1));
    BlockWrite(ResF,S.Memory^,Sz);
    Writeln(Sz,' bytes of form data written.');
  finally
    Close(ResF);
  end ;
end ;

procedure Convert;
var
  PN: integer;
  DFMName,ParentName,ParentUnit: String;
  Pos0: LongInt;
  S: TMemoryStream;
  SrcIsDFM: boolean;
  STxt: TFileStream;
begin
  DFMName := ParamStr(1);
  PN := 1;
  S := TMemoryStream.Create;
  try
    S.LoadFromFile(DFMName);
    SrcIsDFM := (S.Size>0)and(Byte(S.Memory^)=$FF);
    if not SrcIsDFM then begin
      Inc(PN);
      if PN>ParamCount then begin
        WriteUsage;
        Exit;
      end ;
      DFMName := ParamStr(PN);
      if ExtractFileExt(DFMName)='' then
        DFMName := DFMName+'.dfm';
      Pos0 := 0;
     end
    else begin
      S.ReadResHeader;
      Pos0 := S.Position;
    end ;
    STxt := TFileStream.Create(ChangeFileExt(DFMName,'.txt'),fmCreate);
    try
      ObjectBinaryToText(S,STxt);
      Writeln('TXT was generated.');
    finally
      STxt.Free;
    end ;
    ParentName := '';
    Inc(PN);
    if ParamCount>=PN then
      ParentName := ParamStr(PN);
    ParentUnit := '';
    Inc(PN);
    if ParamCount>=PN then
      ParentUnit := ParamStr(PN);
    S.Position := Pos0;
    GeneratePas(S,DFMName,ParentName,ParentUnit);
    if not SrcIsDFM then begin
      S.Position := 0;
      GenerateDFM(S,DFMName,MainClassName);
      Writeln('DFM with ',MainClassName,' was generated.');
    end ;
  finally
    S.Free;
  end ;
end ;

begin
  if ParamCount<1 then begin
    WriteUsage;
    Exit;
  end ;
  try
    Convert;
  except
    on E: Exception do
      Writeln(Format('%s: "%s"',[E.ClassName,E.Message]));
  end ;
  Write('Press <ENTER> to exit...');
  Readln;
end .