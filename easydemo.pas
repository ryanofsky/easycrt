{ EasyCRT Demo v2.01 }

program demo;
uses easycrt, easygdi, winprocs;

var w,h,width,height,x,centerx,centery,y,k,l:longint;
    angle,radius,j:real;
    easy,tile,bomb,bombmask:bmp;
    cool: array[1..8] of bmp;

begin
  easy:=loadbmp('c:\tpw\doc\easy.bmp');
  centerx:=624 div 2;
  centery:=437 div 2;
  setbrush(color[-1],0,0);
  setbrush(color[0],0,0);
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
      txt(x,y,0,gradient(color[8],color[7],round(j),10),'EasyCrt');
      delay(100);
    end;
  setbrush(color[-1],0,0); 
  for l:=105 downto 1 do
    begin
      k:=l*3;
      setpen(gradient(rgb(238,166,0),rgb(238,30,0),k,320),0,5);
      qcircle(centerx,centery,round(k*1.5),k);
      setpen(color[0],0,5);
      qcircle(centerx,centery,round((k+5)*1.5),k+5)
    end;
  setpen(color[0],0,5);
  setbrush(color[0],0,0);
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
  resetkeys;
  repeat 
    if l>=100 then k:=-1;
    if l<=0 then k:=1;
    l:=l+k;
    txt(centerx,centery+100,3,gradient(color[0],color[15],l,101),'----------');
    delay(10);
  until ord(inkeyasc)<>0;
  centery:=centery+50;
  setbrush(-1,0,0);
  for k:=1 to 400 do
    begin
      setpen(gradient(color[15],color[7],k,400),0,5);
      qcircle(centerx,centery,k,k);
    end;
  setfont('Britannic Bold',100,0,0,0,0,0);
  txt(centerx,centery-100,3,rgb(238,30,0),'Features');
  resetkeys;
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
  resetkeys;
  readkey;
  for k:=1 to 400 do
    begin
      setpen(gradient(color[15],color[7],k,400),0,5);
      qcircle(centerx,centery,k,k);
    end;
  setbrush(-1,0,0);
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
  resetkeys;
  repeat
    for k:=1 to 8 do
      begin
        drawbmp(1,1,cool[k],0,0,0);
        delay(100);
      end;
  until ord(inkeyasc)<>0;
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