unit uEncrypt;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils, blowfish, Base64;

function bf_Encrypt(str, password: string): string;
function bf_Decrypt(str, password: string): string;

implementation


function bf_Encrypt(str, password: string): string;
var
  bf : TBlowfishEncryptStream;
  s1, s2: TStringStream;
  st : String;
begin
  if (str<>'') then
  begin
    s1:=TStringStream.Create(str); //used as your source string
    try
       s2:=TStringStream.Create('');  //make sure destination stream is blank
       try
           bf:=TBlowfishEncryptStream.Create(password, s2);  //writes to destination stream
           try
              bf.copyfrom(s1, s1.size);
           finally
              bf.free;
           end;
           st := s2.datastring;
           result := EncodeStringBase64(st);
       finally
          s2.free;
       end;
    finally
       s1.free;
    end;
  end;
end;

function bf_Decrypt(str, password: string): string;
var
  bf : TBlowfishDecryptStream;
  s1, s2: TStringStream;
  st : String;
begin
    if (str<>'') then
    begin
      s1:=TStringStream.Create(DecodeStringBase64(str)); //used as your source string
      try
         s2:=TStringStream.Create('');  //make sure destination stream is blank
         try
               bf:=TBlowfishDecryptStream.Create(password, s1);  //reads from source stream
               try
                  s2.copyfrom(bf, s1.size); //to destination stream copy contents from bf to the size of source stream
               finally
                  bf.free;
               end;
               st := s2.DataString;
               result := st;
         finally
            s2.free;
         end;
      finally
         s1.free;
      end;
  end;
end;

end.

