{ EasyCRT 4.01 / EasyGDI 2.01 Demo }

uses easycrt,easygdi,winprocs,wintypes;

const overlap = 10;
const maxheight = 300;
const wheight = 480;
const wwidth = 640;

FUNCTION PwrXY (X, Y : real) : real; (* raise x to the power y           *)
BEGIN
  IF (Y = 0.0) THEN
    PwrXY := 1.0
  ELSE
    IF (X <= 0.0) AND (Frac(Y) = 0.0) THEN
      IF (Frac(Y / 2)) = 0.0 THEN
        PwrXY := Exp(Y * Ln(Abs(X)))
      ELSE
        PwrXY := - Exp(Y * Ln(Abs(X)))
    ELSE
      PwrXY := Exp(Y * Ln(X));
END;


procedure easyspiral;
  var i,j,centerx,centery,x,y:integer;
      angle,radius: real;
      
  begin

    setbrush(CRT,0,0,solid);
    box(CRT,0,0,getwidth(CRT),getheight(CRT),0,0);

    Quickfont(TheFont,'Britannic Bold',20);

    centerx := getwidth(CRT) div 2;
    centery := getheight(CRT) div 2;

  for i:=20 downto 1 do
    begin
      radius:=i*12.5;
      angle:=i*50;
      x:=round(centerx+1.5*radius*cos(angle/180*pi));
      y:=round(centery-radius*sin(angle/180*pi));
      TheFont.angle := round(angle-90+360) mod 360;
      TheFont.height  := round(2.5*i);
      TheFont.fcolor := gradient(color[8],color[7],i,20);
      print(CRT,x,y,'EasyCRT 4.0');
      delay(100);
    end;

  end;

procedure drawtitle;
var path: string;
    letters: array[1..7] of bmp;
    lettersm: array[1..7] of bmp;
    i,j,k,totalwidth,totalheight,x,y,w,h: integer;
    fact:real;
    b1,b2:bmp;
    
  begin

    letters[1]  := loadbmp(appdir+'\e.bmp');
    letters[2]  := loadbmp(appdir+'\a.bmp');
    letters[3]  := loadbmp(appdir+'\s.bmp');
    letters[4]  := loadbmp(appdir+'\y.bmp');
    letters[5]  := loadbmp(appdir+'\c.bmp');
    letters[6]  := loadbmp(appdir+'\r.bmp');
    letters[7]  := loadbmp(appdir+'\t.bmp');

    lettersm[1] := loadbmp(appdir+'\em.bmp');
    lettersm[2] := loadbmp(appdir+'\am.bmp');
    lettersm[3] := loadbmp(appdir+'\sm.bmp');
    lettersm[4] := loadbmp(appdir+'\ym.bmp');
    lettersm[5] := loadbmp(appdir+'\cm.bmp');
    lettersm[6] := loadbmp(appdir+'\rm.bmp');
    lettersm[7] := loadbmp(appdir+'\tm.bmp');

    totalwidth := -8*overlap;
    for i := 1 to 7 do
      inc(totalwidth,getwidth(letters[i]));

    totalheight := getheight(letters[1]);
    x := (getpos(clientw)-totalwidth) div 2+totalwidth;
    y := (getpos(clienth)-totalheight) div 2-50;

    b1 := makeblankbmp(CRT,getwidth(CRT),getheight(CRT));
    b2 := makeblankbmp(CRT,getwidth(CRT),getheight(CRT));

    copybmp(CRT,b1,0,0);
    copybmp(CRT,b2,0,0);

    for i := 7 downto 1 do
      begin
        unfreeze;
        h := totalheight;
        w := getwidth(letters[i]);
        x := x-w+overlap;
        for j := 3 downto 1 do
          begin
            fact := pwrxy(j,1.3);
            copybmp(b2,b1,0,0);
            supremecopy(letters[i],lettersm[i],b1,
              0,0,0,0,x,y,round(w*fact),round(h*fact));
           copybmp(b1,CRT,0,0);  
          end;
        copybmp(b1,b2,0,0); 
      end;

    for i := 1 to 7 do
      begin
        killBMP(letters[i]);
        killBMP(lettersm[i]);
      end;

    killbmp(b1);
    killbmp(b2);


    Quickfont(TheFont,times,20);
    TheFont.halign := ta_center;
    TheFont.bgcolor := 0;
    resetkeys;
    i := 1; j := 0;
    repeat
      if j>=50 then i:=-1;
      if j<=0 then i:=1;
      j:=j+i;
      TheFont.fcolor := gradient(color[0],color[15],j,50);
      print(CRT,getwidth(CRT) div 2,getheight(CRT) div 2+50,'by Russ Yanofsky');
      delay(30);
    until keypressed or ldown or rdown;

  end;

begin
  initwincrt;
  setbehave(restrictsize,FALSE);
  setsize(wwidth,wheight);
  setpos((getsystemmetrics(SM_CXSCREEN)-wwidth ) div 2,
         (getsystemmetrics(SM_CYSCREEN)-wheight) div 2);
  setborder(caption,0);
  setborder(scrollbar,0);

  easyspiral;
  drawtitle;
  donewincrt;
 
end.