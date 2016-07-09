
unit uStrTools;
{ string handling procedures for Pascal-style strings }

{$mode DELPHI}

interface
uses Classes,     { this unit defines TStringList         }
     SysUtils;    { this has str utils such as LowerCase  }

const
   TAB = #09;
   CR  = #13;
   LF  = #10;
   CRLF = CR + LF;
   SEPARATORS = [' ', '.', ',', '!', '?',';',':', '''', '"', '(', ')',
                 '[', ']', '{', '}', TAB, CR, LF ];
   LOWCHARS = ['a'..'z'];
   UPCHARS = ['A'..'Z'];

type
  TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);

type
   charSet = set of char;


   tokenindex = record
      tstart, tend : integer;
   end;

   tokenindexes = array[1..255] of tokenindex;

  // URL Handling
  function Posn(const s, t : String; count : Integer) : Integer;
  function removeBadChar(const str: String) : String;
  function removeBadChar2(const str: String) : String;
  procedure ParseURL(const URL : String; var Proto, User, Pass, Host, Port, Path : String);
  function GetBase(const URL: string): string; {Given an URL, get the base directory}
  function Combine(Base, APath: string): string; {combine a base and a path taking into account that overlap might exist}
  function Normalize(const URL: string): string; {lowercase, trim, and make sure a '/' terminates a hostname, adds http://}
  function IsFullURL(Const URL: string): boolean; {set if contains http://}
  function HexToInt(HexStr: String): Integer; // Taken from http://www.delphi3000.com/article.asp?id=1412
  function UrlEncode(const DecodedStr: String; Pluses: Boolean): String; // Encodes standard string into URL data format.
  function UrlDecode(const EncodedStr: String): String; // Decodes URL data into a readable string.
  Function ExtractURLProtocol(Const sURL : String) : String;
  Function ExtractURLServer(Const sURL : String) : String;
  Function ExtractURLPort(Const sURL : String) : String;
  Function ExtractURLPath(Const sURL : String) : String;
  function ExtractURLFilename(Const sURL : String) : String;
  Function ExtractURLParams(Const sURL : String) : String;
  function DosToHTML(FName: string): string;
  function SwitchPath(const urlpath : String) : String;   // Swith from url to DOS path name
  function StringReplace(const S, OldPattern, NewPattern: string; Flags: TReplaceFlags): string;
  function StringReplaceAll(const S, OldPattern, NewPattern: string): string;
  // General
  Function SubStr(Const Source: String; Const StartPos : Integer; Const EndPos : Integer) : String;
  function ReverseString( s : string ) : string;
  procedure Fill_StringList(var StrLst: TStringList; delimited_text: string; delimiter: Char);
  Function Soundex(OriginalWord: string): string; {Function to extract sound of a string}
  Function SoundAlike(Word1, Word2: string): boolean;{Function to determine if two strings sound alike}
  function LowCase( c : char ) : char; { return lowercase version of char c                }
  function ChangeCase( const s : string ) : string; { return toggled-case version of string s           }
  function InitialCaps( const s : string ) : string; { return string with initial chars capitalised      }
  function TitleCase( const s : string ) : string; { return string with initial caps, rest lowcase     }
  function SentenceCase( const s : string ) : string; { return string with capital initial, like sentence }
  function removeLeadChars( const s : string;  chars : charSet  ) : string; { trim chars from Left of String s                  }
  function removeTrailingChars( const s : string; chars : charSet ) : string; { trim chars from Right of String s                 }
  function trimLeftStr( const s : string ) : string; { remove leading SEPARATORS from string 's'          }
  function trimRightStr( const s : string ) : string; { remove trailing SEPARATORS from string 's'         }
  function trimEndsStr( const s : string ) : string; { trim SEPARATORS from both left and right of string }
  procedure firstrestStr( const s : string; var first, rest : string ); { parse s into 1st word first and remainder rest     }
  function encrypt( const s : string; cryptint : integer ) : string; { encrypt a string by doing maths using cryptint     }
  function decrypt( const s : string; cryptint : integer ) : string; { decrypt a string by doing maths using cryptint     }
  procedure parse( const s : string; slist : TStringList ); { parse string, s, into individual words in slist    }
  function countwords( const s : string ) : integer; { count tokens in string s                           }
  function TokenStart( const s : string; chars : charSet  ) : integer; { return index (1 based) of first token in s. Return 0 if s is empty }
  procedure firstTokenAt(  s : string; var tokstart, tokend : integer; var first, rest : string );{ Return first token in string s and its start and end indices. Also return rest of string. }
  procedure tokensFoundAt( s : string; var num: integer; var tindexes: tokenindexes ); { Return an array of tokenindex records Each record contains start and end index of a token }
  function StripChar(text: string; ch: char): string;
  procedure SetCommaText(sList: TStringList; const Value: string);
  function CommaThou(val : LongInt) : String;

(* // --- the following procedures are not public ---

procedure scrollthroughdelims( s : string; var i : integer );

procedure scrollthroughword( s : string; var w : string; var i : integer );

procedure firstTokenAtSIndex(   s : string;
                         var startindex, prevend : integer;
                         var first, rest : string );
*)


implementation

procedure scrollthroughdelims( s : string; var i : integer );
begin
   while (s[i] in SEPARATORS) and (i <= Length(s)) do i := i + 1;
end;

procedure scrollthroughword( s : string; var w : string; var i : integer );
begin
   w := '';
   while (not (s[i] in SEPARATORS)) and ( i <= Length(s)) do
   begin
      w := w + s[i];
      i := i + 1;
   end;
end;

function countwords( const s : string ) : integer;
var
   i, wordnum : integer;
   w : string;
begin
   i := 1;
   wordnum := 0;
   w := '';
      while ( i <= Length(s) ) do
      begin
         scrollthroughdelims( s, i );
         scrollthroughword( s, w, i );
         if (Length(w) > 0) then
            INC(wordnum);
      end;
   result := wordnum;
end;

function LowCase( c : char ) : char;
begin
  if (c in UPCHARS) then
     Result := Chr(Ord(c) + 32)
  else Result := c;
end;

function ChangeCase( const s : string ) : string;
{ changes all lowercase chars to uppercase and vice versa }
var
   i : integer;
   s2 : string;
begin
   s2 := '';
   for i := 1 to Length( s ) do
      if (s[i] in LOWCHARS) then
         s2 := s2 + UpCase( s[i] )
      else s2 := s2 + LowCase( s[i] );
   Result := s2;
end;


function CapitaliseWords( const s : string; titlecase : boolean ) : string ;
// Private function!
{ return string with initial chars capitalised. If titlecase is false,
  other chars are left as they are. If true, chars are set to lowercase.
  e.g. given s = 'This is MyStr'
       s = 'This Is MyStr' // titlecase is false
       s = 'This Is Mystr' // titlecase is true
       } 
var
   inputStr, outputStr, f, r : string;
begin
   inputStr := TrimEndsStr(s);
   outputStr := '';
     { loop through string, until there are no more words to be parsed }
   while inputStr <> '' do
   begin
     firstrestStr(inputStr, f, r );   { parse 1st word, f, from string }
     if titlecase then f := Lowercase(f);
     f[1] := UpCase(f[1]);            { capitalise initial char of f   }
     outputStr := outputStr + f;      { append f to output string      }
     inputStr := r;
     if inputStr <> '' then           { place spaces between the words }
        outputStr := outputStr + ' '; { we copy to the output string   }
   end;
   result := outputstr;
end;

function InitialCaps( const s : string ) : string ;
begin
   result := CapitaliseWords(s,false);
end;

function TitleCase( const s : string ) : string ;
begin
   result := CapitaliseWords(s,true);
end;

function SentenceCase( const s : string ) : string;
    { return string with capital initial, like sentence }
var
   outputStr : string;
begin
   if s <> '' then
   begin
      outputStr := LowerCase( s );
      outputStr[1] := UpCase(s[1]);
   end;
   result := outputStr;
end;


function TokenStart( const s : string; chars : charSet  ) : integer;
{ Find index (1 based) of first token in s. Return 0 if this is an empty string
  chars is a set of chars that separate tokens (e.g. whitespace, punctuation)
   TokenStart('.Hello', SEPARATORS );
 returns:
   2 // the index of the letter 'H'
 NOTE:
   returns 0 if no token is found
  }
var
   i : integer;
begin
   i := 1;
   if not (Length(s) = 0) then
   while (s[i] in chars) do
       inc(i);
   if i > Length(s) then { return 0 if s nothing but characters in chars set }
      Result := 0
   else
      Result := i;
end;

procedure firstTokenAtSIndex(   s : string;
                         var startindex, prevend : integer;
                         var first, rest : string );
{
  This is really just a wrapper around the firstTokenAt() function.
  The differencs is that it keeps track of the index of each
  token relative to the original input string.
  This procedure is PRIVATE!
}
var
  tokstart,tokend : integer;
begin
  tokstart := 0; tokend := 0;
  firstTokenAt( s, tokstart, tokend, first, rest);
  startindex := (prevend+tokstart)-1; // 0-index
  prevend := (prevend+tokend)-1;
end;

procedure tokensFoundAt( s : string;
                         var num: integer;
                         var tindexes: tokenindexes );
var
   first : string;
   te, ts : integer;
begin
   first := '';
   ts := 0;
   te := 1;
   num := 0;
   while (s <> '') do  // loop while there is more to process
   begin
     firstTokenAtSIndex( s, ts, te, first, s) ;
     if (te > ts) then   // only if a token has been parsed (end index, te
     begin               // is greater than start index, ts), inc num
          num := num + 1; // and fill a record with a pair of indexes
          tindexes[num].tstart := ts-1; // 0-indexed
          tindexes[num].tend := te-ts;
     end;
   end;
end;

procedure firstTokenAt(   s : string;
                         var tokstart, tokend : integer;
                         var first, rest : string );
{ Return first token in string s and its start and end indices.
  Also return rest of string.

  arguments
             INPUT                       OUTPUT
  s          a string
  tokstart                               index of 1st char of 1st token in s
  tokend                                 index of end of 1st token + 1 in s
  first                                  first token in s
  rest                                   remainder of s after 1st token

  NOTE: indexed from 1, not 0
        when no more tokens in s, sets first and rest to '', sets
        tokstart and tokend to 0.

  examples:
  //i

     s:= '!Hello, world!'
     firstTokenAt( s,tokstart,tokend,first,rest);

    returns:
     tokstart=2, tokend = 7, first='Hello' rest=', world!'

  //ii
   rest := !Hello, world!;
   first := '';
   tokstart := 1;
   tokend := 0;
   while (tokstart <> 0) do
     firstTokenAt( rest, tokstart, tokend, first, rest);

   returns (in succession):
    tokstart=2, tokend = 7, first=Hello, rest=, world!
    tokstart=3, tokend = 8, first=world, rest=!
  }
begin
  first := '';
  rest := '';
   tokstart := TokenStart( s, SEPARATORS );
   if tokstart = 0 then
      tokend := 0
   else
   begin
      tokend := tokstart;
       while not (s[tokend] in SEPARATORS) and not (tokend > Length( s ) ) do
          inc(tokend);
      first := copy( s, tokstart, tokend-tokstart );
      rest := copy(s, tokend, MAXINT );
   end;
end;


function removeLeadChars( const s : string;  chars : charSet  ) : string;
   { trims string 's' by removing chars in charSet 'chars'
   e.g. charSet might be [' ', '.' ]. So if s = ' .hello'
   this function would return: 'hello'.

   N.B. The Constant MAXINT is used to define the string
   length to the Copy function since, as Delphi Help states:
     "If Count specifies more characters than are available,
     the only the characters from S[Index] to the end of S are returned."
   MAXINT contains the largest possible Integer}
var
   i : integer;
begin
   i := 1;
   if not (Length(s) = 0) then
   while (s[i] in chars) do
       inc(i);
   Result := Copy( s, i, MAXINT );
end;

function removeTrailingChars( const s : string; chars : charSet ) : string;
var
   i : integer;
begin
   i := length(s);
       { count backward from end of characters found in charSet }
   if not (Length(s) = 0) then
   while (s[i] in chars) and (i <> 0 ) do
       dec(i);
       { then return a copy of the string minus the unwanted trailing chars }
   Result := copy(s, 1, i);
end;


function trimLeftStr( const s : string ) : string;
{ remove leading separators from string 's' }
begin
   trimLeftStr := removeLeadChars( s, SEPARATORS );
end;

function trimRightStr( const s : string ) : string;
{ remove trailing separators from string 's' }
begin
   trimRightStr := removeTrailingChars( s, SEPARATORS );
end;

function trimEndsStr( const s : string ) : string;
{ trim separators from both left and right of string }
begin
   trimEndsStr := trimLeftStr(trimRightStr(s));
end;

procedure firstrestStr( const s : string; var first, rest : string );
{ Given a string, 's', parse out the first word as 'first' and
  leave the remainder of the string untouched as 'rest' }
var
   i : integer;
   s2 : string;
begin
   i := 1;
   first := '';
   rest := '';
   s2 := trimLeftStr( s );
   if not (Length(s2) = 0) then
   while not (s2[i] in SEPARATORS) and not (i > Length( s2 ) ) do
       inc(i);
   first := copy( s2, 1, i-1 );
   rest := copy(s2, i, MAXINT );
end;

function encrypt( const s : string; cryptint : integer ) : string;
var
   i : integer;
   s2 : string;
begin
  s2 := '';
  if not ( Length(s) = 0 ) then
  for i := 1 to Length( s ) do
    s2 := s2 + Chr(Ord( s[i] ) + cryptint );
  Result := s2;
end;

function decrypt( const s : string; cryptint : integer ) : string;
var
   i : integer;
   s2 : string;
begin
  s2 := '';
  if not ( Length(s) = 0 ) then
  for i := 1 to Length( s ) do
     s2 := s2 + Chr(Ord( s[i] ) - cryptint );
  Result := s2;
end;

procedure parse( const s : string; slist : TStringList );
{ parse s into a series of tokens (e.g. individual words) and
  return these in slist.

  IMPORTANT: It is the responsibility of the calling
  code to create a valid TStringList object and to free
  it upon completion! }
var
   s2, f, r : string;
begin
   s2 := TrimEndsStr(s);
     { loop through string, until there are no more words to be parsed }
   while s2 <> '' do
   begin
     firstrestStr(s2, f, r );   { parse 1st word, f, from string }
     slist.Add(trim(f));
     s2 := r;
   end;
end;

Function Soundex(OriginalWord: string): string;
var
  Tempstring1, Tempstring2: string;
  Count: integer;
begin
  Tempstring1 := '';
  Tempstring2 := '';
  OriginalWord := Uppercase(OriginalWord); {Make original word uppercase}
  Appendstr(Tempstring1, OriginalWord[1]); {Use the first letter of the word}
  for Count := 2 to length(OriginalWord) do
    {Assign a numeric value to each letter, except the first}

    case OriginalWord[Count] of
      'B','F','P','V': Appendstr(Tempstring1, '1');
      'C','G','J','K','Q','S','X','Z': Appendstr(Tempstring1, '2');
      'D','T': Appendstr(Tempstring1, '3');
      'L': Appendstr(Tempstring1, '4');
      'M','N': Appendstr(Tempstring1, '5');
      'R': Appendstr(Tempstring1, '6');
      {All other letters, punctuation and numbers are ignored}
    end;
  Appendstr(Tempstring2, OriginalWord[1]);
  {Go through the result removing any consecutive duplicate numeric values.}

  for Count:=2 to length(Tempstring1) do
    if Tempstring1[Count-1]<>Tempstring1[Count] then
        Appendstr(Tempstring2,Tempstring1[Count]);
  Soundex:=Tempstring2; {This is the soundex value}
end;


Function SoundAlike(Word1, Word2: string): boolean;
begin
  if (Word1 = '') and (Word2 = '') then result := True
  else
  if (Word1 = '') or (Word2 = '') then result := False
  else
  if (Soundex(Word1) = Soundex(Word2)) then result := True
  else result := False;
end;

function SwitchPath(const urlpath : String) : String;
var
   path : String;
begin
     PAth := URLPath;
     path := stringReplace(Path, '/', '\', [rfReplaceAll, rfIgnoreCase]);
     result := Path;
end;

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

function StringReplace(const S, OldPattern, NewPattern: string; Flags: TReplaceFlags): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  SearchStr := AnsiUpperCase(S);
  Patt := AnsiUpperCase(OldPattern);
  NewStr := S;
  Result := '';
  while SearchStr <> '' do begin
    Offset := Pos(Patt, SearchStr);
    if Offset = 0 then begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

function StringReplaceAll(const S, OldPattern, NewPattern: string): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
  Flags: TReplaceFlags;
begin
  flags := [rfReplaceAll];
  SearchStr := AnsiUpperCase(S);
  Patt := AnsiUpperCase(OldPattern);
  NewStr := S;
  Result := '';
  while SearchStr <> '' do begin
    Offset := Pos(Patt, SearchStr);
    if Offset = 0 then begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;


Function SubStr(Const Source: String; Const StartPos : Integer; Const EndPos : Integer) : String;
var
   RetStr : String;
   i : integer;
begin
    For i := StartPos to EndPos do retstr := RetStr + Source[i];
    //Return Result without leading of trainling spaces.
    Result := Trim(RetStr);
End;

function removeBadChar(const str: String) : String;
var
   badchar, rtn : String;
   a  : Integer;
begin
     badchar := '*?"<>|{|}~€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›:œžŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ!"#$%&''()*+,-';
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

function removeBadChar2(const str: String) : String;
var
   badchar, rtn : String;
   a  : Integer;
begin
     badchar := '  *?"<>|{|}~!"#$%&''()*+,-[]{}.1234567890:;/\<>' + #9 + #10 + #13;
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

function ReverseString( s : string ) : string;
var
  i  : integer;
  s2 : string;
begin
  s2 := '';
  for i := 1 to Length( s ) do
  begin
    s2 := s[ i ] + s2;
  end;

  Result := s2;
end;

procedure Fill_StringList(var StrLst: TStringList; delimited_text: string; delimiter: Char);
{
  Takes a StringList, some delimited text and a delimiter and
  fills the string list from the text with items separated by
  delimiter
}
var
    Work: string;
    del_pos: integer;

begin
    If Length(delimited_text)=0 then begin
        // showmessage('Fill_StringList : delimited_text length 0!');
        exit;
    end;

    Work := delimited_text;
    StrLst.Clear;
    
    repeat
        del_pos := Pos(delimiter, Work);
        If (del_pos = 0) Then begin
            If Length(Work)>0 Then StrLst.Add(Work);
            exit;
        end else
            StrLst.Add(Copy(Work, 1, del_pos - 1));
        {Make work shorter}
        Work := Copy(Work, del_pos + 1, Length(Work) - del_pos);
    until del_pos = 0;
end;    {Fill_StringList}

procedure SetCommaText(sList: TStringList; const Value: string);
{
  Miles of snaffled, inscrutable, uncommented VCL code, which
  takes a double-quoted, comma-delimited line (value) and creates
  a stringlist out of the individual values.
  e.g.
    "Hello, you",1,3 ->
    Hello, you
    1
    3
  (Bugfixed by Scooby)
}
var
  P, P1, P2: PChar;
  S: string;
  Text: array[0..4095] of Char;
begin
  sList.Clear;
  StrLCopy(Text, PChar(Value), SizeOf(Text) - 1);
  P := Text;
  while (P^ <> #0) and (P^ <= ' ') do Inc(P);
  if P^ <> #0 then
    while True do begin
      P1 := P;
      if P^ = '"' then begin
        P2 := P;
        Inc(P);
        while P^ <> #0 do begin
          if P^ = '"' then begin
            Inc(P);
            if P^ <> '"' then Break;
          end;
          P2^ := P^;
          Inc(P2);
          Inc(P);
        end;
      end else begin
        while (P^ >= ' ') and (P^ <> ',') do Inc(P);
        P2 := P;
      end;
      SetString(S, P1, P2 - P1);
      sList.Add(S);
      while (P^ <> #0) and (P^ <= ' ') do Inc(P);
      if P^ = #0 then Break;
      if P^ = ',' then begin
        Inc(P);
        while (P^ <> #0) and (P^ <= ' ') do Inc(P);
      end;
    end;
end;


function StripChar(text: string; ch: char): string;
{
  Strip a given character from a string
}
var
  i, j : integer;
begin
  result := text;
  j := 1;
  for i := 1 to length(text) do begin
    if not(text[i] = ch) then begin
      result[j] := text[i];
      inc(j);
    end;
  end;
  { Truncate result to real length }
  result := copy(result, 1, j - 1);
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

function CommaThou(val : LongInt) : String;
var
        str, res : String;
        a, b : Integer;
begin
        str := IntToStr(Val);
        b := 0;
        if Length(str)>3 then
        begin
                for a := length(str) downto 1 do
                begin
                        b := succ(b);
                        if b=3 then
                        begin
                                res := ',' + str[a] + res;
                                b := 0;
                        end else res := str[a] + res;
                end;
        end else res := str;
        if res[1] = ',' then delete(res, 1, 1);
        result := res;
end;





// EOF
end.
