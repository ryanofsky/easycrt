uses easycrt,easygdi;

var crosshair,crosshairm,homer,background:bmp;
    i,x,y,cwidth,cheight,r,shots:integer;
    changed: boolean;
    m,n: string;

begin

initwincrt;
settitle('Shoot Homer! (mouse click to exit)');
setborder(scrollbar,0);



setbrush(CRT,color[0],color[0],solid);
box(CRT,0,0,getwidth(CRT),getheight(CRT),0,0);



homer := loadbmp(appdir + '\homer.bmp');

x := (getwidth(crt)-getwidth(homer)) div 2;
for i := 1 to 200 do
  begin
    y := getheight(crt) - (i * getheight(homer)) div 100;
    copybmp(homer,crt,x,y);
   end;

killbmp(homer);

crosshair  := loadbmp(appdir + '\crossh.bmp');
crosshairm := loadbmp(appdir + '\crosshm.bmp');
cwidth     := getwidth(crosshair);
cheight    := getheight(crosshair);

background := makeblankbmp(CRT,cwidth,cheight);

x := getwidth(crt) div 2;
y := getheight(crt) div 2;

resetkeys;
shots := 0;
changed := true;
quickfont(thefont,stencil,100);
thefont.fcolor := color[15];
thefont.bgcolor := color[0];
thefont.halign := ta_center;
str(shots,m);
print(CRT,getwidth(crt) div 2,10,m);




repeat
  i := inkey;

  case i of
  vk_up:    begin copybmp(background,crt,x,y); dec(y); changed := true; end;
  vk_down:  begin copybmp(background,crt,x,y); inc(y); changed := true; end;
  vk_left:  begin copybmp(background,crt,x,y); dec(x); changed := true; end;
  vk_right: begin copybmp(background,crt,x,y); inc(x); changed := true; end;
  0:        begin end;
  else
    begin
      copybmp(background,crt,x,y);
      changed := true;
      setpen(crt,color[4],solid,5);
      setbrush(CRT,color[0],color[0],solid);
      r := random(10)+5;
      circle(crt,x+cwidth div 2,y+cwidth div 2,r,r);
      inc(shots);
      str(shots,m);
      print(CRT,getwidth(crt) div 2,10,m);
    end;
  end;

  if changed then
    begin
      changed := false;
      piececopy(CRT,background,x,y,cwidth,cheight,0,0);
      maskcopy(crosshair,crosshairm,crt,x,y);
    end;
    

  delay(2);
until ldown or rdown or (i=vk_escape);

killbmp(background);
killbmp(crosshair);
killbmp(crosshairm);

donewincrt;



end.