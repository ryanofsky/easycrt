program namehere;
uses easycrt;

var x,y,xx,yy: integer;
    c:word;

begin

x:=40;
y:=15;

repeat
c:=inkey;

case c of
  37: {left}  begin xx:=-1;  yy:=0; end;
  38: {up}    begin xx:=0;  yy:=-1; end;
  39: {right} begin xx:=1;  yy:=0; end;
  40: {down}  begin xx:=0;  yy:=1; end;
end;
x:=x+2*xx;
y:=y+yy;
gotoxy(x,y); write('X');
if y<1 then y:=30;
if y>29 then y:=1;
if x<1 then x:=78;
if x>78 then x:=1;
delay(100);
gotoxy(x,y); write(' ');
until c=27;
donewincrt;
end.