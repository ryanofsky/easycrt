{ EasyCRT Demo v2.01 }

{ EASYCRT Documentation:                            (maximize for best view)

General Information
---------------------------------------------------------------------------

  "var DC:HDC", "DC:=INITDRAW", "STOPDRAW" are no longer neccesary in
     the program. Put drawing commands anywhere.

  Use DONEWINCRT command to close the window at the end of the program.

Color Functions
---------------------------------------------------------------------------

  Built in color constants COLOR[X]:

    X  | Color
  -----+--------------
   -1  | transparent
    0  | black
    1  | blue
    2  | green
    3  | cyan
    4  | red
    5  | magenta
    6  | brown
    7  | white
    8  | gray
    9  | light blue
    10 | light green
    11 | light cyan
    12 | light red
    13 | light magenta
    14 | yellow
    15 | bright white
  -----+----------------

  function rgb(red,green,blue:integer):longint;
    This function returns a color value from RED, GREEN and BLUE values
    0-255

  function getred(color:longint):integer;
  function getgreen(color:longint):integer;
  function getblue(color:longint):integer;
    These functions return the amount of red, green, or blue in a color
    value.

  function gradient(color1,color2:longint; stepno,steps:integer):longint;
    You can use this function to "fade" between colors.

    For example, if you wanted a circle that fades from blue to red with
      blue on the inside and red on the outside you could do this.

    for radius:=1 to 100
      begin
        setpen(gradient(color[9],color[12],radius,100);
        qcircle(100,100,radius,radius);
      end;

Pen and Brush Procedures
---------------------------------------------------------------------------
  When windows draws a shape it draws lines and curves with the current pen
  and it fills shapes and areas with the current brush. Most of the new
  drawing commands in EASYCRT now also use the current pen and brush. Here
  are the commands to set the current pen and brush. You can change them
  as many times as neccessary throughout your program.

procedure setpen(color: longint; linestyle, width: integer);
  The color value can be any value returned from a color function,
  one of the COLOR[X] values, or -1. When the color is -1 the pen is
  invisible

  Linestyle may be any of these values:
    0 solid
    1 dash
    2 dots
    3 dashes & dots
    4 double dashes & dots

  Width, is just the thickness of the pen, in pixels.

procedure setbrush(color:longint; style:integer);
  The color value can be any value returned from a color function,
  one of the COLOR[X] values, or -1. When the color is -1 the brush is
  transparent.

  Style can be any of these values
    0 Solid color
    1 Horizontal Lines
    2 Vertical Lines
    3 Downward Diagonal Lines
    4 Upward Diagonal Lines
    5 Crossed Lines
    6 Diagonal Crossed Lines

Drawing Functions
---------------------------------------------------------------------------

procedure qline(x1,y1,x2,y2:integer);
  This draws a line from (x1,y1) to (x2,y2) with the current pen.

procedure qcircle(xpos,ypos,radiusw,radiush:integer);
  This draws a ellisple with center (xpos,ypos), horizontal radius radiush,
  and vertical radius radiusv.

procedure qarc(xpos,ypos,radiusw,radiush,angle1,angle2,way:integer);
  This draws an arc from an ellipse with center (xpos,ypos), horizontal
  radius radiush, and vertical radius radiusv.

  Angle1 and Angle2 are the starting and finishing angles in degrees
  going counterclockwise.

  Way tells windows how to draw the arc
    0 Draws the arc only using the current pen.
    1 The arc between the two points and a line between the two points
      form a shape drawn with the current pen and filled with the current
      brush.
    2 The arc between the two points and lines from the points to the center
      of the ellipse form a shape drawn with the current pen and filled with
      the current brush. Looks like a slice of pie.

procedure box(x1,y1,x2,y2,x3,y3:integer);
  This command draws a rectangle with corners (x1,y1) and (x2,y2). The
  rectangle is drawn with the current pen and filled with the current
  brush. The x3 and y3 tell how round to make the corners. If they are
  zero, the corners are perfectly straight, otherwise x3 specifies the
  width of the ellipses used to draw the rounded corners and y3 specifies
  the height of the ellipses used to draw the rounded corners. 

procedure pset(xpos,ypos: integer; color:longint);
  PSET plots a point at (XPOS,YPOS) with color

function pixel(xpos,ypos:integer):longint;
  PIXEL returns the color value at point(XPOS,YPOS) on the screen.

procedure fill(xpos,ypos:integer; colorinfo:longint; filltype:integer);
  Performs a flood fill starting at point (XPOS,YPOS) with the current
  brush.

  Colorinfo is not the fill color, its meaning depends on the value of
  Filltype.
  0 Will fill an area surrounded by border of colorinfo
  1 Will fill an area whose current color is colorinfo

If you want to draw lines in bulk or draw a polygon, you can create an
  array of points and use a single command to connect them or create a
  polygon.

  For example:

  var myshape: array[1..5] of points;
  begin
    myshape[1].x:=320;  myshape[1].y:=200;
    myshape[2].x:=350;  myshape[2].y:=250;
    myshape[3].x:=120;  myshape[3].y:=300;
    myshape[4].x:= 34;  myshape[4].y:=250;
    myshape[5].x:=  1;  myshape[5].y:=200;
    connectdots(myshape,5);
  end.

    This code will draw lines between the points

procedure connectdots(var pointarray:points; count:integer);
  This function draws lines between a group of points. Pointarray is the
  array of points, count is the number of points to draw.

procedure shape(var pointarray:points; count,method: integer);
  This function draws a shape from the points. The shape is filled with
  the current brush and drawn with the current pen. Pointarray is the
  array of points, count is the number of points to draw. Method can be
  either 1 or 2 and specifies the fill mode

   1 Alternate. The system fills the area between odd-numbered and
     even-numbered polygon sides on each scan line. That is, the system
     fills the area between the first and second side, between the third
     and fourth side, and so on.

   2 Winding. The system uses the direction in which a figure was drawn to
     determine whether to fill an area. Each line segment in a polygon is
     drawn in either a clockwise or a counterclockwise direction. Whenever
     an imaginary line drawn from an enclosed area to the outside of a
     figure passes through a clockwise line segment, a count is incremented
     (increased by one); when the line passes through a counterclockwise
     line segment, the count is decremented (decreased by one). The area
     is filled if the count is nonzero when the line reaches the outside
     of the figure. 


procedure circle(DC:HDC; xpos,ypos,radiusw,radiush:integer; color:longint;  linestyle,width:integer);
procedure line(DC:HDC; x1,y1,x2,y2:integer; color:longint;  linestyle,width:integer);
  These two functions are the functions in the original EASYCRT, they
  are kept only for compatibility.

Bitmap Procedures
---------------------------------------------------------------------------
procedure drawpicture(DC:HDC; x,y:integer; filename:string);
  This is a leftover command from the first EASYCRT. It will load a bitmap
  from the disk and display it on the screen. It is still useful if you
  want to display a bitmap with a single command.

The newer bitmap procedures basically work by loading a bitmap from a disk
into memory. Once the bitmap is in memory and can be displayed in different
ways. The commands make it look like the bitmap is being loaded into
a variable, but actually the variable only holds a number value called a
handle that tells windows where the bitmap is being stored. This is only
important because these bitmap variables must be treated in special ways:

  1) The bitmaps MUST be deleted before the program ends. Although Turbo
     Pascal automatically deletes variables for you, it does not know about
     any bitmaps you load. Use the DELETEBMP command to do this. If you do
     not delete the bitmaps, they will drain system resources, and you may
     run out of memory.

  2) Also make sure to delete the bitmap variable before you load another
     another bitmap into them. For example if you put:

     var MYBMP:BMP;
     begin
       MYBMP:=loadbmp('c:\russ\homer.bmp');
       MYBMP:=loadbmp('c:\russ\bomb.bmp');
     end.

     The homer bitmap is still floating around in memory and using up
     resources. You must delete it before you load bomb.bmp.

  3) You can set one bitmap variable equal to another, but even after you've
     done this, the changing one bitmap variable will affect the other.
     Example:

     var mybmp1,mybmp2:BMP;
     begin
       MYBMP1:=loadbmp('c:\russ\homer.bmp');
       MYBMP2:=MYBMP1;
       deletebmp(mybmp2);
     end.      

     After this, both MYBMP1 and MYBMP2 contain no bitmaps. This is because
     the BMP variable type is really just a handle that points to a bitmap.
     When you set a one BMP variable equal to another you are just pointing
     them toward the same bitmap. Once you delete that bitmap, neither of
     them will work.


