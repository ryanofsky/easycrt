program demo;
uses WINPROCS,easycrt,wintypes;
TYPE SCOREDAT=RECORD
       NAME: STRING;
       SCORE: INTEGER;
       isreal:boolean;
     END;

var a,b,c,d,X,Y,XX,YY,X2,Y2,XX2,YY2,ballx,bally,DUD,DLR,sc:integer;
    angle:real;
    YN:CHAR;
    Player,swap:scoredat;
    SCOREFILE: FILE OF SCOREDAT;
    SGF: FILE OF INTEGER;
    highs: array[1..15] of scoredat;

    label kill;

procedure save;
  var alldone:boolean;
  begin
   
   alldone:=false;
   for a:= 1 to 15 do
     begin
       if alldone=false then
       if highs[a].isreal = false then
         begin
           highs[a]:=player;
           alldone:=true;
         end;;
     end;
   
   assign(SCOREFILE,'c:\russ\scifair\samples\pong\SCORES.dat');
   rewrite(SCOREFILE);
   for a:=1 to 15 do
     write(SCOREFILE,highs[a]);
   close(SCOREFILE);
  END;

procedure resetscores;
  var alldone:boolean;
  begin
     for a:= 1 to 15 do
     begin
       highs[a].isreal := false;
       highs[a].name   := '';
       highs[a].score  :=0; 
     end;
   
   assign(SCOREFILE,'c:\russ\scifair\samples\pong\SCORES.dat');
   rewrite(SCOREFILE);
   for a:=1 to 15 do
     write(SCOREFILE,highs[a]);
   close(SCOREFILE);
  END;

procedure readscores;
          begin;
                assign(SCOREFILE,'c:\russ\scifair\samples\pong\SCORES.dat');
                reset(SCOREFILE);
                for a := 1 to 15 do
                read (SCOREFile, highs[a]);
                close (SCOREfile);
          end;

procedure SG;
  begin
   assign(SGF,'c:\russ\scifair\samples\pong\SG.dat');
   rewrite(SGF);
   write(SGF,BALLX,BALLY,X,Y,X2,Y2,PLAYER.SCORE);
   close(SGF);
  END;

procedure READSG;
  begin
   assign(SGF,'c:\russ\scifair\samples\pong\SG.dat');
   reset(SGF);
{  READ(SGF,BALLX,BALLY,X,Y,X2,Y2,PLAYER.SCORE); }

   read(SGF, ballx);
   read(SGF, bally);
   read(SGF, x);
   read(SGF, y);
   read(SGF, x2);
   read(SGF, y2);
   read(SGF, player.score);
   close(SGF);

   writeln('Yes, I did go to the procedure.');

   writeln('   x:  ',x,'   y:  ',y,'   x2:  ',x2,'   y2:  ',y2,
      ' ballx:  ',ballx,'   bally:  ',bally);


  END;
BEGIN;
{resetscores;}  
readscores;
player.isreal:=TRUE;

for a:= 15 to 400 do
  line(DC,30,a,600,a,color[0],0,3);

SETBKCOLOR(DC,COLOR[0]);
SETTEXTCOLOR(DC,COLOR[3]);
gotoxy (25,15);
write ('ENTER YOUR NAME ---->');
SETTEXTCOLOR(DC,COLOR[5]);
READLN (player.NAME);

CLRSCR;

for a:= 15 to 400 do
  line(DC,30,a,600,a,RGB(150,150,255),0,3);

SETBKCOLOR(DC,RGB(150,150,255));
SETTEXTCOLOR(DC,COLOR[4]);
GOTOXY (40,5);
WRITE('PONG');
GOTOXY (15,10);
WRITE ('IN PONG DO NOT LET THE BALL GET PAST YOUR PADDLE. ANTICIPATE');
GOTOXY (10,12);
WRITE ('WHERE THE BALL IS GOING. KEEP YOUR PADDLE THERE AND MOVE IT TO');
GOTOXY (10,14);
WRITE ('WHERE THE BALL IS COMEING. THIS GAME IS MADE TO INCREASE YOUR');
GOTOXY (10,16);
WRITE ('EYE-HAND CORDINATION AS WELL AS MY COMPUTER MATH II GRADE I');
GOTOXY (10,18);
WRITE ('HOPE YOU ENJOY THIS PROGRAM!!!! IF YOU ARE REALLY BAD AT THIS'); 
GOTOXY(10,20);
WRITE ('GAME THERE IS NO HOPE FOR YOU AT VIDEO GAMES BECAUSE THIS IS');
GOTOXY (10,22);
WRITE ('A VERY EASY GAME!!!!! PRESS S TO SAVE A GAME');
GOTOXY (30,24);
SETTEXTCOLOR(DC,COLOR[14]);
WRITE ('PRESS ANY KEY TO PLAY');
REPEAT
UNTIL KEYPRESSED;
CLRSCR;


