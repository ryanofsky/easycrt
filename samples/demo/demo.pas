{ EasyCRT 4.01 / EasyGDI 2.01 Demo }

uses easycrt,easygdi,winprocs,wintypes;

const overlap = 10;
const maxheight = 300;
const wheight = 480;
const wwidth = 640;

var exitflag:boolean;

function checkquit:boolean;
  begin
    unfreeze; 
    if keypressed or ldown or rdown or (inkey<>0) then
      begin
        checkquit := true;
        exitflag := true;
      end
    else
      checkquit := false;
  end;


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
      if checkquit then exit;
      delay(100);
    end;
  end;

procedure drawtitle;
var path: string;
    t:longint;
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

        if checkquit then
          begin
            for i := 1 to 7 do
              begin
                killBMP(letters[i]);
                killBMP(lettersm[i]);
              end;

                killbmp(b1);
                killbmp(b2);
            exit;
          end;
         
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

    t := gettickcount;
    repeat
      if j>=50 then i:=-1;
      if j<=0 then i:=1;
      j:=j+i;
      TheFont.fcolor := gradient(color[0],color[15],j,50);
      print(CRT,getwidth(CRT) div 2,getheight(CRT) div 2+50,'by ---- -------');
      if checkquit then exit;
      delay(30);
    until gettickcount-t>=3000;

  end;

const
  rainbow: array[0..5] of longint = (
    255 + (256 *   0) + (65536 *   0) ,
    255 + (256 * 255) + (65536 *   0) ,
      0 + (256 * 255) + (65536 *   0) ,
      0 + (256 * 255) + (65536 * 255) ,
      0 + (256 *   0) + (65536 * 255) ,
    255 + (256 *   0) + (65536 * 255));

procedure usefont;
  var face:string;
      i:integer;
      t:longint;
  begin
    setbrush(crt,0,0,solid);
    setbrush(crt,0,solid,0);
    box(crt,0,0,getwidth(crt),getheight(crt),0,0);
    t := gettickcount;
    repeat
      case random(5) of
      0: face := times;
      1: face := arial;
      2: face := courier;
      3: face := cursive;
      4: face := stencil;
      5: face := verdana;
      6: face := ransom;
      end;
      quickfont(thefont,face,random(200)+200);
      thefont.angle := random *360;
      thefont.fcolor := color[random(16)];
      thefont.bgcolor := color[-1];
      thefont.halign := ta_center;
      print(crt,random(getwidth(crt)),random(getheight(crt)),char(random(26)+65));
      unfreeze;
      if checkquit then exit;
    until gettickcount-t>5000;

    for i := 200 downto 100 do
      begin
        quickfont(thefont,courier,i);
        thefont.halign := ta_center;
        thefont.valign := ta_baseline;
        thefont.weight := 1000;
        if i=100 then thefont.fcolor := color[15] else
          thefont.fcolor := 0;
        thefont.angle := round(i-100)*10;
        print(crt,getwidth(crt)div 2,getheight(crt)div 2,'Fonts!');
        if checkquit then exit;
      end;
    delay(3000);
  end;


procedure colors;
  var l,i,i1,i2,j,n:integer;
      c,c1,c2:longint;
  begin
    i1 := 0;
    i2 := 1;
    l := 0;
    n := trunc(sqrt(sqr(getwidth(CRT)/2)+sqr(getheight(CRT)/2))/6) +1;
    setpen(CRT,color[-1],solid,0);
    for i := 5 downto 0 do
      for j := (i+1)*n downto i*n do
        begin
          c := gradient(rainbow[(6-i)mod 6],rainbow[5-i],j-i*n,n);
          setbrush(CRT,c,c,solid);
          circle(CRT,getwidth(CRT) div 2 ,getheight(CRT) div 2, j,j);
          if checkquit then exit;
        end;
    for i := 0 to 255 do
      begin
        quickfont(thefont,verdana,50);
        thefont.halign := ta_center;
        thefont.valign := ta_baseline;
        thefont.bgcolor := color[-1];
        thefont.weight := 1000;
        thefont.fcolor := rgb(255-i,255-i,255-i);
        print(crt,getwidth(crt) div 2,getheight(crt) div 2-30,'24-bit Color');

        quickfont(thefont,verdana,20);
        thefont.halign := ta_center;
        thefont.valign := ta_baseline;
        thefont.bgcolor := color[-1];
        thefont.weight := 1000;
        thefont.fcolor := rgb(i,i,i);
        print(crt,getwidth(crt) div 2,getheight(crt) div 2,'24-bit Color');
        if checkquit then exit;
        delay(5);
      end;
    delay(3000);
  end;

procedure bitmaps;
var monalisa:bmp;
    i,x,y:integer;
begin

  setbrush(crt,0,0,solid);
  setbrush(crt,0,solid,0);
  box(crt,0,0,getwidth(crt),getheight(crt),0,0);

  quickfont(thefont,verdana,70);
  thefont.halign := ta_center;
  thefont.fcolor := color[7];
  print(crt,getwidth(crt)div 2, getheight(crt) div 2,'Bitmaps');

  delay(1000);

  monalisa := loadbmp(appdir+'\monalisa.bmp');

  x := (getwidth(crt)-getwidth(monalisa)) div 2;
  for i := 1 to 200 do
    begin
      y := getheight(crt) - round(i*(getheight(monalisa)/200));
      copybmp(monalisa,crt,x,y);
      if checkquit then
        begin
          killbmp(monalisa);
          exit;
        end;
   end;
  killbmp(monalisa);
  delay(1000);

end;

