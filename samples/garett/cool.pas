uses easycrt3, winprocs;
var b:integer;
t:longint;
z:bmp;
begin
    setpen(0,0,1);
    for b:=1 to 640 do
        qline(b,0,b,480);
    {146,46}
    z:=loadbmp('c:\tpw\adven\cool.bmp');
    for b:=300 downto 1 do
        drawbmp(b,trunc(200-(b/320*240)),z,1,321-b,trunc(241-(b/240*320)));
    deletebmp(z);
    z:=loadbmp('c:\tpw\adven\cool2.bmp');
    for b:=320 downto 1 do
        drawbmp(b+320,trunc(200-(b/320*240)),z,1,321-b,trunc(241-(b/240*320)));
    deletebmp(z);
    t:=0;
    repeat
    t:=t+1;
    until (t=100000) or (inkey<>0);
end.