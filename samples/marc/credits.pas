program credits;

uses easycrt, wintypes, winprocs;

const
  uparrow = 38;
  downarrow = 40;
  leftarrow = 37;
  rightarrow = 39;
  ctrl = 17;
  esc = 27;

var
  ctr:integer;
  hole:bmp;
  holem:bmp;
  homer:bmp;
  k:longint;
  lx:integer;
  ly:integer;
  piper:bmp;
  piperm:bmp;
  pxl:array[0..18,0..18] of TColorRef;
  x:integer;
  xctr:integer;
  y:integer;
  yctr:integer;

begin
  homer := loadbmp('c:\russ\scifair\samples\marc\homer.bmp');
  piper := loadbmp('c:\russ\scifair\samples\marc\piper.bmp');
  piperm := loadbmp('c:\russ\scifair\samples\marc\piperm.bmp');
  hole := loadbmp('c:\russ\scifair\samples\marc\hole.bmp');
  holem := loadbmp('c:\russ\scifair\samples\marc\holem.bmp');
  setbrush(color[0], 0);
  fill(10, 10, color[15], 1);
  setfont('Times New Roman', 40,0,0, 1,0,0);
  txt(0, 0, 1, color[-1], '');
  txt(320, 50, 3, color[4], 'Shoot Homer!!');
  
  for ctr := 500 downto 100 do
  begin
      drawbmp(233, ctr, homer, 0, 0, 0); 
  end;

  x := 50;
  y := 50;
  setbrush(color[-1], 0);
  repeat
    k := inkey;
    case k of
      uparrow: y := y - 5;
      downarrow: y := y + 5;
      leftarrow: x := x - 5;
      rightarrow: x := x + 5;
      ctrl: maskbmp(x-3, y-3, holem, hole, 0, 0, 0);
    end;

    if (lx <> x) or (ly <> y) or (k = ctrl) then
    begin
      if k <> ctrl then
      begin
        for xctr := 0 to 18 do
        begin                  
          for yctr := 0 to 18 do
          begin
            setpixel(dc, xctr + lx, yctr + ly, pxl[xctr, yctr]);
          end;
        end;
      end;

      for xctr := 0 to 18 do
      begin                  
        for yctr := 0 to 18 do
        begin
          pxl[xctr, yctr] := getpixel(dc, xctr + x, yctr + y);
        end;
      end;
      maskbmp(x, y, piperm, piper, 0, 0, 0);         
    end;
    lx := x;
    ly := y;

  until k = 27;

  donewincrt;
  deletebmp(homer);
  deletebmp(piper);
  deletebmp(piperm);
  deletebmp(hole);
  deletebmp(holem);
end.