procedure animation;
const text = 'animations';
      swingh = 100;
      swingl = 100;
      xmove = 8;
      useangle = true;

var i,j,k,pos,x,y,ypos: integer;
    letter:string;
    buffer:bmp;
    bfont:FONT;
    head: array[0..2] of bmp;
    curbmp:integer;
    t:longint;
begin

buffer := makeblankbmp(CRT,getwidth(CRT),getheight(CRT));
setfont(buffer,bfont);
quickfont(bfont, courier, 75);
bfont.fcolor := color[15];

curbmp  := 0;
head[0] := loadbmp(appdir+'\head1.bmp');
head[1] := loadbmp(appdir+'\head2.bmp');
head[2] := loadbmp(appdir+'\head3.bmp');

t := gettickcount;

ypos := (getheight(crt)-swingh) div 2;
for pos := getwidth(buffer) downto -gettextwidth(buffer,text)-400 do
  if (pos mod xmove = 0) then 
  begin
    setbrush(buffer,color[0],color[0],solid);
    box(buffer,0,0,getwidth(buffer),getheight(buffer),0,0);
    if gettickcount-t>1000 then
      begin
        t := gettickcount;
        curbmp := (curbmp+1) mod 3;
      end;
    copybmp(head[curbmp],buffer,(getwidth(buffer)-getwidth(head[0]))div 2,
                           (getheight(buffer)-getheight(head[0]))div 2);
    x := pos;
    for i := 1 to length(text) do
      begin
        y := round(ypos + swingh * sin(x/swingl));
        letter := copy(text,i,1);
        if useangle then bfont.angle  := -180/pi*arctan(swingh*cos(x/swingl)/swingl); 
        bfont.fcolor := gradient(color[9],rgb(143,143,255),i,length(text)); 
        print(buffer,x,y,letter);
        inc(x,gettextwidth(buffer,letter));
      end;
    copybmp(buffer,crt,0,0);

    if checkquit then
      begin
        killbmp(head[0]);
        killbmp(head[1]);
        killbmp(head[2]);
        killbmp(buffer);
        exit;
      end;

    unfreeze;
  end;

killbmp(head[0]);
killbmp(head[1]);
killbmp(head[2]);
killbmp(buffer);

end;

procedure complex;

const NumberOfPoints = 6;     { number of points in the shape }
      maxvelocity = 20;       { maximum speed of a point      }
      usebuffer = true;       { use buffer                    }
      delaytime = 30;         { # of milliseconds to delay between frames }

type tPointsInMotion = record                                { position of points }
    position,velocity: array [1..NumberOfPoints] of points;
  end;

var theshape: tPointsInMotion;                           { position of points }
    i,j,k:integer;                                       { scratch variables }
    buffer:bmp;                                          { buffer bmp variable }
    t:longint;
    f:font;
    x,w:integer;
    text:string;
begin
  if usebuffer then                          { creates a buffer is usebuffer is true }
    buffer := makeblankbmp(CRT,getwidth(CRT),getheight(CRT))
  else
    buffer := CRT;

  for i := 1 to NumberOfPoints do            { sets random initial positions and speeds }
    begin
      theshape.position[i].x := random(getwidth(buffer));
      theshape.position[i].y := random(getheight(buffer));

      theshape.velocity[i].x := random(maxvelocity*2+1)-maxvelocity;
      theshape.velocity[i].y := random(maxvelocity*2+1)-maxvelocity;
    end; 

  text := 'complex graphics';
  setfont(buffer,f);
  quickfont(f,cursive,100);
  f.fcolor := color[7];
  f.weight := 100;
  x:= 640;
  w := gettextwidth(buffer,text);

  repeat

    for i := 1 to NumberOfPoints do                                  { updates points }
    with theshape do
      begin
        inc(position[i].x,velocity[i].x);
        if (position[i].x > getwidth(buffer)) or (position[i].x < 0) then
          velocity[i].x := velocity[i].x * -1;

        inc(position[i].y,velocity[i].y);
        if (position[i].y > getheight(buffer)) or (position[i].y < 0) then
          velocity[i].y := velocity[i].y * -1;
      end;


    setpen(buffer,color[-1],solid,0);                             { erases last frame }
    setbrush(buffer,color[0],color[0],solid);
    box(buffer,0,0,getwidth(buffer),getheight(buffer),0,0);

    dec(x,10);
    print(buffer,x,300,text);

    setpen(buffer,color[9],solid,3);                                { draws new shape }
    setbrush(buffer,color[12],color[0],grid);
    shape(buffer,theshape.position,numberofpoints,alternate);

    if usebuffer then copybmp(buffer,CRT,0,0);              { copies buffer to screen }
    if checkquit then
      begin
        killbmp(buffer);
        exit;
      end;

    delay(delaytime);                                         { delays between frames }

  until -x>w+10;

  if usebuffer then killbmp(buffer);                            { destroys buffer bmp }


end;

begin
  initwincrt;
  setbehave(restrictsize,FALSE);
  setsize(wwidth,wheight);
  setpos((getsystemmetrics(SM_CXSCREEN)-wwidth ) div 2,
         (getsystemmetrics(SM_CYSCREEN)-wheight) div 2);
  setborder(caption,0);
  setborder(scrollbar,0);

  exitflag := false;

repeat
  if not exitflag then easyspiral;
  if not exitflag then drawtitle;
  if not exitflag then usefont;
  if not exitflag then colors;
  if not exitflag then complex;
  if not exitflag then bitmaps;
  if not exitflag then animation;
until exitflag;

donewincrt;

end.