uses easycrt, easygdi;

const text = 'push me pull me';
      swingh = 100;
      swingl = 100;
      xmove = 10;
      useangle = true;

var i,j,k,pos,x,y,ypos: integer;
    letter:string;
    buffer:bmp;
    bfont:FONT;

begin

initwincrt;
setbehave(restrictsize,false);
settitle('Wave');


buffer := makeblankbmp(CRT,getwidth(CRT),getheight(CRT));
setfont(buffer,bfont);
quickfont(bfont, courier, 75);
bfont.fcolor := color[15];

ypos := (getheight(crt)-swingh) div 2;
for pos := getwidth(buffer) downto -gettextwidth(buffer,text) do
  if (pos mod xmove = 0) then 
  begin
    setbrush(buffer,color[0],color[0],solid);
    box(buffer,0,0,getwidth(buffer),getheight(buffer),0,0);
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
    unfreeze;
  end;
killbmp(buffer);
donewincrt;

end.