Here are the bitmap procedures.

function loadbmp(filename:string):BMP;
  This loads a bitmap from a file into memory and returns the bitmap
  variable (which is really just the bitmap's handle). You must delete the
  bitmap with DELETEBMP when you are done with it.

procedure drawbmp(x,y: integer;  bmpname: bmp;  stretched,width,height:integer);
  This draws a bitmap ont the screen at point (X,Y). BMPNAME is the name
  of the bitmap.

  WIDTH and HEIGHT tell Windows how big you want the bitmap to be. You can
  set these to zero to let windows to use the default height.

  If stretched is not zero then windows will stretch your bitmap to the
  height and width you specify, otherwise it will crop your bitmap to the
  specified dimensions.

procedure deletebmp(var thebmp:bmp);
  This deletes a bitmap from memory.

function getwidth(thebmp:bmp):integer;
  This function returns the default width for a bitmap.

function getheight(thebmp:bmp):integer;
  This function returns the default height for a bitmap.

procedure maskbmp(x,y: integer;  themask,thepic: bmp;  stretched,wth,ht:integer);
  This procedure is almost exactly the same as the drawbmp. The only
  difference is that you can specifiy a mask bitmap.

  A mask is usually a greyscale bitmap the same size as the original bitmap.
  The area of the mask that are white are areas where the bitmap will cover
  up whatever's already on the screen. The areas that are black will leave
  what's already on the screen intact. Grey areas of the mask will result in
  a combination of whats on the screen and what's in the bitmap. Greyed and
  colored masks are often used for special effects. Run this demo to see
  and example of how masks work.

Text and Fonts
---------------------------------------------------------------------------

Text is drawn with TXT and the font is selected with SETFONT.

procedure setfont(fontface:string; size,weight,italic,underline,strikeout:integer;angle:real );
  FONTFACE is the face of the font. It's name must be typed exactly.
    Examples are 'Arial' 'Times New Roman' 'Courier New' or 'Britannic Bold'
  Size is the height of the font in pixels
  Weight is a number from 0-9. 0 is the default weight. And values from
    1-9 where 1 is thin and 9 is extra bold.
  Italic,Underline,Strikeout
    If these are nonzero then these traits will appear, otherwise they won't.
  Angle is the angle in degrees above the horizontal to draw the font.

procedure txt(x,y,align:integer; color:longint; txt:string);
  This draws txt string at position(x,y) in the specified color.
  Align is a number 1-3
  1 Text is left aligned at (X,Y)
  2 Text is right aligned at (X,Y)
  3 Text is centered at (X,Y)

procedure pprint(DC:HDC; x,y:integer;  color:longint; txt:string);
  This is from the original wincrt, and is almost exactly the same as TXT
  except you don't have control over the alignment.

Miscellaneous 
---------------------------------------------------------------------------

  function initdraw:HDC;
  procedure stopdraw;
    These not longer do anything but are left intact for compatibility with
    older EASYCRT programs.

  function pc(strng:string):pchar;
    Many Turbo Pascal procedures require PCHAR strings instead of normal
    strings. This function converts them.

  procedure settitle(lbl:string);
     This sets the caption on the title bar of the window.

  procedure delay(milliseconds:longint);
    This procedure delays the system for a certain number of milliseconds.
    It can be used instead of a dummy FOR loop and is a little better
    because it will pause they same amount of time regardless of the speed
    of the computer.

  function inkey:word;
    This function returns the Virtual key code of the last key pressed
    You can get a listing of virtual key codes in help under (you guessed
    it) VIRTUAL KEY CODES. This works exactly like inkey$ in qbasic
    except the output is a keycode instead of an ascii code. You can
    use this to capture normal keys as well as special keys like arrow,
    shift, control, etc.

  function inkeyasc:char;
    This function is exactly like inkey$ in qbasic. It will return the
    last character pressed.

  function unfreeze;
    You may have noticed that if you have a loop like:

    for a:=1 to 200000 do;

    or

    repeat
    until keypressed;

    or

    repeat
    until 1=2;

    Your CRT window will freeze up and no buttons or keys work. To avoid
    this problem you can just add UNFREEZE to your loop, and the system
    will be able to respond to mouseclicks, keypresses, or whatever without
    locking up. For example:

    repeat
    unfreeze;
    until keypressed;

  function readkey:char;
    This is almost exactly the same as input$(1) in qbasic. It pauses the
    computer until a key is pressed and then returns the key that was
    pressed. However, the value can just be discarded at it is convenient
    to use as a pause in your program for example.

    begin
      writeln('Please press any key to continue.');
      readkey;
      writeln('Thank you.');
    end. 

  procedure donewincrt;
    This procedure closes the wincrt window. It should be used at the end
    of your program.

  procedure fullscreen;
  procedure windowscreen;
    These procedures do nothing at this point. If you run them the computer
    will probably freeze and you'll have to restart it. They will be working
    in the next version. They switch EASYCRT into and out of the full screen
    mode I'm working on.


Quick Command Reference
---------------------------------------------------------------------------

  procedure InitDeviceContext;
  procedure DoneDeviceContext;
  function initdraw:HDC;
  procedure stopdraw;
  function pc(strng:string):pchar;
  function rgb(red,green,blue:integer):longint;
  function getred(color:longint):integer;
  function getgreen(color:longint):integer;
  function getblue(color:longint):integer;
  function gradient(color1,color2:longint; stepno,steps:integer):longint;
  procedure settitle(lbl:string);
  procedure circle(DC:HDC; xpos,ypos,radiusw,radiush:integer; color:longint;  linestyle,width:integer);
  procedure line(DC:HDC; x1,y1,x2,y2:integer; color:longint;  linestyle,width:integer);
  procedure pprint(DC:HDC; x,y:integer;  color:longint; txt:string);
  procedure txt(x,y,align:integer; color:longint; txt:string);
  procedure setfont(fontface:string; size,weight,italic,underline,strikeout:integer;angle:real );
  procedure setpen(color: longint; linestyle, width: integer);
  procedure setbrush(color:longint; style:integer);
  procedure qline(x1,y1,x2,y2:integer);
  procedure qcircle(xpos,ypos,radiusw,radiush:integer);
  procedure qarc(xpos,ypos,radiusw,radiush,angle1,angle2,way:integer);
  procedure pset(xpos,ypos: integer; color:longint);
  function pixel(xpos,ypos:integer):longint;
  procedure fill(xpos,ypos:integer; colorinfo:longint; filltype:integer);
  procedure connectdots(var pointarray:points; count:integer);
  procedure shape(var pointarray:points; count,method: integer);
  procedure box(x1,y1,x2,y2,x3,y3:integer);
  procedure drawpicture(DC:HDC; x,y:integer; filename:string);
  function loadbmp(filename:string):BMP;
  procedure drawbmp(x,y: integer;  bmpname: bmp;  stretched,width,height:integer);
  procedure deletebmp(var thebmp:bmp);
  function getwidth(thebmp:bmp):integer;
  function getheight(thebmp:bmp):integer;
  procedure maskbmp(x,y: integer;  themask,thepic: bmp;  stretched,wth,ht:integer);
  procedure fullscreen;
  procedure windowscreen;
  procedure delay(milliseconds:longint);
  procedure unfreeze;
  function inkey:word;
  function inkeyasc:char;
  
}

