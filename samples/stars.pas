uses easycrt,easygdi;


var i,j,k:longint;

begin

  initwincrt;

  background := color[0];
  clrscr;

  setpen(CRT,color[15],solid,0);
  setbrush(crt,color[15],color[15],solid);


  for i := 1 to 500 do
    begin
      setpen(CRT,color[15],solid,0);
{      setbrush(crt,color[15],color[15],solid);}
      circle(CRT,random(getwidth(crt)),random(getheight(crt)),random(2)+1,random(2)+1);
      unfreeze;
    end;

end.