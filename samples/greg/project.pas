
{38-UP}
{40-DOWN}
program project1;
uses easycrt,winprocs;

type
data=record
name1:string;
sa:integer;
end;

type
stuff=record
name2,name3:string;
end;


	var
	dc:hdc;
        mom:array[1..1] of data;
        dad:array[1..1] of stuff;
        NAME1,NAME2,NAME3:STRING;
	a,B,d,f,h,k,l,p,s,u,x,y,z,bb,CC,dd,gg,pp,ss,sc,sa,radius:integer;
        AA:LONGINT;
        C:WORD;
        rr:data;
        hh:stuff;
        scores:file of data;
        score:file of stuff;
        points:file of integer;
        kill:file of integer;
        kill2:file of integer;

        PROCEDURE DARKEN(BB:INTEGER);
        BEGIN
        FOR BB:=625 DOWNTO 1 DO
        qline(1,bb,625,BB);
        END;

        PROCEDURE DARKEN2(BB:INTEGER);
        BEGIN
        FOR BB:=1 TO 315 DO
        QLINE(1,BB,625,BB);
        END;

        PROCEDURE CIRCLES(RADIUS:INTEGER);
        BEGIN
        for radius:=1 to 100 do
        BEGIN
        setpen(color[14],radius,100);
        qcircle(150,200,radius,radius);
        setpen(color[4],radius,100);
        qcircle(150,200,radius-50,radius-50);
        SETPEN(COLOR[12],RADIUS,100);
        QCIRCLE(150,200,RADIUS-100,RADIUS-100);
        END;
        end;

        PROCEDURE SHIP1(X,Y:INTEGER);
        BEGIN
        {PLAYER 1 SHIP}
        txt(x-1,y,1,color[4],'/\');
        txt(x,y+15,1,color[4],'||');
        txt(x-3,y+37,1,color[4],'/');
        txt(x+8,y+37,1,color[4],'\');
        txt(x-1,y+45,1,color[4],'=');
        END;

        PROCEDURE SHIP2(Z,U:INTEGER);
        BEGIN
        {PLAYER 2 SHIP}
        txt(z-1,u-10,1,color[1],'=');
        txt(z+8,u-1,1,color[1],'/');
        txt(z-3,u-1,1,color[1],'\');
        txt(z,u+15,1,color[1],'||');
        txt(z-1,u+35,1,color[1],'\/');
        END;

begin
writeln;
dc:=initdraw;
y:=10;
x:=50;
DARKEN(BB);
Drawpicture(dc,250,100,'c:\russ\scifair\samples\greg\logo.bmp');
setfont('arial',20,0,0,0,0,0);
txt(252,350,1,color[1],'proudly presents');
txt(220,390,1,color[4],'hit any key to continue');
repeat until inkey<>0;
DARKEN(BB);
Drawpicture(dc,1,50,'c:\russ\scifair\samples\greg\plane.bmp');
Drawpicture(dc,300,50,'c:\russ\scifair\samples\greg\plane2.bmp');
txt(255,315,1,color[1],'Written by:');
txt(290,360,1,color[4],'Greg Dickensheets');
repeat 
     if l>=100 then k:=-1;
    if l<=0 then k:=1;
    l:=l+k;
setfont('Ariel',35,0,0,0,0,0);
    txt(317,165,3,gradient(color[4],color[1],l,101),'Dog Fight');
setfont('ariel',20,0,0,0,0,0);
    txt(220,390,1,gradient(color[1],color[4],l,101),'Hit any key to begin');
    delay(10);
    until inkey<>0;
x:=427;
y:=183;
setfont('ariel',35,0,0,0,0,0);
for x:=427 downto 200 do
begin
txt(x,y,3,color[14],'_');
txt(x,y-71,3,color[14],'_');
txt(x,y,3,color[0],'_');
txt(x,y-71,3,color[0],'_');
end;
CIRCLES(RADIUS);
repeat
     if l>=100 then k:=-1;
    if l<=0 then k:=1;
    l:=l+k;
setfont('ariel',20,0,0,0,0,0);
    txt(220,390,1,gradient(color[1],color[4],l,101),'Hit any key to begin');
    delay(10);
    until inkey<>0;
SETPEN(COLOR[0],0,0);
DARKEN(BB);
setfont('ariel',35,0,0,0,0,0);
txt(200,100,1,color[15],'FIGHT');
delay(400);
txt(200,100,1,color[0],'FIGHT');
txt(200,200,1,color[1],'OR');
delay(400);
txt(200,200,1,color[0],'OR');
txt(200,300,1,color[4],'DIE');
delay(400);
txt(200,300,1,color[0],'DIE');
begin
repeat
DARKEN(BB);
B:=50;


Drawpicture(dc,1,50,'c:\russ\scifair\samples\greg\plane.bmp');
Drawpicture(dc,300,50,'c:\russ\scifair\samples\greg\plane2.bmp');
setfont('courier new bold',25,0,0,0,0,0);
repeat
txt(120,b+50,1,color[-1],'-->');
b:=b+50;
until b=250;
b:=50;
REPEAT
C:=INKEY;
setfont('ariel',35,0,0,0,0,0);
txt(150,1,1,color[1],'DOG FIGHT MENU');
setfont('courier new bold',25,0,0,0,0,0);
txt(206,50,1,color[4],'Instructions');
txt(165,100,1,color[15],'Plane Vs. Computer');
txt(190,150,1,color[1],'Plane Vs. Plane');
txt(182,200,1,color[4],'Encrypted Scores');
txt(170,250,1,color[15],'Quit the Dog Fight');
TXT(120,B,1,COLOR[1],'-->');
IF C=38 THEN BEGIN
B:=B-50;
tXT(120,B+50,1,COLOR[-1],'-->');
IF B<50 THEN B:=250
END;
IF C=40 THEN BEGIN
B:=B+50;
TXT(120,B-50,1,COLOR[-1],'-->');

IF B>250 THEN B:=50;
END;
txt(300,350,3,color[1],'HIT ENTER TO ACTIVATE');
UNTIL C=13;

{instructions}
if b=50 then begin
DARKEN(BB);
setfont('courier new bold',20,0,0,0,0,0);
txt(50,1,1,color[1],'Mission Objective(both two and one player)');
setfont('ariel bold',15,0,0,0,0,0);
txt(70,40,1,color[4],'Your mission is to destroy the other plane without getting yourself killed.');
txt(150,60,1,color[15],'Keys for movement and shooting on the planes');
txt(10,90,1,color[15],'Plane 1(on one and two player mode)');
txt(10,105,1,color[15],'Fire- Spacebar');
txt(10,120,1,color[15],'Move up- W button');
txt(10,135,1,color[15],'Move down- Z button');
txt(10,150,1,color[15],'Move left- A button');
txt(10,165,1,color[15],'Move right- S button');
txt(300,90,1,color[15],'Plane 2(on two player mode)');
txt(300,105,1,color[15],'Fire- Enter');
txt(300,120,1,color[15],'Move up- Up Arrow');
txt(300,135,1,color[15],'Move down- Down Arrow');
txt(300,150,1,color[15],'Move left- Left Arrow');
txt(300,165,1,color[15],'Move right- Right Arrow');
TXT(10,180,1,COLOR[15],'Universal keys for 2 players: Esc-saves and exits 2 player game');
txt(192,195,1,color[15],' F1-retrieves data from last 2 player game');
txt(10,210,1,color[4],'Note: you must remeber the old player names because program will ask you');  
txt(10,225,1,color[4],'Important Note on two player game:  Tap the keys to move and shoot, do not hold them down.');
txt(10,240,1,color[4],'It will mess up plane movement and firing ability.');
txt(10,255,1,color[1],'After you destroy the enemy plane you can view your score in the encrypted score menu');
txt(10,270,1,color[1],'option.');
setfont('courier new bold',20,0,0,0,0,0);
txt(50,350,1,color[4],'Good Luck to both of you, and happy hunting.');
txt(100,400,1,color[15],'Hit any key to return to main menu');
repeat until inkey<>0;
end;

{player 1 mode}
if b=100 then begin
assign(scores,'c:\russ\scifair\samples\greg\scores.dta');
rewrite(scores);
CLRSCR;
GOTOXY(30,12);
for bb:=1 to 1 do with mom[bb] do
begin
WRITE('PLAYER 1 NAME-->');
READLN(mom[bb].NAME1);
write(scores,mom[bb]);
end;
messagebox(0,'READY TO RUMBLE','PLAYER 1',32);
clrscr;
setpen(color[0],0,0);
DARKEN2(BB);
setfont('ariel bold',25,0,0,0,0,0);
sa:=0;
P:=100;
PP:=100;
Z:=5;
u:=50;
x:=200;
y:=170;
{HEALTH BAR}
FOR H:=1 TO 625 DO
BEGIN
txt(h,290,1,color[0],'_');
END;
FOR H:=311 TO 400 DO
BEGIN
txt(300,h,1,color[0],'|');
END;

{computer HEALTH}
FOR d:=1 TO PP DO
BEGIN
txt(d+105,350,1,color[4],'|');
END;

{PLAYER 1 HEALTH}
FOR H:=1 TO P DO
BEGIN
txt(h+415,350,1,color[4],'|');
END;

GOTOXY(10,23);
write(mom[bb].NAME1);
repeat
SETFONT('ARIEL BOLD',15,1,0,0,0,0);
TXT(420,320,1,COLOR[1],'COMPUTER');
TXT(15,357,1,COLOR[4],'Power level:');
TXT(325,357,1,COLOR[1],'Power level:');
{plane 1 score}
txt(15,388,1,color[4],'Score:');
gotoxy(20,27);
write(sa);
SETFONT('ARIEL BOLD',25,0,0,0,0,0);
SHIP1(X,Y);
SHIP2(Z,U);
{PLAYER 2 MOVEMENT right}
for z:=5 to 604 do
begin
SHIP2(Z,U);
randomize;
k:=random(20)+1;

{computer FIRING}
if k=5 then begin
f:=u+5;
repeat
f:=f+5;
txt(z+3,f+45,1,color[14],'|');
for aa:=1 to 500000 do;
txt(z+3,f+45,1,color[0],'|');
if pixel(z+3,f+45)=color[4] then begin
FOR d:=pp downTO d-10 DO
BEGIN
if d<=0 then d:=0;
setfont('ariel bold',25,0,0,0,0,0);
txt(d+105,350,1,color[12],'|');
f:=240;
END;
setfont('ariel bold',150,0,0,0,0,0);
txt(454,301,1,color[15],'-');
SETFONT('ARIEL BOLD',25,0,0,0,0,0);
gotoxy(20,27);
end;
until f=240;
end;

repeat
SHIP1(X,Y);
C:=INKEY;
{FIRING}
if c=32 then begin
s:=y-5;

repeat
s:=s-5;
txt(x+3,s-15,1,color[14],'|');

for aa:=1 to 500000 do;
txt(x+3,s-15,1,color[0],'|');

if pixel(x+3,s-15)=color[1] then begin
FOR H:=p downTO h-10 DO
BEGIN
if h<=0 then h:=0;
setfont('ariel bold',25,0,0,0,0,0);
txt(h+415,350,1,color[12],'|');
s:=5;
END;
setfont('ariel bold',150,0,0,0,0,0);
txt(134,301,1,color[15],'-');
SETFONT('ARIEL BOLD',25,0,0,0,0,0);
gotoxy(20,27);
sa:=sa+5;
end;
until s=5;
end;

if c=65 then begin
 {MOVEMENT LEFT}
x:=x-5;
if x<5 then x:=5;
txt(x+4,y,1,color[0],'/\');
txt(x+5,y+15,1,color[0],'||');
txt(x+2,y+37,1,color[0],'/');
txt(x+13,y+37,1,color[0],'\');
txt(x+4,y+45,1,color[0],'=');
end;

if c=83 then begin
{MOVEMENT RIGHT}
x:=x+5;
if x>600 then x:=600;
txt(x-6,y,1,color[0],'/\');
txt(x-5,y+15,1,color[0],'||');
txt(x-8,y+37,1,color[0],'/');
txt(x+3,y+37,1,color[0],'\');
txt(x-6,y+45,1,color[0],'=');
end;

if c=90 then begin
{MOVEMENT DOWN}
y:=y+5;
if y>250 then y:=250;
txt(x-1,y-5,1,color[0],'/\');
txt(x,y+10,1,color[0],'||');
txt(x-3,y+32,1,color[0],'/');
txt(x+8,y+32,1,color[0],'\');
txt(x-1,y+40,1,color[0],'=');
end;

if c=87 then begin
{MOVEMENT UP}
y:=y-5;
if y<155 then y:=155;
txt(x-1,y+5,1,color[0],'/\');
txt(x,y+20,1,color[0],'||');
txt(x-3,y+42,1,color[0],'/');
txt(x+8,y+42,1,color[0],'\');
txt(x-1,y+50,1,color[0],'=');
end;
until inkey=0;

txt(z-1,u-10,1,color[0],'=');
txt(z+8,u-1,1,color[0],'/');
txt(z-3,u-1,1,color[0],'\');
txt(z,u+15,1,color[0],'||');
txt(z-1,u+35,1,color[0],'\/');
Z:=Z+4;
end;
{player 2 moving left}
for z:=604 downto 5 dO
begin
SHIP2(Z,U);
randomize;
k:=random(20)+1;
{PLAYER 2 FIRING}
if k=3 then begin
f:=u+5;
repeat
f:=f+5;
txt(z+3,f+45,1,color[14],'|');
for aa:=1 to 500000 do;
txt(z+3,f+45,1,color[0],'|');
if pixel(z+3,f+45)=color[4] then begin
FOR d:=pp downTO d-10 DO
BEGIN
if d<=0 then d:=0;
setfont('ariel bold',25,0,0,0,0,0);
txt(d+105,350,1,color[12],'|');
f:=240;
END;
setfont('ariel bold',150,0,0,0,0,0);
txt(454,301,1,color[15],'-');
SETFONT('ARIEL BOLD',25,0,0,0,0,0);
gotoxy(20,27);
end;
until f=240;
end;

repeat
SHIP1(X,Y);
C:=INKEY;

{FIRING}
if c=32 then begin
s:=y-5;

repeat
s:=s-5;
txt(x+3,s-15,1,color[14],'|');

for aa:=1 to 500000 do;
txt(x+3,s-15,1,color[0],'|');

if pixel(x+3,s-15)=color[1] then begin
FOR H:=p downTO h-10 DO
BEGIN
if h<=0 then h:=0;
setfont('ariel bold',25,0,0,0,0,0);
txt(h+415,350,1,color[12],'|');
s:=5;
END;
setfont('ariel bold',150,0,0,0,0,0);
txt(134,301,1,color[15],'-');
SETFONT('ARIEL BOLD',25,0,0,0,0,0);
gotoxy(20,27);
sa:=sa+5;
end;
until s=5;
end;

if c=65 then begin
 {MOVEMENT LEFT}
x:=x-5;
if x<5 then x:=5;
txt(x+4,y,1,color[0],'/\');
txt(x+5,y+15,1,color[0],'||');
txt(x+2,y+37,1,color[0],'/');
txt(x+13,y+37,1,color[0],'\');
txt(x+4,y+45,1,color[0],'=');
end;

if c=83 then begin
{MOVEMENT RIGHT}
x:=x+5;
if x>600 then x:=600;
txt(x-6,y,1,color[0],'/\');
txt(x-5,y+15,1,color[0],'||');
txt(x-8,y+37,1,color[0],'/');
txt(x+3,y+37,1,color[0],'\');
txt(x-6,y+45,1,color[0],'=');
end;

if c=90 then begin
{MOVEMENT DOWN}
y:=y+5;
if y>250 then y:=250;
txt(x-1,y-5,1,color[0],'/\');
txt(x,y+10,1,color[0],'||');
txt(x-3,y+32,1,color[0],'/');
txt(x+8,y+32,1,color[0],'\');
txt(x-1,y+40,1,color[0],'=');
end;

if c=87 then begin
{MOVEMENT UP}
y:=y-5;
if y<155 then y:=155;
txt(x-1,y+5,1,color[0],'/\');
txt(x,y+20,1,color[0],'||');
txt(x-3,y+42,1,color[0],'/');
txt(x+8,y+42,1,color[0],'\');
txt(x-1,y+50,1,color[0],'=');
end;
until inkey=0;

txt(z-1,u-10,1,color[0],'=');
txt(z+8,u-1,1,color[0],'/');
txt(z-3,u-1,1,color[0],'\');
txt(z,u+15,1,color[0],'||');
txt(z-1,u+35,1,color[0],'\/');
Z:=Z-4;
end;

until (d=0) or (h=0);
setfont('ariel bold',150,0,0,0,0,0);
txt(134,301,1,color[15],'-');
if d=0 then begin
DARKEN(BB);
assign(kill2,'c:\russ\scifair\samples\greg\kill2.dta');
rewrite(kill2);
write(kill2,sa);
close(kill2);
TXT(200,300,1,COLOR[15],'computer is winner');
TXT(100,300,1,COLOR[15],'HIT ANY KEY TO RETURN TO MENU');
REPEAT UNTIL INKEY<>0;
end;

if h=0 then begin
DARKEN(BB);
setfont('ariel bold',150,0,0,0,0,0);
txt(134,301,1,color[15],'-');
gotoxy(20,27);
assign(kill2,'c:\russ\scifair\samples\greg\kill2.dta');
rewrite(kill2);
write(kill2,sa);
close(kill2);
TXT(200,300,1,COLOR[15],'PLANE 1 is winner');
end;
TXT(100,300,1,COLOR[15],'HIT ANY KEY TO RETURN TO MENU');
repeat until inkey<>0;
for bb:=1 to 1 do with mom[bb] do
begin
write(mom[bb].sa);
write(scores,mom[bb]);
end;
close(scores);
end;


{2 player mode}
if b=150 then begin
assign(score,'c:\russ\scifair\samples\greg\score.dta');
rewrite(score);
CLRSCR;
for cc:=1 to 1 do with dad[cc] do
begin
gotoxy(30,10);
WRITE('PLAYER 1 NAME-->');
READLN(dad[cc].NAME2);
GOTOXY(30,20);
WRITE('PLAYER 2 NAME-->');
READLN(dad[cc].NAME3);
write(score,dad[cc]);
end;

messagebox(0,'READY TO RUMBLE','PLAYER 1 AND PLAYER 2',32);
CLRSCR;
setpen(color[0],0,0);
DARKEN2(BB);
setfont('ariel bold',25,0,0,0,0,0);
SS:=0;
SC:=0;
P:=100;
PP:=100;
z:=200;
u:=50;
x:=200;
y:=170;
{HEALTH BAR}
FOR H:=1 TO 625 DO
BEGIN
txt(h,290,1,color[0],'_');
END;
FOR H:=311 TO 400 DO
BEGIN
txt(300,h,1,color[0],'|');
END;

{PLAYER 2 HEALTH}
FOR d:=1 TO PP DO
BEGIN
txt(d+105,350,1,color[4],'|');
END;

{PLAYER 1 HEALTH}
FOR H:=1 TO P DO
BEGIN
txt(h+415,350,1,color[4],'|');
END;
repeat
SETFONT('ARIEL BOLD',15,1,0,0,0,0);
GOTOXY(10,23);
WRITE(dad[cc].NAME2);
GOTOXY(50,23);
WRITE(dad[cc].NAME3);
TXT(15,357,1,COLOR[4],'Power level:');
TXT(325,357,1,COLOR[1],'Power level:');
{plane 1 score}
txt(15,388,1,color[4],'Score:');
gotoxy(20,27);
write(ss);
{plane 2 score}
txt(325,388,1,color[1],'Score:');
gotoxy(59,27);
write(sc);
SETFONT('ARIEL BOLD',25,0,0,0,0,0);
SHIP1(X,Y);
SHIP2(Z,U);
REPEAT
C:=INKEY;
UNTIL C<>0;

{FIRING}
if c=32 then begin
s:=y-5;
repeat
s:=s-5;
txt(x+3,s-15,1,color[14],'|');
for aa:=1 to 500000 do;
txt(x+3,s-15,1,color[0],'|');
if pixel(x+3,s-15)=color[1] then begin
FOR H:=p downTO h-10 DO
BEGIN
setfont('ariel bold',25,0,0,0,0,0);
txt(h+415,350,1,color[12],'|');
s:=5;
END;
setfont('ariel bold',150,0,0,0,0,0);
txt(134,301,1,color[15],'-');
SETFONT('ARIEL BOLD',25,0,0,0,0,0);
gotoxy(20,27);
ss:=ss+5;
end;
until s=5;
end;

if c=65 then begin
 {MOVEMENT LEFT}
x:=x-5;
if x<5 then x:=5;
txt(x+4,y,1,color[0],'/\');
txt(x+5,y+15,1,color[0],'||');
txt(x+2,y+37,1,color[0],'/');
txt(x+13,y+37,1,color[0],'\');
txt(x+4,y+45,1,color[0],'=');
end;

if c=83 then begin
{MOVEMENT RIGHT}
x:=x+5;
if x>600 then x:=600;
txt(x-6,y,1,color[0],'/\');
txt(x-5,y+15,1,color[0],'||');
txt(x-8,y+37,1,color[0],'/');
txt(x+3,y+37,1,color[0],'\');
txt(x-6,y+45,1,color[0],'=');
end;

if c=90 then begin
{MOVEMENT DOWN}
y:=y+5;
if y>250 then y:=250;
txt(x-1,y-5,1,color[0],'/\');
txt(x,y+10,1,color[0],'||');
txt(x-3,y+32,1,color[0],'/');
txt(x+8,y+32,1,color[0],'\');
txt(x-1,y+40,1,color[0],'=');
end;

if c=87 then begin
{MOVEMENT UP}
y:=y-5;
if y<155 then y:=155;
txt(x-1,y+5,1,color[0],'/\');
txt(x,y+20,1,color[0],'||');
txt(x-3,y+42,1,color[0],'/');
txt(x+8,y+42,1,color[0],'\');
txt(x-1,y+50,1,color[0],'=');
end;


{PLAYER 2 FIRING}
if C=17 then begin
f:=u+5;
repeat
f:=f+5;
txt(z+3,f+45,1,color[14],'|');
for aa:=1 to 500000 do;
txt(z+3,f+45,1,color[0],'|');
if pixel(z+3,f+45)=color[4] then begin
FOR d:=pp downTO d-10 DO
BEGIN
setfont('ariel bold',25,0,0,0,0,0);
txt(d+105,350,1,color[12],'|');
f:=240;
END;
setfont('ariel bold',150,0,0,0,0,0);
txt(454,301,1,color[15],'-');
SETFONT('ARIEL BOLD',25,0,0,0,0,0);
gotoxy(20,27);
sc:=sc+5;
end;
until f=240;
end;

{PLAYER 2 MOVEMENT UP}
if C=38 then begin
u:=u-5;
if u<5 then u:=5;
txt(z-1,u-5,1,color[0],'=');
txt(z+8,u+4,1,color[0],'/');
txt(z-3,u+4,1,color[0],'\');
txt(z,u+20,1,color[0],'||');
txt(z-1,u+40,1,color[0],'\/');
end;

{PLAYER 2 MOVEMENT DOWN}
if C=40 then begin
u:=u+5;
if u>100 then u:=100;
txt(z-1,u-15,1,color[0],'=');
txt(z+8,u-6,1,color[0],'/');
txt(z-3,u-6,1,color[0],'\');
txt(z,u+10,1,color[0],'||');
txt(z-1,u+30,1,color[0],'\/');
end;

{PLAYER 2 MOVEMENT LEFT}
if C=37 then begin
z:=z-5;
if z<5 then z:=5;
txt(z+4,u-10,1,color[0],'=');
txt(z+13,u-1,1,color[0],'/');
txt(z+2,u-1,1,color[0],'\');
txt(z+5,u+15,1,color[0],'||');
txt(z+4,u+35,1,color[0],'\/');
end;

{PLAYER 2 MOVEMENT RIGHT}
if C=39 then begin
z:=z+5;
if z>600 then z:=600;
txt(z-6,u-10,1,color[0],'=');
txt(z+3,u-1,1,color[0],'/');
txt(z-8,u-1,1,color[0],'\');
txt(z-5,u+15,1,color[0],'||');
txt(z-6,u+35,1,color[0],'\/');
end;

if c=112 then begin
assign(score,'c:\russ\scifair\samples\greg\score.dta');
rewrite(score);
CLRSCR;
for cc:=1 to 1 do with dad[cc] do
begin
gotoxy(30,10);
WRITE('OLD PLAYER 1 NAME-->');
READLN(dad[cc].NAME2);
GOTOXY(30,20);
WRITE('OLD PLAYER 2 NAME-->');
READLN(dad[cc].NAME3);
write(score,dad[cc]);
end;
CLOSE(SCORE);

assign(points,'c:\russ\scifair\samples\greg\points.dta');
reset(points);
read(points,ss,sc,x,y,u,z);
close(points);
DARKEN2(BB);

{HEALTH BAR}
FOR H:=1 TO 625 DO
BEGIN
txt(h,290,1,color[0],'_');
END;

FOR H:=311 TO 400 DO
BEGIN
txt(300,h,1,color[0],'|');
END;

{PLAYER 2 HEALTH}
FOR d:=1 TO PP DO
BEGIN
txt(d+105,350,1,color[4],'|');
END;

{PLAYER 1 HEALTH}
FOR H:=1 TO P DO
BEGIN
txt(h+415,350,1,color[4],'|');
END;
end;

until (d=0) or (h=0) or (c=27);

if c=27 then begin
clrscr;
assign(points,'c:\russ\scifair\samples\greg\points.dta');
rewrite(points);
writeln(ss);
write(points,ss);
writeln(sc);
write(points,sc);
writeln(x);
write(points,x);
writeln(y);
write(points,y);
writeln(u);
write(points,u);
writeln(z);
write(points,z);
writeln(d);
write(points,d);
writeln(h);
write(points,h);
close(points);
gotoxy(20,20);
write('HIT ANY KEY TO RETURN TO MENU');
end;
repeat until inkey<>0;

if d=0 then begin
assign(kill,'c:\russ\scifair\samples\greg\kill.dta');
rewrite(kill);
write(kill,sc,ss);
close(kill);
DARKEN(BB);
SETFONT('ARIEL BOLD',25,0,0,0,0,0);
TXT(100,200,1,COLOR[15],'plane 2 is winner');
TXT(100,300,1,COLOR[15],'HIT ANY KEY TO RETURN TO MENU');
REPEAT UNTIL INKEY<>0;
end;

if h=0 then begin
assign(kill,'c:\russ\scifair\samples\greg\kill.dta');
rewrite(kill);
write(kill,sc,ss);
close(kill);
DARKEN(BB);
SETFONT('ARIEL BOLD',25,0,0,0,0,0);
TXT(100,200,1,COLOR[15],'plane 1 is winner');
TXT(100,300,1,COLOR[15],'HIT ANY KEY TO RETURN TO MENU');
REPEAT UNTIL INKEY<>0;
end;

end;

{scores}
if b=200 then begin
clrscr;
assign(scores,'c:\russ\scifair\samples\greg\scores.dta');
reset(scores);
for bb:=1 to 1 do with mom[bb] do
begin
read(scores,mom[bb]);
gotoxy(1,1);
write('player:');
gotoxy(1,3);
write('points:');
gotoxy(1,5);
write('graph');
gotoxy(20,1);
write(mom[bb].name1);
gotoxy(20,3);
write(mom[bb].sa);
end;
close(scores);
assign(score,'c:\russ\scifair\samples\greg\score.dta');
reset(score);

for cc:=1 to 1 do with dad[cc] do
begin
read(score,dad[cc]);
gotoxy(40,1);
write(dad[cc].name2);
gotoxy(60,1);
write(dad[cc].name3);
end;
close(score);

assign(kill,'c:\russ\scifair\samples\greg\kill.dta');
reset(kill);
gotoxy(40,3);
read(kill,ss);
write(ss);
gotoxy(60,3);
read(kill,sc);
write(sc);
close(kill);

for gg:=50 to mom[bb].sa+50 do
begin
txt(150,gg,1,color[4],'|');
end;

for gg:=50 to ss+50 do
begin
txt(310,gg,1,color[14],'|');
end;

for gg:=50 to sc+50 do
begin
txt(470,gg,1,color[1],'|');
end;

gotoxy(20,20);
write('HIT ANY KEY TO RETURN TO MENU');
REPEAT UNTIL INKEY<>0;
END;

{quit game}
until b=250;
DONEWINCRT;
end;
END.