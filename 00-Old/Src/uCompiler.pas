unit uCompiler;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Mask, JvToolEdit, JvExMask, ExtCtrls, shellapi, madRes;

type
  TfrmCompiler = class(TForm)
    Label2: TLabel;
    Button1: TButton;
    feOutput: TJvFilenameEdit;
    Label1: TLabel;
    feScript: TJvFilenameEdit;
    imgIcon: TImage;
    feIcon: TJvFilenameEdit;
    chkChangeIcon: TCheckBox;
    Button2: TButton;
    chkUPX: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure feScriptAfterDialog(Sender: TObject; var AName: String;
      var AAction: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure feIconAfterDialog(Sender: TObject; var AName: String;
      var AAction: Boolean);
  private
    { Private declarations }
  function WinExecAndWait32(FileName:String; Visibility : integer):Cardinal;
  public
    { Public declarations }
  end;

var
  frmCompiler: TfrmCompiler;

implementation

{$R *.DFM}

procedure TfrmCompiler.Button1Click(Sender: TObject);
var
        instrm, outstrm : TFilestream;
        fname, upx : String;
        h : Dword;
begin
        fname := extractFilePath(ParamStr(0));
        if fname[length(fname)] <> '\' then fname := fname + '\';
        upx := fname + 'upx\upx.exe';
        fname := fname + 'DLRun.exe';
        if fileexists(feOutput.filename) then deleteFile(feOutput.filename);
        // Copy the file
        if copyfile(pchar(fname), pchar(feOutput.filename), false) then
        begin
                if chkChangeIcon.checked then
                begin
                        h := BeginUpdateResourceW(PWideChar(WideString(feOutput.filename)), false);
                        try
                                // Remove the old Icon
                                DeleteIconGroupResourceW(h, '1', 2057);
                                // Put in the new one.  I got the language from the resource tool Restheif.
                                // It actually does remove the old one now.
                                if not LoadIconGroupResourceW(h, '0', 2057, PWideChar(WideString(feIcon.filename))) then
                                        application.messageBox('Unable to Change Icon', 'De-Lite', 0);
                        finally
                                EndUpdateResourceW(h, false);
                        end;
                end;
        end;
        // Perhaps add some packing option here before the script is added?
        // try it here.
        if chkUPX.checked then WinExecAndWait32(upx + ' --compress-icons=0 "' + feoutput.filename + '"', SW_SHOW);
        // Now copy the script across.
        outStrm := TFilestream.create(feOutput.filename, fmOpenwrite);
        try
                instrm := TFilestream.create(feScript.filename, fmOpenRead or fmShareDenyNone);
                try
                        instrm.seek(0,0);
                        outstrm.seek(0, soFromEnd);
                        OutStrm.CopyFrom(instrm, instrm.size);
                finally
                        instrm.free;
                end;
        finally
                OutStrm.free;
        end;
        application.messageBox('Bound Script To Runtime', 'De-Lite', 0);
end;

procedure TfrmCompiler.feScriptAfterDialog(Sender: TObject;
  var AName: String; var AAction: Boolean);
begin
        if AAction then feOutput.filename := changeFileExt(AName, '.exe');
end;


procedure TfrmCompiler.Button2Click(Sender: TObject);
begin
        close;
end;

procedure TfrmCompiler.feIconAfterDialog(Sender: TObject;
  var AName: String; var AAction: Boolean);
begin
        if Aaction then
        begin
                chkChangeIcon.checked := true;
                imgIcon.Picture.Graphic.LoadFromFile(Aname);
        end;
end;

function TfrmCompiler.WinExecAndWait32(FileName:String; Visibility : integer):Cardinal;
var
    zAppName:array[0..512] of char;
    zCurDir:array[0..255] of char;
    WorkDir:String;
    StartupInfo:TStartupInfo;
    ProcessInfo:TProcessInformation;
    hprocess : cardinal;

begin
    StrPCopy(zAppName,FileName);
    GetDir(0,WorkDir);
    StrPCopy(zCurDir,WorkDir);
    FillChar(StartupInfo,Sizeof(StartupInfo),#0);
    StartupInfo.cb := Sizeof(StartupInfo);
    StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartupInfo.wShowWindow := Visibility;
    if not CreateProcess(nil,
      zAppName,                      { pointer to command line string }
      nil,                           { pointer to process security attributes}
      nil,                           { pointer to thread security attributes }
      false,                         { handle inheritance flag }
      CREATE_NEW_CONSOLE or          { creation flags }
      NORMAL_PRIORITY_CLASS,
      nil,                           { pointer to new environment block }
      nil,                           { pointer to current directory name }
      StartupInfo,                   { pointer to STARTUPINFO }
      ProcessInfo) then Result := 0 { pointer to PROCESS_INF }
    else
       begin
       hprocess := processInfo.hProcess;
       WaitforSingleObject(ProcessInfo.hProcess,INFINITE);
       GetExitCodeProcess(ProcessInfo.hProcess,Result);
       end;
  end;

end.
