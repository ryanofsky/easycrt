uses easycrt,easygdi;

var i,w,h: integer;

  begin
     initwincrt;

     w := getwidth(CRT);
     h := getheight(CRT);

     setbrush(crt,color[0],color[0],solid);
     box(CRT,0,0,w,h,0,0);

     for i:=1 to w do
     begin
         setpen(crt,rgb(0,i mod 256,0),dash,0);
         line(crt,i,0,w-i,h);
     end;     
  end.
