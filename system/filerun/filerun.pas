(*{$R file.res}*)

uses winprocs,strings,wintypes,wincrt;


function FileExists(FileName: string): Boolean;
var
  F: file;
begin
  {$I-}
  Assign(F, FileName);
  Reset(F);
  Close(F);
  {$I+}
  FileExists := (IOResult = 0) and (FileName <> '');
end;

function pc(var s: string): pchar;
  begin
    s[length(s)+1] := char(0);
    pc := @s[1];
  end;  

function lowercase(s:string):string;
  begin
    strlower(pc(s));
    lowercase := s;
  end;

procedure sendchar(window:hwnd; c:char);
  var vkcode:byte;
      shifts:boolean;
  begin
    vkcode := lobyte(VkKeyScan(ord(c)));
    shifts := (hibyte(VkKeyScan(ord(c)))=1);

    if (shifts) then 
    sendmessage(window,wm_keydown,vk_shift,MapVirtualKey(VK_SHIFT,0));

    sendmessage(window,wm_keydown,vkcode  ,MapVirtualKey(vkcode,0));
    sendmessage(window,wm_keyup  ,vkcode  ,MapVirtualKey(vkcode,0));

    if shifts then 
    sendmessage(window,wm_keyup,vk_shift,MapVirtualKey(VK_SHIFT,0));
  end;

function getedit(open:hwnd):hwnd;
  var p:tpoint;
      r:trect;
  begin

    getclientrect(open,r);
    p.x := r.left +101+3;
    p.y := r.top  +23+3;
    getedit := WindowFromPoint(p);

  end;

var commandline,path1,path2:string;
    fhandle: text;
    instance:word;
    mainw,activew,editw:hwnd;
    i:integer;
    msg:tmsg;
          
begin
  commandline := StrPas(cmdline);
  if fileexists(commandline) then
    begin
      assign(fhandle,commandline);
      reset(fhandle);
      if not eof(fhandle) then
        begin
          readln(fhandle,path1);
(*        if (lowercase(copy(path1,length(path1)-2,3))='pas') and not eof(fhandle) then
            begin
              readln(fhandle,path2);
              instance:=winexec(pc(path2),sw_show);
              mainw := findwindow('tpframe',nil);
              postmessage(mainw,wm_command,1002,0);
              peekmessage(msg,0,0,0,PM_NOREMOVE);
              activew := findwindow('BorDlg',nil{'File Open'});
              editw  := Getedit(activew);
              editw := mainw;
              for i := 1 to length(path1) do
                begin
                  sendchar(editw,path1[i]);
                end;
              sendchar(editw,char(13));
              writeln(mainw,',',activew,',',editw);

            end
          else *)
            WinExec(pc(path1),SW_SHOW);
        end;
      close(fhandle);
    end;
end.