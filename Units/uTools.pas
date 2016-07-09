
unit uTools;

interface
{$mode DELPHI}
uses SysUtils, classes, windows, MMSystem, registry, dialogs, shellAPI;

  // String Handling Functions

  Function SubStr(Const Source: String; Const StartPos : Integer; Const EndPos : Integer) : String;
  function Posn(const s, t : String; count : Integer) : Integer;
  function removeBadChar(const str: String) : String;

  // URL Handling
  procedure ParseURL(const URL : String; var Proto, User, Pass, Host, Port, Path : String);
  function GetBase(const URL: string): string; {Given an URL, get the base directory}
  function Combine(Base, APath: string): string; {combine a base and a path taking into account that overlap might exist}
  function Normalize(const URL: string): string; {lowercase, trim, and make sure a '/' terminates a hostname, adds http://}
  function IsFullURL(Const URL: string): boolean; {set if contains http://}
  Function ExtractURLProtocol(Const sURL : String) : String;
  Function ExtractURLServer(Const sURL : String) : String;
  Function ExtractURLPort(Const sURL : String) : String;
  Function ExtractURLPath(Const sURL : String) : String;
  function ExtractURLFilename(Const sURL : String) : String;
  Function ExtractURLParams(Const sURL : String) : String;
  function UrlEncode(const DecodedStr: String; Pluses: Boolean): String; // Encodes standard string into URL data format.
  function UrlDecode(const EncodedStr: String): String; // Decodes URL data into a readable string.
  function DosToHTML(FName: string): string;
  Function ReturnSysDir(const DirName : String) : String;
  function ReturnFileType(ftype : String) : String;
  function HexToInt(HexStr: String): Integer; // Taken from http://www.delphi3000.com/article.asp?id=1412

  // Various
  function myGetWindowsDirectory : String;
  function myGetSystemDirectory : String;
  function myGetUserName : String;
  function myGetComputerName : String;
  function GetTempFile(const Extension: string): string;
  function myGetTempPath: String;
  function EncryptString(Const Str : String) : String;
  Function DecyphrString(Const Str : String) : String;
  function CheckFname(str : String) : String;
  function Backslash(str : String) : String;



  implementation



// Put Functions Here




// This is just for me to work with, i;m an old basic coder and this helps me remember the code

Function SubStr(Const Source: String; Const StartPos : Integer; Const EndPos : Integer) : String;
begin
    Result := Trim(copy(Source, StartPos, EndPos));
End;



{ Syntax of an URL: protocol://[user[:password]@]server[:port]/path         }
procedure ParseURL(
    const url : String;
    var Proto, User, Pass, Host, Port, Path : String);
var
    p, q : Integer;
    s    : String;
    i : integer;
type
  TCharSet = set of Char;
const
  SchemeAllowedChars : TCharSet = ['a'..'z','0'..'9','+','-','.'];
begin
    proto := '';
    User  := '';
    Pass  := '';
    Host  := '';
    Port  := '';
    Path  := '';

    if Length(url) < 1 then
        Exit;

    p := pos('://',url);
{--- begin insertion by Alexander Alexishin 12.09.2001 --- }
    q := p;
    if p <> 0 then begin
      S := Copy(url, 1, p - 1);
      for i:=1 to Length(S) do
        if not (S[i] in SchemeAllowedChars) then begin
          q := i;
          Break;
        end;
      if q < p then begin
        p:=0;
        proto := 'http';
      end;
    end;
    if p = 0 then begin
        if (url[1] = '/') then begin
            { Relative path without protocol specified }
            proto := 'http';
            p     := 1;
            if (Length(url) > 1) and (url[2] <> '/') then begin
                { Relative path }
                Path := Copy(url, 1, Length(url));
                Exit;
            end;
        end
        else if lowercase(Copy(url, 1, 5)) = 'http:' then begin
            proto := 'http';
            p     := 6;
            if (Length(url) > 6) and (url[7] <> '/') then begin
                { Relative path }
                Path := Copy(url, 6, Length(url));
                Exit;
            end;
        end
        else if lowercase(Copy(url, 1, 7)) = 'mailto:' then begin
            proto := 'mailto';
            p := pos(':', url);
        end;
    end
    else begin
        proto := Copy(url, 1, p - 1);
        inc(p, 2);
    end;
    s := Copy(url, p + 1, Length(url));

    p := pos('/', s);
    if p = 0 then
        p := Length(s) + 1;
    Path := Copy(s, p, Length(s));
    s    := Copy(s, 1, p-1);

    p := Posn(':', s, -1);
    if p > Length(s) then
        p := 0;
    q := Posn('@', s, -1);
    if q > Length(s) then
        q := 0;
    if (p = 0) and (q = 0) then begin   { no user, password or port }
        Host := s;
        Exit;
    end
    else if q < p then begin  { a port given }
        Port := Copy(s, p + 1, Length(s));
        Host := Copy(s, q + 1, p - q - 1);
        if q = 0 then
            Exit; { no user, password }
        s := Copy(s, 1, q - 1);
    end
    else begin
        Host := Copy(s, q + 1, Length(s));
        s := Copy(s, 1, q - 1);
    end;
    p := pos(':', s);
    if p = 0 then
        User := s
    else begin
        User := Copy(s, 1, p - 1);
        Pass := Copy(s, p + 1, Length(s));
    end;
end;



Function ExtractURLProtocol(Const sURL : String) : String;
begin
     result := substr(sUrl, 1, Pos(':', sURL))
end;


Function ExtractURLServer(Const sURL : String) : String;
var
   Protocol, user, pass, host, port, path : String;
begin
     ParseURL(sURL, Protocol, user, pass, host, port, path);
     result := Host;
end;

Function ExtractURLPort(Const sURL : String) : String;
var
   Protocol, user, pass, host, port, path : String;
begin
     ParseURL(sURL, Protocol, user, pass, host, port, path);
     result := Port;
end;

Function ExtractURLPath(Const sURL : String) : String;
var
   Protocol, user, pass, host, port, path : String;
begin
     ParseURL(sURL, Protocol, user, pass, host, port, path);
     Result := substr(path, 1, posn('/', path, -1)-1);
end;

function ExtractURLFilename(Const sURL : String) : String;
var
   Protocol, user, pass, host, port, path : String;
begin
     ParseURL(sURL, Protocol, user, pass, host, port, path);
     if pos('?', path)>0 then
        result := substr(path, posN('/', path, -1)+1, pos('?', path))
     else
        result := substr(path, posn('/', path, -1)+1, length(path));
end;

function ExtractURLParams(const SURL : String) : String;
var
   Protocol, user, pass, host, port, path : String;
begin
     ParseURL(sURL, Protocol, user, pass, host, port, path);
     Result := path;
end;


function Posn(const s , t : String; Count : Integer) : Integer;
var
    i, h, Last : Integer;
    u          : String;
begin
    u := t;
    if Count > 0 then begin
        Result := Length(t);
        for i := 1 to Count do begin
            h := Pos(s, u);
            if h > 0 then
                u := Copy(u, h + 1, Length(u))
            else begin
                u := '';
                Inc(Result);
            end;
        end;
        Result := Result - Length(u);
    end
    else if Count < 0 then begin
        Last := 0;
        for i := Length(t) downto 1 do begin
            u := Copy(t, i, Length(t));
            h := Pos(s, u);
            if (h <> 0) and ((h + i) <> Last) then begin
                Last := h + i - 1;
                Inc(count);
                if Count = 0 then
                    break;
            end;
        end;
        if Count = 0 then
            Result := Last
        else
            Result := 0;
    end
    else
        Result := 0;
end;


// Some System Functions here

// Returns a unique temporary filename
function GetTempFile(const Extension: string): string;
var
   Buffer: array[0..MAX_PATH] OF Char;
begin
     GetTempPath(Sizeof(Buffer)-1,Buffer);
     GetTempFileName(Buffer,'~',0,Buffer);
     result := StrPas(Buffer);
end;

// Returns the Temp Directory
Function myGetTempPath: String;
var
    nBufferLength : DWORD; // size, in characters, of the buffer
    lpBuffer      : PChar; // address of buffer for temp. path
begin
   nBufferLength := MAX_PATH + 1; // initialize
   GetMem( lpBuffer, nBufferLength );
   try
      if GetTempPath( nBufferLength, lpBuffer ) <> 0 then
         Result := StrPas( lpBuffer )
      else
         Result := '';
   finally
      FreeMem( lpBuffer );
   end;
end;



// Returns Current User Name

function myGetUserName : String;
var
   pcUser   : PChar;
   dwUSize : DWORD;
begin
   dwUSize := 21; // user name can be up to 20 characters
   GetMem( pcUser, dwUSize ); // allocate memory for the string
   try
      if Windows.GetUserName( pcUser, dwUSize ) then
         Result := pcUser
   finally
      FreeMem( pcUser ); // now free the memory allocated for the string
   end;
end;

// Returns Computer Name

function myGetComputerName : String;
var
   pcComputer : PChar;
   dwCSize    : DWORD;
begin
   dwCSize := MAX_COMPUTERNAME_LENGTH + 1;
   GetMem( pcComputer, dwCSize ); // allocate memory for the string
   try
      if Windows.GetComputerName( pcComputer, dwCSize ) then
         Result := pcComputer;
   finally
      FreeMem( pcComputer ); // now free the memory allocated for the string
   end;
end;

// Returns System Directory i.e. C:\windows\system

function myGetSystemDirectory : String;
var
   pcSystemDirectory : PChar;
   dwSDSize          : DWORD;
begin
   dwSDSize := MAX_PATH + 1;
   GetMem( pcSystemDirectory, dwSDSize ); // allocate memory for the string
   try
      if Windows.GetSystemDirectory( pcSystemDirectory, dwSDSize ) <> 0 then
         Result := pcSystemDirectory;
   finally
      FreeMem( pcSystemDirectory ); // now free the memory allocated for the string
   end;
end;

// Returns Windows Directory i.e. C:\windows

function myGetWindowsDirectory : String;
var
   pcWindowsDirectory : PChar;
   dwWDSize           : DWORD;
begin
   dwWDSize := MAX_PATH + 1;
   GetMem( pcWindowsDirectory, dwWDSize ); // allocate memory for the string
   try
      if Windows.GetWindowsDirectory( pcWindowsDirectory, dwWDSize ) <> 0 then
         Result := pcWindowsDirectory;
   finally
      FreeMem( pcWindowsDirectory ); // now free the memory allocated for the string
   end;
end;

// This funciton makes sure a filename contains no illegal illegible characters

function removeBadChar(const str: String) : String;
var
   badchar, rtn : String;
   a  : Integer;
begin
     badchar := '\/:*?"<>|';
     rtn := str;
     for a := 1 to length(BadChar) do
     begin
          while pos(badchar[a], rtn)>0 do
          begin
               delete(rtn, pos(badChar[a], rtn), 1);
          end;
     end;
     result := rtn;
end;


function DosToHTML(FName: string): string;
{convert an Dos style filename to one for HTML.  Does not add the file:///}
var
  Colon: integer;

  procedure Replace(Old, New: char);
  var
    I: integer;
  begin
  I := Pos(Old, FName);
  while I > 0 do
    begin
    FName[I] := New;
    I := Pos(Old, FName);
    end;
  end;

begin
Colon := Pos('://', FName);
Replace(':', '|');
Replace('\', '/');
if Colon > 0 then
  FName[Colon] := ':';   {return it to a colon}
Result := FName;
end;

{----------------GetBase}
function GetBase(const URL: string): string;
{Given an URL, get the base directory}
var
  I, J, LastSlash: integer;
  S: string;
begin
S := Trim(URL);
J := Pos('?', S);    
if J > 0 then
  S := Copy(S, 1, J-1);  {remove Query}
J := Pos('//', S);
LastSlash := 0;
for I := J+2 to Length(S) do
  if S[I] = '/' then LastSlash := I;
if LastSlash = 0 then
  Result := S+'/'
else Result := Copy(S, 1, LastSlash);
end;

{----------------Combine}
function Combine(Base, APath: string): string;
{combine a base and a path taking into account that overlap might exist}
{needs work for cases where directories might overlap}
var
  I, J, K: integer;

begin
J := Pos('://', Base);
if J > 0 then
  J := Pos('/', Copy(Base, J+3, Length(Base)-(J+2)))+J+2  {third slash}
else
  J := Pos('/', Base);
if J = 0 then
  begin
  Base := Base+'/';   {needs a slash}
  J := Length(Base);
  end
else if Base[Length(Base)] <> '/' then
  Base := Base + '/';

APath := Trim(APath);

if (APath <> '') and (APath[1] = '/') then
  begin    {remove path from base and use host only}
  if Pos('//', APath) = 1 then      {UNC filename}  
    Result := Copy(Base, 1, J) + APath
  else
    Result := Copy(Base, 1, J) + Copy(APath, 2, Length(APath)-1);
  end
else Result := Base+APath;

{remove any '..\'s to simply and standardize for cacheing}
I := Pos('/../', Result);
while I > 0 do
  begin
  if I > J then
    begin
    K := I;
    while (I > 1) and (Result[I-1] <> '/') do
      Dec(I);
    if I <= 1 then Break;
    Delete(Result, I, K-I+4);  {remove canceled directory and '/../'}
    end
  else
    Delete(Result, I+1, 3);    {remove '../' after host name}
  I := Pos('/../', Result);
  end;
{remove any './'s}
I := Pos('/./', Result);
while I > 0 do
  begin
  Delete(Result, I+1, 2);
  I := Pos('/./', Result);
  end;
end;

function Normalize(const URL: string): string;
{trim, and make sure a '/' terminates a hostname and http:// is present.
 In other words, if there is only 2 /'s, put one on the end}
var
  I, J, LastSlash: integer;
begin
Result := Trim(URL);
if Pos('://', Result) = 0 then
  Result := 'http://'+Result;       {add http protocol as a default}
J := Pos('/./', Result);
while J > 0 do
  begin
  Delete(Result, J+1, 2);  {remove './'s}
  J := Pos('/./', Result);
  end;
J := Pos('//', Result);
LastSlash := 0;
for I := J+2 to Length(Result) do
  if Result[I] = '/' then LastSlash := I;
if LastSlash = 0 then
  Result := Result+'/'
end;

function IsFullURL(Const URL: string): boolean;
var
  N:  integer;
begin
N := Pos('://', URL);
Result := ((N > 0) and (N < Pos('/', URL)) or (Pos('mailto:', Lowercase(URL)) <> 0));
end;

function GetProtocol(const URL: string): string;
var
  User, Pass, Port, Host, Path: String;
  S: string;
  I: integer;
begin
I := Pos('?', URL);
if I > 0 then S := Copy(URL, 1, I-1)
  else S := URL;
ParseURL(S, Result, user, pass, Host, port, Path);
Result := Lowercase(Result);
end;


function EncryptString(Const Str : String) : String;
var
   KeyStr : String;
   TMPStr, ts : String;
   acnt,bCNT, a ,b : Integer;
begin
     KeyStr := 'SomnuSoft Lilli';
     bcnt := Length(KeyStr);
     acnt := Length(str);
     ts := str;
     if acnt>1 then begin
        b := 1;
        for a := 1 to acnt do begin
            tmpstr :=  TmpStr + CHAR(ORD(TS[a]) + ORD(KeyStr[b]));
            b := succ(b);
            if b>=bcnt then b := 1;
        end;
     end;
     result := tmpStr;
end;

Function DecyphrString(Const Str : String) : String;
var
   KeyStr : String;
   TMPStr, ts : String;
   acnt,bCNT, a ,b : Integer;
begin
     KeyStr := 'SomnuSoft Lilli';
     bcnt := Length(KeyStr);
     acnt := Length(str);
     ts := str;
     if acnt>1 then begin
        b := 1;
        for a := 1 to acnt do begin
            tmpstr :=  TmpStr + CHAR(ORD(TS[a]) - ORD(KeyStr[b]));
            b := succ(b);
            if b>=bcnt then b := 1;
        end;
     end;
     result := tmpStr;
end;


function CheckFname(str : String) : String;
var
   badchar, rtn, path : String;
   a : Integer;
begin
     path := extractFilePath(str);
     if path<>'' then
          if path[length(path)] <> '\' then Path := Path + '\';
     badchar := '\/:*?"<>|{|}~#$%&()*§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿';
     rtn := extractfilename(str);
     for a := 1 to length(BadChar) do
     begin
          while pos(badchar[a], rtn)>0 do
          begin
               rtn[pos(badChar[a], rtn)] := '_';
          end;
     end;
     result := path + rtn;
end;

{  Call with the following to find out the current directory for it
           Desktop
           Personal
           Fonts
           History
           Recent
           Start Menu
           AppData
           Startup
           Favorites
           Cache
           Cookies
           My Pictures
           NetHood
}

Function ReturnSysDir(Const DirName : String) : String;
var
   reg : Tregistry;
begin
     result := '';
     reg := Tregistry.create;
     try
          reg.OpenKey('software\microsoft\windows\currentversion\explorer\Shell Folders', False);
          result := reg.ReadString(DirName)+'\';
     finally
          reg.free;
     end;
end;


function ReturnFileType(ftype : String) : String;
var
     tempstr : String;
     reg     : Tregistry;
begin
     result := ftype;
     reg := tregistry.create;
     try
        Reg.rootKey := HKEY_CLASSES_ROOT;
        if Reg.OpenKey(ftype, false) then begin
           TempStr := reg.readString('');
           Reg.CloseKey;
           if Reg.OpenKey(TempStr, False) then begin
              Result := reg.readString('');
           end else result := ftype;
        end else Result := ftype;
     finally
            reg.free;
     end;
end;

function Backslash(str : String) : String;
begin
        if str<>'' then
        begin
                if str[length(str)] <> '\' then str := str + '\';
                result := str;
        end;
end;

function UrlEncode(const DecodedStr: String; Pluses: Boolean): String;
var
  I: Integer;
begin
  Result := '';
  if Length(DecodedStr) > 0 then
    for I := 1 to Length(DecodedStr) do
    begin
      if not (DecodedStr[I] in ['0'..'9', 'a'..'z',
                                       'A'..'Z', ' ']) then
        Result := Result + '%' + IntToHex(Ord(DecodedStr[I]), 2)
      else if not (DecodedStr[I] = ' ') then
        Result := Result + DecodedStr[I]
      else
        begin
          if not Pluses then
            Result := Result + '%20'
          else
            Result := Result + '+';
        end;
    end;
end;

function UrlDecode(const EncodedStr: String): String;
var
  I: Integer;
begin
  Result := '';
  if Length(EncodedStr) > 0 then
  begin
    I := 1;
    while I <= Length(EncodedStr) do
    begin
      if EncodedStr[I] = '%' then
        begin
          Result := Result + Chr(HexToInt(EncodedStr[I+1]
                                       + EncodedStr[I+2]));
          I := Succ(Succ(I));
        end
      else if EncodedStr[I] = '+' then
        Result := Result + ' '
      else
        Result := Result + EncodedStr[I];

      I := Succ(I);
    end;
  end;
end;

function HexToInt(HexStr: String): Integer;
var RetVar : Integer;
    i : byte;
begin
  HexStr := UpperCase(HexStr);
  if HexStr[length(HexStr)] = 'H' then
     Delete(HexStr,length(HexStr),1);
  RetVar := 0;

  for i := 1 to length(HexStr) do begin
      RetVar := RetVar shl 4;
      if HexStr[i] in ['0'..'9'] then
         RetVar := RetVar + (byte(HexStr[i]) - 48)
      else
         if HexStr[i] in ['A'..'F'] then
            RetVar := RetVar + (byte(HexStr[i]) - 55)
         else begin
            Retvar := 0;
            break;
         end;
  end;

  Result := RetVar;
end;


end.
