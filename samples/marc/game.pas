program gamjkle;

uses easycrt;

procedure introduction;
var
  cool:array[1..8] of bmp;
  ctr:integer;
  ctra:integer;
  ctrb:integer;
  ctrc:integer;
  ctrd:integer;
  filename:string;
  k:integer;
  l:integer;
  mcool:array[1..8] of bmp;
  sctr:string;
  t:integer;

begin
  for ctr := 1 to 8 do
  begin
    str(ctr, sctr);
    filename := concat('c:\russ\scifair\samples\marc\cool', sctr, '.bmp');
    cool[ctr] := loadbmp(filename);
  end;

  {setbrush(color[0], 0);
  fill(0, 0, color[15], 1);}

  for ctr := 400 downto 0 do
  begin
    setpen(gradient(color[0], color[9], ctr div 4, 100), 0, 2);
    qcircle(320, 240, ctr, ctr);
  end;

    setfont('Times New Roman',40,0,0,0,0,0);
    t := -1;
    k:=1;
    l:=0;
    repeat 
      if l>=100 then k := -1;
      if l<=0 then
      begin
        k:=1;
        t := t + 1;
      end;
      l:=l+k;
      txt(320, 210,3,gradient(color[0],color[15],l,101),'Marc Huffnagle');
      delay(10);
    until t = 1;

    t := -1;
    k:=1;
    l:=0;
    repeat 
      if l>=100 then k := -1;
      if l<=0 then
      begin
        t := t + 1;
        k:=1;
      end;
      l:=l+k;
      txt(320, 210,3,gradient(color[0],color[15],l,101),'Proudly');
      delay(10);
    until t = 1;

    t := -1;
    k:=1;
    l:=0;
    repeat 
      if l>=100 then k := -1;
      if l<=0 then
      begin
        t := t + 1;
        k:=1;
      end;
      l:=l+k;
      txt(320, 210,3,gradient(color[0],color[15],l,101),'Presents');
      delay(10);
    until t = 1;

    t := -1;
    k:=1;
    l:=0;
    repeat 
      if l>=100 then k := -1;
      if l<=0 then
      begin
        t := t + 1;
        k:=1;
      end;
      l:=l+k;
      txt(320, 210,3,gradient(color[0],color[15],l,101),'his');
      delay(10);
    until t = 1;

    t := -1;
    k:=1;
    l:=0;
    repeat
      if l>=100 then k := -1;
      if l<=0 then
      begin
        t := t + 1;
        k:=1;
      end;
      l:=l+k;
      txt(320, 210,3,gradient(color[0],color[15],l,101),'INTRODUCTION!!');
      delay(20);
    until t = 1;

    t := -1;
    l := 0;
    repeat
      l:=l+1;
      txt(320, 130,3,gradient(color[0],color[15],l,101),'Marc Huffnagle');
      txt(320, 170,3,gradient(color[0],color[15],l,101),'Proudly');
      txt(320, 210,3,gradient(color[0],color[15],l,101),'Presents');
      txt(320, 250,3,gradient(color[0],color[15],l,101),'his');
      txt(320, 290,3,gradient(color[0],color[15],l,101),'INTRODUCTION!!');
      delay(10);
    until l = 100;

  setpen(color[15], 0, 1);
  qcircle(500, 120, 22, 22);
  qcircle(140, 120, 22, 22);
  qcircle(500, 345, 22, 22);
  qcircle(140, 345, 22, 22);
  setbrush(color[15], 0);
  fill(500, 100, 0, 1);
  fill(100, 100, 0, 1);
  fill(500, 345, 0, 1);
  fill(140, 345, 0, 1);
  
  ctra := 0;
  ctrb := 1;
  ctrc := 2;
  ctrd := 3;
  setbrush(color[-1], 0);
  repeat
    k := inkey;
    delay(100);
    ctra := ctra  + 1;
    ctrb := ctrb  + 1;
    ctrc := ctrc  + 1;
    ctrd := ctrd  + 1;
    if ctra = 9 then ctra := 1;
    if ctrb = 9 then ctrb := 1;
    if ctrc = 9 then ctrc := 1;
    if ctrd = 9 then ctrd := 1;
    drawbmp(484, 329, cool[ctra], 0, 0, 0);
    drawbmp(124, 329, cool[ctrb], 0, 0, 0);
    drawbmp(484, 104, cool[ctrc], 0, 0, 0);
    drawbmp(124, 104, cool[ctrd], 0, 0, 0);
  until k <> 0;

  for ctr := 1 to 8 do
  begin
    str(ctr, sctr);
    filename := concat('c:\russ\scifair\samples\marc\cool', sctr, '.bmp');
    deletebmp(cool[ctr]);
  end;
donewincrt;
end;

procedure Menu;
begin

end;

procedure Game;
begin

end;

begin
  Introduction;
  initwincrt;
  Menu;
end.

