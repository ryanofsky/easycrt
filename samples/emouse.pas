uses easycrt,easygdi;

begin
  initwincrt;   {opens the CRT window so you don't get an error calling settitle }

  Settitle('Mouse Input Demo');

  setcolors(color[15],color[0]);
  setpen(CRT,color[-1],solid,0);
  repeat
    gotoxy(1,1); write('X':5,'   ','Y':5,'   ','LEFT':5,'   ','RIGHT':5);
    gotoxy(1,2); write(mousex:5,'   ',mousey:5,'   ',ldown:5,'   ',rdown:5);
    if ldown and not rdown then begin setbrush(CRT,color[4],0,solid); circle(CRT,mousex,mousey,3,3); end;
    if rdown and not ldown then begin setbrush(CRT,color[1],0,solid); circle(CRT,mousex,mousey,3,3); end;
    if ldown   and   rdown then begin setbrush(CRT,color[2],0,solid); circle(CRT,mousex,mousey,3,3); end;
  until inkey<>0;
end.