uses easycrt, winprocs, wobjects, wintypes;
var x,y,z: integer;
    backb,orig: HDC;
    working: bool;
    col: longint;
    region:hrgn;
begin
  orig:=DC;
  backb:=createcompatibledc(orig);
{ setbrush(0,0); }
  DC:=backb;
  region:=CreateRectRgn(0,0,640,480);
  selectcliprgn(backb,region);      
  box(0,0,640,480,0,0);
  for y:= 1 to 300 do
    begin
      x:=y*2;
{      setpen(color[1],0,5);
 }     setbrush(-1,0);
      qcircle(x,200,100,100);
{      setpen(color[0],0,5);
}      qcircle(x,200,100,100);
      working:=bitblt(orig,0,0,1000,1000,backb,50,50,srccopy);
      pset(x,200,color[12]);
      col:=pixel(x,200);
   {   DC:=orig;
      gotoxy(1,1);
      write(working,'  ', orig,'  ',  backb);
      clreol;
      dc:=backb; }
    end;
  deleteobject(region);
  deleteDC(backb);
  dc:=orig;
  writeln(getred(col),'  ',getgreen(col),'  ',getblue(col),'  ', region);
  
{  donewincrt; }

end.