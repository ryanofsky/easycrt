{ EasyCRT Demo v1.02 }


program demo;
uses easycrt,wobjects;

var DC:HDC;

const bitpath:string = 'c:\tpw\doc\demobmp.bmp';

begin
  DC:=initdraw;

  writeln('EasyCRT Demo Program:');
  settitle('EasyCRT Demo Program');

  drawpicture(DC,30,20,bitpath);
  gotoxy(20,6);  write('Sample Bitmap Using DRAWPICTURE');

  circle(DC,500+48,170,48,75,color[12],2,2);
  gotoxy(42,15); write('Circle with CIRCLE');

  line(DC,20,150,20+100,150+100 ,color[9],0,2);
  gotoxy(10,15); write('Line with LINE');

  setfont('Britannic Bold',30,0,0,0,0,10);
  pprint(DC,48,275,color[2],'Text in any font or style with PPRINT');

  readkey;   { Pauses the program }
    
  stopdraw;
  donewincrt;
end.

{
procedure drawpicture(DC:HDC; x,y:integer; filename:string);
procedure circle(DC:HDC; xpos,ypos,radiusw,radiush:integer;  color:longint;  linestyle,width:integer);
procedure line(DC:HDC; x1,y1,x2,y2:integer; color:longint;  linestyle,width:integer);
procedure settitle(lbl:string);
function pc(strng:string):pchar;
function rgb(red,green,blue:integer):longint;
procedure setfont(fontface:string; size,weight,italic,underline,strikeout:integer;angle:real );
procedure pprint(DC:HDC; x,y:integer;  color:longint; txt:string);

line styles:
  0 solid
  1 dash
  2 dots
  3 dashes & dots
  4 double dashes & dots

line width is in pixels

colors:    
  0 black
  1 blue
  2 green
  3 cyan
  4 red
  5 magenta
  6 brown
  7 white
  8 gray
  9 light blue
  10 light green
  11 light cyan
  12 light red
  13 light magenta
  14 yellow
  15 bright white

other colors can be defined using the function RGB(red,green,blue)
  red, green, and, blue are integers between 0 and 255

settitle changes the title of the CRT window. Only works after the window
  has been created

PC inputs a normal pascal-style string and returns it type pchar. The pchar
  type is used for most ObjectWindows and GDI procedures.

font size is pixels
font weight is an integer from 1-9 where 1 is least bold and 9 is most
  bold. You can also use 0 for normal weight.
if italic, underline, and strikeout are zero, then those characteristics
  will not appear, otherwise they will. 
angle is the angle measurement above the horizontal in degrees.
       
}