program demo;
uses easycrt;

var w,h,width,height,x,centerx,centery,y,k,l:longint;
    angle,radius,j:real;
    easy,tile,bomb,bombmask:bmp;
    cool: array[1..8] of bmp;

begin
  easy:=loadbmp('c:\tpw\doc\easy.bmp');
  centerx:=624 div 2;
  centery:=437 div 2;
  setbrush(color[-1],0);
  setbrush(color[0],0);
  box(0,0,640,480,0,0);
  setpen(color[4],0,2);
  for k:=20 downto 1 do
    begin
      j:=k/2;
      radius:=j*25;
      angle:=j*100;
      x:=round(centerx+1.5*radius*cos(angle/180*pi));
      y:=round(centery-radius*sin(angle/180*pi));
      angle:=round((angle-90+360)) mod 360;
      setfont('Britannic Bold',5*round(j),0,0,0,0,angle);
      pprint(DC,x,y,gradient(color[8],color[7],round(j),10),'EasyCrt');
      delay(100);
    end;
  setbrush(color[-1],0); 
  for l:=105 downto 1 do
    begin
      k:=l*3;
      setpen(gradient(rgb(238,166,0),rgb(238,30,0),k,320),0,5);
      qcircle(centerx,centery,round(k*1.5),k);
      setpen(color[0],0,5);
      qcircle(centerx,centery,round((k+5)*1.5),k+5)
    end;
  setpen(color[0],0,5);
  setbrush(color[0],0);
  qcircle(centerx,centery,round((k+5)*1.5),k+5);
  width:=633;
  height:=141;
  centery:=centery-50;
  for k:=16 downto 4 do
    begin
      box(centerx-w div 2,centery-h div 2,centerx+w div 2,centery+h div 2,0,0);
      w:=round(k*width/4);  h:=round(k*height/4);
      drawbmp(centerx-w div 2,centery-h div 2,easy,1,w,h);
      delay(100);
    end;
  deletebmp(easy);
  setfont('Times New Roman',15,0,0,0,0,0);
  txt(centerx+100,centery+75,3,color[15],'version 2.0');
  setfont('Times New Roman',20,0,0,0,0,0);
  k:=1;
  l:=0;
  repeat 
    if l>=100 then k:=-1;
    if l<=0 then k:=1;
    l:=l+k;
    txt(centerx,centery+100,3,gradient(color[0],color[15],l,101),'Russ Yanofsky');
    delay(10);
  until inkey<>0;
  centery:=centery+50;
  setbrush(-1,0);
  for k:=1 to 400 do
    begin
      setpen(gradient(color[15],color[7],k,400),0,5);
      qcircle(centerx,centery,k,k);
    end;
  setfont('Britannic Bold',100,0,0,0,0,0);
  txt(centerx,centery-100,3,rgb(238,30,0),'Features');
  readkey;
  for k:=1 to 400 do
    begin
      setpen(gradient(color[15],color[7],k,400),0,5);
      qcircle(centerx,centery,k,k);
    end;
  setfont('Britannic Bold',30,0,0,0,0,0);
  txt(centerx,0,3,color[0],'General Features');
  setfont('Times New Roman',15,8,0,0,0,0);
  txt(50,50,1,color[0],' - VAR DC:HDC, INITDRAW, and STOPDRAW are no longer necessary');
  txt(50,80,1,color[0],' - CRT Window will open automatically when the program is run');
  txt(50,110,1,color[0],' - EASYCRT Programs can now be run from disks');
  txt(50,140,1,color[0],' - New drawing commands have fewer arguments (less to remember)');
  txt(50,170,1,color[0],' - New drawing commands are now more powerful');
  txt(50,200,1,color[0],' - The drawing screen has been enlarged');
  txt(50,230,1,color[0],' - EASYCRT is backward compatible. Old programs will still run.');
  readkey;
  for k:=1 to 400 do
    begin
      setpen(gradient(color[15],color[7],k,400),0,5);
      qcircle(centerx,centery,k,k);
    end;
  setbrush(-1,0);
  setfont('Britannic Bold',30,0,0,0,0,0);
  txt(35,0,0,color[0],'Bitmap Features');
  setfont('Times New Roman',20,0,0,0,0,0);
  txt(50,40,1,color[0],'Sample Code:');
  setfont('Courier New',15,8,0,0,0,0);
  txt(60,60,1,color[0],' var mybitmap: BMP;');
  txt(60,75,1,color[0],' BEGIN');
  txt(60,90,1,color[0],'   mybitmap:=loadbmp('+chr(39)+'c:\russ\homer.bmp'+chr(39)+');');
  txt(60,105,1,color[0],'   drawbmp(450,0,mybitmap,0,0,0);');
  txt(60,120,1,color[0],'   deletebmp(mybitmap);');
  txt(60,135,1,color[0],' END.');
  easy:=loadbmp('c:\tpw\doc\homer.bmp');
  drawbmp(450,0,easy,0,0,0);
  deletebmp(easy);
  setfont('Times New Roman',18,0,0,0,0,0);
  txt(20,160,1,color[0],'Homer'+chr(39)+'s picture was drawn with the above code.');
  setfont('Times New Roman',15,0,0,0,0,0);
  txt(20,190,1,color[0],' - The bitmap file was first stored in a BMP variable with LOADBMP');
  txt(20,205,1,color[0],' - It was then drawn on the screen with DRAWBMP');
  txt(20,220,1,color[0],' - And it was erased from memory with DELETEBMP');
  txt(30,250,1,color[0],'The Cool Spot Animation in the Corner was drawn the same way.');
  txt(30,265,1,color[0],'The reason why bitmaps are stored in variables is because reading from'
                       +' memory is faster than');
  txt(35,280,1,color[0],'reading from a disk');
  setfont('Times New Roman',18,0,0,1,0,0);
  txt(centerx,300,3,color[9],'More Commands and Information Can Be Found in the Documentation');
  for k:=1 to 8 do
    cool[k]:=loadbmp('c:\tpw\doc\cool'+chr(k+48)+'.bmp');
  repeat
    for k:=1 to 8 do
      begin
        drawbmp(1,1,cool[k],0,0,0);
        delay(100);
      end;
  until inkey<>0;
  for k:=1 to 8 do
    deletebmp(cool[k]);
  for k:=1 to 400 do
    begin
      setpen(gradient(color[15],color[7],k,400),0,5);
      qcircle(centerx,centery,k,k);
    end;
  setfont('Britannic Bold',30,0,0,0,0,0);
  txt(35,0,0,color[0],'Masks');
  setfont('Times New Roman',15,8,0,0,0,0);
  txt(50,50,1,color[0],' Bitmaps can also be drawn with masks using MASKBMP');
  txt(50,70,1,color[0],' Masks are used to prevent bitmaps from covering up the background and for ');
  txt(50,90,1,color[0],'   special effects');
  bomb:=loadbmp('c:\tpw\doc\bomb.bmp');
  bombmask:=loadbmp('c:\tpw\doc\bombmask.bmp');
  drawbmp((centerx-108)div 2,130,bombmask,0,0,0);
  txt(centerx div 2,250,3,color[0],'Mask');
  drawbmp(centerx+(centerx-108)div 2,130,bomb,0,0,0);
  txt(centerx+Centerx div 2,250,3,color[0],'Bitmap Without Mask');
  maskbmp(centerx-54,280,bombmask,bomb,0,0,0);
  txt(centerx,400,3,color[0],'Bitmap With Mask');
  deletebmp(bomb);
  deletebmp(bombmask);
  readkey;
  for k:=1 to 400 do
    begin
      setpen(gradient(color[15],color[7],k,400),0,5);
      qcircle(centerx,centery,k,k);
    end; 
  setfont('Britannic Bold',30,0,0,0,0,0);
  txt(35,0,0,color[0],'Pens and Brushes');
  setfont('Times New Roman',15,0,0,0,0,0);
  txt(50,50,1,color[0],' - In new commands like QLINE, QCIRCLE, and BOX, color values are not specified');
  txt(50,65,1,color[0],' - Instead, Windows uses the current pen and brush styles.');
  txt(50,80,1,color[0],'      The Pen is used to draw lines and borders around shapes.');
  txt(50,95,1,color[0],'      The Brush is used to fill shapes.');
  txt(50,110,1,color[0],' - Pen and Brush Styles are set with the following commands:');
  setfont('Courier New',15,8,0,0,0,0);
  txt(50,130,1,color[0],'   procedure setpen(color: longint; linestyle, width: integer)');
  txt(50,145,1,color[0],'   procedure setbrush(color:longint; style:integer)');
  setfont('Times New Roman',15,0,0,0,0,0);
  txt(50,165,1,color[0],'The color can be COLOR[x], RGB(red,green,blue) or -1');
  txt(50,180,1,color[0],'When the color is -1, the Brush or Pen is transparent');
  txt(50,205,1,color[0],'Brush Styles are:');
  setfont('Courier New',15,8,0,0,0,0);
  txt(70,220,1,color[0],'0  Solid Color');
  txt(70,235,1,color[0],'1  Horizontal Lines');
  txt(70,250,1,color[0],'2  Vertical Lines');
  txt(70,265,1,color[0],'3  Downward Diagonal Lines');
  txt(70,280,1,color[0],'4  Upward Diagonal Lines');
  txt(70,295,1,color[0],'5  Crossed Lines');
  txt(70,310,1,color[0],'6  Diagonally Crossed Lines');
  setfont('Times New Roman',15,0,0,0,0,0);
  txt(centerx+50,205,1,color[0],'Pen Styles Are:');
  setfont('Courier New',15,8,0,0,0,0);
  txt(centerx+70,220,1,color[0],'0  Solid Color');
  txt(centerx+70,235,1,color[0],'1  Dashes');
  txt(centerx+70,250,1,color[0],'2  Dots');
  txt(centerx+70,265,1,color[0],'3  Dashes & Dots');
  txt(centerx+70,280,1,color[0],'4  Double Dashes & Dots');
  readkey;
  clrscr;
  writeln('EASYCRT v2.0 has more new features not shown in this demo, check the ');
  writeln('documentation to see more about them.');
  writeln(' ');
  writeln(' ');
  writeln('Features for the next version:');
  writeln(' - Improved text commands ');
  writeln(' - Full screen drawing');
  writeln(' - Mouse Input');
  writeln(' - Read and save bitmaps off the screen');
  writeln(' - Better keyboard input (arrow keys, etc.)');
  writeln(' - PC Speaker Music and Sound (maybe)');
  readkey;
  donewincrt;
end.