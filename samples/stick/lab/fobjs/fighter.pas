program namehere;
uses easycrt;

const fps:real = 10;





type fcoords = record;
       direction,posx,posy: integer;
       angle,lfootx,lfooty,lkneex,lkneey: real;
end;



type genfighter = object
     pos:fcoords;

     procedure draw(x,y,vsize,hsize,dir,ang:integer); virtual;
end;

type stdfighter = object(genfighter)
     procedure draw(x,y,vsize,hsize,dir,ang:integer); virtual;
     
end;


procedure genfighter.draw(x,y,vsize,hsize,dir,ang:integer);
  begin
  writeln('Inheritance Error: DRAW');
  end;

procedure stdfighter.draw(x,y:integer; vsize,hsize:real; dir,ang:integer);
  begin
    stdfighter.posx:=x;
    stdfighter.posy:=y;
  end;    

var fighter1:stdfighter;

begin

stdfighter.draw(200,200,1,1,0,0);

end.