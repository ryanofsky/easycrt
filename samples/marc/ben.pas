program soundtest;

uses easycrt;

var
  a:integer;
  dir:integer;
  k:integer;
  l:integer;
  m:integer;
  n:integer;
  x:integer;
  y:integer;

begin
    x := 0;
    y := 0;
    setfont('Times New Roman',20,0,0,0,0,0);
    setbrush(rgb(0,0,0), 0);
    fill(10, 10, color[15], 1);

    dir := 1;
    k:=1;
    l:=0;
    repeat 
      if dir = 1 then x := x + 1;
      if dir = 2 then y := y + 1;
      if dir = 3 then x := x - 1;
      if dir = 4 then y := y - 1;
      if (dir = 1) and (x = 640) then dir := 2;
      if (dir = 2) and (y = 480) then dir := 3;
      if (dir = 3) and (x = 0) then dir := 4;
      if (dir = 4) and (y = 0) then dir := 1; 
      if m>=100 then n:=-1;
      if m<=0 then n:=1;        
      m:=n+m;
      if l>=100 then k:=0;
      if l<=0 then k:=1;        
      l:=l+k;
      setpen(gradient(rgb(255, 0, 0), rgb(0, 0, 0), m, 101), 0, 2);
      qline(320, 210, x, y);
      txt(320,120,3,gradient(color[0],color[15],l,101),'THANK YOU FOR WATCHING');
      txt(320,155,3,gradient(color[0],color[15],l,101),'Ben and Matt''s');
      txt(320,185,3,gradient(color[0],color[15],l,101),'Latin Project');
      txt(320,215,3,gradient(color[0],color[15],l,101),'on');
      txt(320,245,3,gradient(color[0],color[15],l,101),'"ROMAN NAVAL ACTIVITIES"');
      txt(320,275,3,gradient(color[0],color[15],l,101),'HAVE A NICE DAY');
    until keypressed;
    readkey;

  donewincrt;
end.