x:=580;
y:=100;
X2:= 30;
Y2:=100;
ballx:=300;
bally:=200;
dlr:= 20;

GOTOXY (20,20);
WRITELN ('WOULD YOU LIKE TO LOAD A SAVED GAME IF YOU HAVE 1??');
while keypressed do readkey;
yn:=readkey;


{writeln('   x:  ',x,'   y:  ',y,'   x2:  ',x2,'   y2:  ',y2,
      ' ballx:  ',ballx,'   bally:  ',bally); 

writeln(YN,'   ',ord(yn));
                                }
IF (YN = 'y') OR (YN='Y') THEN READSG;{
writeln('   x:  ',x,'   y:  ',y,'   x2:  ',x2,'   y2:  ',y2,
      ' ballx:  ',ballx,'   bally:  ',bally);
                                       }
repeat
until keypressed;


CLRSCR;


messagebeep(MB_ICONASTERISK);

for a:= 15 to 400 do
  line(DC,30,a,600,a,color[8],0,3);
setfont('COMIC SANS MS',150,0,0,0,0,0);
pprint(DC,100,100,gradient(color[8],color[7],round(5),10),'PONG');

repeat
c:=inkey;
case c of
  38: {up}    yy:=-1; 
  40: {down}  yy:=1; 
  65: {UP P2} yy2 := -1;
  90: {UP P3} yy2 := 1; 
end;
y  := y  + 10*yy ;
y2 := y2 + 10*yy2;
bally := bally + DUD;
ballx := ballx + DLR;

if y<26 then y:=25;
if y>242 then y:=241;
if y2<26 then y2:=25;
if y2>242 then y2:=241;

setbrush(color[15],0);
box(1,1,200,30,0,0);
gotoxy(1,1);
writeln('Score',player.score);



if ((ballx-50<x2) and ((bally>y2) and (bally<y2+150))) or
   ((ballx+25>x ) and ((bally>y)  and (bally<y +150))) 
   Then
     begin
       dlr:=dlr*-1;
       dud:=dud*-1;
       player.score := player.score + 5;
     end;
if ballx > 560 then goto kill;
if ballx < 55 then goto kill; 
player.score := player.score + 1;

SETPEN(-1,0,0);
SETBRUSH(COLOR[14],0); box(x,y,x+20,y+150,3,3);
SETBRUSH(COLOR[4],0);  box(x2,y2,x2+20,y2+150,3,3);
SETBRUSH(COLOR[3],0);  qcircle(ballx,bally,25,25);

delay(100);

SETBRUSH(COLOR[8],0);
box(x,y,x+20,y+150,3,3);
box(x2,y2,x2+20,y2+150,3,3);
qcircle(ballx,bally,25,25);
setfont('COMIC SANS MS',150,0,0,0,0,0);
pprint(DC,100,100,gradient(color[8],color[7],round(5),10),'PONG');
until (c=27) OR (C=83);
IF C = 83 THEN SG;
kill:

clrscr;
for a:= 1 to 14 do
  for b := a to 15 do

{
if highs[b].score > highs[a].score then
  begin
    swap:=highs[a];
    highs[a]:=highs[b];
    highs[b]:=swap;
  end;
}           

clrscr;

SETBRUSH(COLOR[2],0);
settextcolor(dc,0);

save; 
CLRSCR;
for a := 1 to 15 do
    begin;
    SETBRUSH(COLOR[A],0);
    GOTOXY (40,A);
    IF HIGHS[A].SCORE <> 0 THEN
       BEGIN;
       WRITELN (HIGHS[A].NAME);
       box(20,a*10,highs[a].score,a * 10 + 10,3,3); 
       {    gotoxy (45,a);    write (highs[a].isreal); }
       gotoxy (60,a);    write(highs[a].score);
    END;
    end;
REPEAT
UNTIL KEYPRESSED;
READLN (A);
DONEWINCRT;
end.
 