uses easycrt, easygdi;

begin

initwincrt;
settitle('The World'+''''+'s Most Exciting Computer Program');

setbehave(autotrack,false);  {turns off cursor tracking and allows user to scroll window}

background := color[0]; clrscr;  {makes the background black }

foreground := color[14];
writeln('Change the window size and position and watch the numbers change!!!!!');

foreground := color[15];

repeat
  gotoxy(1,3);
  writeln('windowx        ',getpos(windowx),'   ');
  writeln('windowy        ',getpos(windowy),'   ');
  writeln('windoww        ',getpos(windoww),'   ');
  writeln('windowh        ',getpos(windowh),'   ');
  writeln('clientw        ',getpos(clientw),'   ');
  writeln('clienth        ',getpos(clienth),'   ');
  writeln('idealw         ',getpos(idealw),'   ');
  writeln('idealh         ',getpos(idealh) ,'   ');
  writeln('crtcolumns     ',getpos(crtcolumns),'   ');
  writeln('crtrows        ',getpos(crtrows),'   ');
until keypressed;

donewincrt;

end.
