uses easycrt, wintypes;

type tplusguy = object
       x,y,xx,yy: integer;
       procedure init;
       procedure goUP;
       procedure goDOWN;
       procedure goLEFT;
       procedure goRIGHT;
       procedure stop;
       procedure draw;
     end;

procedure tplusguy.init;
  begin
    x  := 40;
    y  := 15;
    xx := 0;
    yy := 0;
  end;

procedure tplusguy.goUP;
  begin
    xx := 0; yy := -1;
  end;

procedure tplusguy.goDOWN;
  begin
    xx := 0; yy := 1;
  end;

procedure tplusguy.goRIGHT;
  begin
    xx := 1; yy := 0;
  end;

procedure tplusguy.goLEFT;
  begin
    xx := -1; yy := 0;
  end;

procedure tplusguy.stop;
  begin
    xx := 0; yy := 0;
  end;

procedure tplusguy.draw;
  begin
    gotoxy(x,y); write(' ');
    x := x + xx;    y:= y + yy;
    x := (x+79) mod 79;  y:= (y+30) mod 30;
    gotoxy(x,y); write('+');
  end;



var  plusguy: tplusguy;
     i: word;

begin
  plusguy.init;
  repeat
    i := 0;
    i := inkey;
    case i of
      vk_down: plusguy.goDOWN;
      vk_up: plusguy.goUP;
      vk_left: plusguy.goLEFT;
      vk_right: plusguy.goRIGHT;
      vk_control: plusguy.stop;
    end;
    plusguy.draw;
    unfreeze;
    delay(100);
  until (i = vk_escape) or ldown or rdown or (i=13);
  donewincrt;
end.





