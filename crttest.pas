uses easycrt, easygdi;

var l: string;
    c: word;
    q: char;
begin
  restore;

  setborder(0,0); 

  writeln('hello');

  repeat
  until keypressed;

  donewincrt;

  {
  restore;
  setpos(50,75);
  setsize(200,100);
  repeat
  gotoxy(1,1);
  write(getpos(0),',',getpos(1),',',getpos(2),',',getpos(3));
  clreol;
  until keypressed;

{
  delay(500);
  minimize;
  delay(500);
  maximize;
  delay(500);
  restore;
  delay(500);
  hide;
  delay(500);
  show;
  delay(500);

  {
  repeat
    gotoxy(40,10); write('X: ',mousex,'  Y: ',mousey); clreol;
    gotoxy(40,12); write(ldown); clreol;
    gotoxy(46,12); write(rdown); clreol;
    gotoxy(1,1);   write('DC: ',dchandle,'  Wind: ',windowhandle);    
  until ord(inkeyasc) = 27




{
  repeat
    repeat
      delay(500);
      resetkeys; 
      q := inkeyasc;
    until ord(q) <>0;
    hidecursor;
    write(q);
    showcursor;
  until ord(q) = 27;  
{  repeat
  repeat

    c := inkey;

  until c<>0;
  writeln(c);
  until c = 27;
 }

end.