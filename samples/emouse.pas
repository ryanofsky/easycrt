uses easycrt, easygdi;

begin
  gotoxy(20,9); writeln('X':5,'   ','Y':5,'   ','LEFT':5,'   ','RIGHT':5);
  repeat
    unfreeze;                 {prevent lockup}
    delay(1);                 {helps get rid of screen flicker}
    gotoxy(20,10); writeln(mousex:5,'   ',mousey:5,'   ',ldown:5,'   ',rdown:5);
    if ldown then pset(mousex,mousey,color[4]);
    if rdown then pset(mousex,mousey,color[1]);
  until inkey<>0;             {repeat until keypress}
end.