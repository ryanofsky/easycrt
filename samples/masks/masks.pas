uses easycrt, easygdi;

var bomb,bombmask:bmp;                     { bitmap variables for the bomb and it's mask }
    i,j,k: integer;                        { scratch variables }
    c: longint;                            { used to store a color }
begin

  {  B = Bitmap bits
     M = mask bits
     O = Original Background Bits
     N = New Bits

     N = (O & !M) | (B & M)

   }


  bomb     := loadbmp(appdir +'\bomb.bmp');     { loads bitmap files into memory }
  bombmask := loadbmp(appdir +'\bombmask.bmp');

  initwincrt;                                   { creates and displays easycrt window }
  settitle('Masks Demo');                       { sets the window title }

  j := trunc(sqrt(sqr(getwidth(CRT)/2)+sqr(getheight(CRT)/2))) +1;
    { calculates the approximate radius of the circle that would contain the easycrt window }


  setpen(CRT,color[-1],solid,0);                { sets the pen to invisible }
  for i := j downto 1 do
    begin
      c := gradient(color[15],color[9],i,j);    { sets c to a color that fades between blue
                                                  and white, depending on the value of i }
      setbrush(CRT,c,c,solid);                  { sets the brush to color c }
      circle(CRT,getwidth(CRT) div 2 ,getheight(CRT) div 2, i,i);
                                                { draws circles in color c with radius of i }
    end;

  copybmp(bomb,crt,getwidth(crt) div 4 - getwidth(bomb) div 2,25);         { shows bomb bmp     }
  copybmp(bombmask,crt,3*getwidth(crt) div 4 - getwidth(bomb) div 2,25);   { shows bombmask bmp }
  maskcopy(bomb,bombmask,CRT,getwidth(CRT)div 2-getwidth(bomb) div 2,200); { shows bomb masked
                                                                             with bombmask      }

  quickfont(TheFont,Verdana,20);               { sets the font to verdana size 20 }
  Thefont.halign := TA_CENTER;                 { sets the font alignment to center }

  print(CRT,getwidth(crt) div 4,25+getheight(bomb),'BOMB.BMP');
  print(CRT,3*getwidth(crt) div 4,25+getheight(bomb),'BOMBMASK.BMP');
  print(CRT,getwidth(CRT)div 2,200+getheight(bomb),'BOMB.BMP masked with BOMBMASK.BMP');
                                               { prints labels }
  killbmp(bombmask);                           { frees memory used for bitmap files }
  killbmp(bomb);

  repeat unfreeze; until keypressed or ldown or rdown; { pauses until a button is pressed }
  donewincrt;                                  { closes crt window }

end.