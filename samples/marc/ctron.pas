program Tron;

uses easycrt;

var
  bdir:integer;
  bx:integer;
  by:integer;
  Cdir:integer;
  Cx:integer;
  Cy:integer;
  ctr:integer;
  k:integer;
  OCDir:integer;
  r:integer;
  s:integer;
  score:integer;
  sctr:integer;
  tempstring:string;

procedure SelectComputerDirection;
begin
  OCdir := Cdir;
  r := random(1);
  repeat
    if r = 0 then Cdir := cdir + 2;
    if r = 1 then Cdir := cdir - 2;
    if Cdir = 10 then Cdir := 2; 
    if CDir = 0 then Cdir := 10;
    if Cdir = OCDir then k := Esc;

    case cDir of
      4: if pixel(cx-s, by) = color[0] then OCDir := Cdir;
      8: if pixel(cx, cy-s) = color[0] then OCDir := Cdir;
      6: if pixel(cx+s, cy) = color[0] then OCDir := Cdir;
      2: if pixel(cx, cy+s) = color[0] then OCDir := Cdir;
    end;
        
  until Cdir = OCDir;
end;

begin
  randomize;
  s := 1;
  score := 0;
  bx := 325;
  by := 240;
  BDir := 6;
  CDir := 4;
  Cx := 315;
  Cy := 240;

  setbrush(color[0], 0);
  box(0,0,640, 480, 0, 0);
  setpen(color[14], 0, 1);
  box(10, 10, 600, 400, 0, 0);
  setbrush(color[-1], 0);

  repeat
    sctr := sctr + 1;
    if sctr = 50 then
    begin
      setpen(rgb(random(156)+100, random(156)+100, random(156)+100), 0, 2);
      {pset(random(640), random(480), rgb(random(256), random(256), random(256)));}
      setbrush(rgb(random(256), random(256), random(256)), 0);
      qcircle(random(640), random(480), random(50), random(50));
      {qline(10+score, 10+score, 10 + score, 500 - score);
      qline(10 + score, 500 - score, 500 - score, 500 - score);
      qline(500 - score, 500 - score, 500 - score, 10 + score);
      qline(500 - score, 10 + score, 10 + score, 10 + score);}
      sctr := 0;
      score := score + 1;
    end;

    for ctr := 1 to 2 do
    begin
      k := inkey;
      case k of
        Up: bDir := 8;
        Down: bDir := 2;
        Left: bDir := 4;
        Right: bDir := 6;
      end;
    end;
    case bDir of
      8: if pixel(bx, by-s) <> color[0] then k := Esc;
      2: if pixel(bx, by+s) <> color[0] then k := Esc;
      4: if pixel(bx-s, by) <> color[0] then k := Esc;
      6: if pixel(bx+s, by) <> color[0] then k := Esc;
    end;

    case bDir of
      8: by := by - s;
      2: by := by + s;
      4: bx := bx - s;
      6: bx := bx + s;
    end;

    {Computer Play}

    case cDir of
      4: if pixel(cx-s, by) <> color[0] then SelectComputerDirection;
      8: if pixel(cx, cy-s) <> color[0] then SelectComputerDirection;
      6: if pixel(cx+s, cy) <> color[0] then SelectComputerDirection;
      2: if pixel(cx, cy+s) <> color[0] then SelectComputerDirection;
    end;

    case cDir of
      8: cy := cy - s;
      2: cy := cy + s;
      4: cx := cx - s;
      6: cx := cx + s;
    end;

    pset(bx, by, rgb(0, 0, 255));
    pset(cx, cy, rgb(255, 0, 0));
    delay(10);
  until k = Esc;
end.