program adventure;
uses easycrt, easygdi, winprocs, wintypes, windos, strings;
type ButtonInfo = record
     x,y,xm,ym:integer;
end;

type Character = record
    Name:string;
    hits,wins:integer;
    timesplayed:integer;
    weapon,shot:string;
    howmany:integer;
end;

type highscore = record
     name:string;
     hits,wins:integer;
end;

type hss = record
     a:array[1..7] of highscore;
end;

var
temp:highscore;
hs:hss;
data2:file of hss;
Plyrs:array[1..2] of Character;
data:file of character;
a,bigc,ButtonCounter:integer;
Buttons:array[0..9] of ButtonInfo;
finished:boolean;
c,tt,wns,hts:string;
kbd,choice,ack,players:integer;
old,new,speed,location:points;
const RadDeg = 3.14159265358979323 / 180;

procedure drawb;
var b,f: integer;
  begin
     for b:=1 to 640 do
       begin
         f:=round(((b / 320)*255));
         if b>320 then f:=255-f;
         setpen(rgb(f,1,0),0,1);
         qline(b,0,b,480);
       end;
  end;

procedure Directions;
var a:integer;
begin
clrscr;
drawb;
for a:=1 to 640 do
    begin
    setpen(rgb(50+random(205),50+random(205),50+random(205)),0,1);
    qline(a,0,a,480);
    end;
setpen(0,1,0);
txt(20,1,1,0,'Welcome to Adventure by Garett Nell!');
setfont('Times New Roman',20,2,0,0,0,0);
txt(5,35,1,0,'Adventure is a game where you move your players around');
txt(5,55,1,0,'the screen using the keyboard.  If you are player one,');
txt(5,75,1,0,'your keys are the arrow keys with Ctrl as your fire key.');
txt(5,95,1,0,'Player two uses the keys X,C,V,D, and space as the fire');
txt(5,115,1,0,'key.  The object of the game is to move where you can');
txt(5,135,1,0,'fire on your opponent and hit them.  Every time you hit');
txt(5,155,1,0,'them, you get a win and they get a loss.  Try to get a');
txt(5,175,1,0,'great record and make it onto the high scores!  Use the');
txt(5,195,1,0,'menu to do all of the basic saving and loading of your');
txt(5,215,1,0,'game.  You can even save the computers record but just');
txt(5,235,1,0,'remember, you can''t change the name so everyone will ');
txt(5,255,1,0,'know it is the computer''s record, not yours.');
txt(10,285,1,0,'Hints:');
txt(5,305,1,0,'Don''t ever cross the path of your opponent unless you are');
txt(5,325,1,0,'holding downthe move key.  You''d die almost instantly!!!');
txt(105,355,1,0,'Press and key to return to the menu');
repeat until inkey<>0;
setfont('Times New Roman',30,2,0,0,0,0);
end;

type image = record
    size:points;
    pts:array[0..55,0..55] of longint;
end;

var bx,bx2:image;
const
     key_pgup:integer = 33;
     key_pgdn:integer = 34;
     key_end:integer = 35;
     key_home:integer = 36;
     key_left:integer = 37;
     key_up:integer = 38;
     key_right:integer = 39;
     key_down:integer = 40;
     key_insert:integer = 45;
     key_delete:integer = 46;
     key_let:integer = 65;
     key_number:integer = 48;

function Min(X, Y: longint): longint;
begin
  if X < Y then Min := X else Min := Y;
end;

function Max(X, Y: longint): longint;
begin
  if X > Y then Max := X else Max := Y;
end;

procedure GetBkup(xx,yy,xm,ym:integer);
var y,x:integer;
begin
     bx.size.x:=xm;
     bx.size.y:=ym;
     for y:=1 to 55 do
          for x:=1 to 55 do
              bx.pts[x,y]:=0;
     for y:=yy to yy+Min(55,ym) do
          for x:=xx to xx+Min(55,xm) do
              bx.pts[x-xx,y-yy]:=GetPixel(dchandle,x,y);
end;

procedure PutBkup(xx,yy:integer);
var y,x:integer;
begin
     for y:=yy to yy+bx.size.y do
          for x:=xx to xx+bx.size.x do
              SetPixel(dchandle,x,y,bx.pts[x-xx,y-yy]);
end;
procedure GetBkup2(xx,yy,xm,ym:integer);
var y,x:integer;
begin
     bx2.size.x:=xm;
     bx2.size.y:=ym;
     for y:=1 to 55 do
          for x:=1 to 55 do
              bx2.pts[x,y]:=0;
     for y:=yy to yy+Min(55,ym) do
          for x:=xx to xx+Min(55,xm) do
              bx2.pts[x-xx,y-yy]:=GetPixel(dchandle,x,y);
end;

procedure PutBkup2(xx,yy:integer);
var y,x:integer;
begin
     for y:=yy to yy+bx2.size.y do
          for x:=xx to xx+bx2.size.x do
              SetPixel(dchandle,x,y,bx2.pts[x-xx,y-yy]);
end;

function Quiting:integer;
var ack:integer;
begin
    ack:=Max(MessageBox(WindowHandle,'Are you sure you want to exit?','Are ya?',4),5);
    if ack=6 then donewincrt;
end;

function InTheBox(which:integer; test:ButtonInfo):boolean;
var zzz:integer;
s:string;
begin
     zzz:=0;
     if Mousex>test.x then zzz:=zzz+1;
     if Mousex<(test.x+test.xm) then zzz:=zzz+1;
     if Mousey>test.y then zzz:=zzz+1;
     if Mousey<(test.y+test.ym) then zzz:=zzz+1;
     if zzz=4 then InTheBox:=true else InTheBox:=false;
end;

procedure Click;
var b:integer;
begin
     for b:=0 to buttoncounter do if InTheBox(b,Buttons[b])=true then choice:=b+1;
end;

procedure DrawButton(x,y,xsize:integer; caption:string);
var
xm,ym:integer;
s:string;

temp: sdc;

begin
     xm:=xsize;
     ym:=abs(thedc^.prpfont.lfHeight)-2;
     roundrect(DCHandle,x,y,x+xm,y+ym,3,3);
     txt(x+3,y-3,1,rgb(255,255,255),caption);
     Buttons[ButtonCounter].x:=x; Buttons[ButtonCounter].y:=y;
     Buttons[ButtonCounter].xm:=xm; Buttons[ButtonCounter].ym:=ym;
     ButtonCounter:=ButtonCounter+1;
end;

function LoopTillClick: integer;
begin
    repeat
          kbd:=inkey;
          if ldown then
          begin
              repeat
                    Unfreeze;
              until not ldown;
              Click;
          end;
          if kbd>0 then
             begin
                  case kbd of
                  32: Click;
                  27: Quiting;
                  else
                  choice:=kbd;
                  end;
             end;
    until (choice > 0);
    LoopTillClick:=choice;
end;

procedure NewGame;
var
cntr,dir1,dir2,kbd,a1,a2:integer;
guy:array[1..2] of points;
bk:array[1..2] of points;
s:string;
bmp2,bmp3:bmp;

label fight;


procedure DoShot(player,direction:integer; theshot:string);
var
damage,theX,theY,xadj,yadj:integer;
zone:points;
main:bmp;

begin
theX:=guy[player].x;
theY:=guy[player].y;
inc(bigc);
if bigc=15 then begin;
     clrscr;
     drawb;
     putbkup(guy[1].x,guy[1].y);
     putbkup2(guy[2].x,guy[2].y);
     bmp2:=loadbmp('c:\russ\scifair\samples\garett\bmp\guy4.bmp');
     bmp3:=loadbmp('c:\russ\scifair\samples\garett\bmp\guyb3.bmp');
     getbkup(guy[1].x,guy[1].y,55,55);
     getbkup2(guy[2].x,guy[2].y,55,55);
     drawbmp(guy[1].x,guy[1].y,bmp2,1,24,39);
     drawbmp(guy[2].x,guy[2].y,bmp3,1,24,39);
     deletebmp(bmp2);
     deletebmp(bmp3);
     bigc:=0;
end;   
case direction of
     {sword=18/14}
     1: begin
     main:=loadbmp(concat(theshot,'1.bmp'));
     theX:=theX+22; theY:=theY-36-random(5);
     zone.x:=guy[player].x+25; zone.y:=guy[player].y+2;
     xadj:=0; yadj:=-20; end;
     2: begin
     main:=loadbmp(concat(theshot,'2.bmp'));
     theX:=theX+7; theY:=theY+42+random(5);
     zone.x:=guy[player].x+25; zone.y:=guy[player].y+17;
     xadj:=0; yadj:=20; end;
     3: begin
     main:=loadbmp(concat(theshot,'3.bmp'));
     theX:=theX-36-random(5); theY:=theY+5;
     zone.x:=guy[player].x+2; zone.y:=guy[player].y+20;
     xadj:=-20; yadj:=0; end;
     4: begin
     main:=loadbmp(concat(theshot,'4.bmp'));
     theX:=theX+42+random(5); theY:=theY+22;
     zone.x:=guy[player].x+17; zone.y:=guy[player].y+20;
     xadj:=20; yadj:=0; end;
end;
while (theX<=620) and (theX>=0) and (theY<=380) and (theY>=5) do
begin
     if direction>=3 then drawbmp(theX,theY,main,1,20,10);
     if direction<=2 then drawbmp(theX,theY,main,1,10,20);
     theX:=theX+xadj;
     theY:=theY+yadj;
if (guy[3-player].x<=thex+15) and (guy[3-player].x>=thex-15) and (guy[3-player].y<=they+15) and (guy[3-player].y>=they-15) then
     begin
     Inc(plyrs[player].wins);
     Inc(plyrs[3-player].hits);
     str(3-player,s);
     s:=concat(' You''ve been hit, player ',plyrs[3-player].name, '!',#13,' You get a loss! ');
     messagebox(WindowHandle,@s,'It hurts!',0);
     a:=messagebox(WindowHandle,'Do you want to go some more?','Play again?',4);
     if a<>6 then
     begin
        choice:=-1;
     end
     else
     begin
         guy[1].x:=50;
         guy[1].y:=50;
         bk[1].x:=50;
         bk[1].y:=50;
         guy[2].x:=550;
         guy[2].y:=350;
         bk[2].x:=550;
         bk[2].y:=350;
         choice:=-2;
     end;  
     exit;
     end; 
end;
deletebmp(main);
end;

begin
     clrscr;
     drawb;
     if choice=-3 then goto fight;
     choice:=0;
     {1=up, 2=down, 3=left, 4=right}
     dir1:=1;
     dir2:=1;
     fill(1,1,rgb(255,255,255),0);
     for a1:=1 to 640 do
     begin
         setpen(rgb(0,a1,0),1,1);
         qline(a1,0,640-a1,410);
     end;     
     setbrush(0,0,0);
     setpen(rgb(255,255,255),0,1);
     setfont('Times New Roman',30,2,0,0,0,0);
     buttoncounter:=0;
     drawbutton(175,100,293,'How many players?');
     drawbutton(285,150,75,'One');
     drawbutton(285,200,75,'Two');
     repeat
     a1:=LoopTillClick;
     case a1 of
         2,49: players:=1;
         3,50: players:=2;
     end;
     until (a1=2) or (a1=3) or (a1=49) or (a1=50);
     for a:=1 to players do
     begin
     clrscr;
     drawb;
     txt(200,10,1,rgb(255,255,255),'Enter your name:');
     readln(plyrs[a].name);
     if (ord(plyrs[a].name[1])>=97) then plyrs[a].name[1]:=chr(ord(plyrs[a].name[1])-32);
     s:='Welcome '+plyrs[a].name+'!';
     messagebox(WindowHandle,addr(s),'Hi',0);
     end;
fight:
     guy[1].x:=50;
     guy[1].y:=50;
     bk[1].x:=50;
     bk[1].y:=50;
     guy[2].x:=550;
     guy[2].y:=350;
     bk[2].x:=550;
     bk[2].y:=350;
     choice:=-2;
     repeat
     if choice=-2 then begin;
     Messagebox(WindowHandle, 'Click OK to fight!','Ready?',0);
     choice:=0;
     clrscr;
     drawb;
     bmp2:=loadbmp('c:\russ\scifair\samples\garett\bmp\guy4.bmp');
     bmp3:=loadbmp('c:\russ\scifair\samples\garett\bmp\guyb3.bmp');
     getbkup(guy[1].x,guy[1].y,55,55);
     getbkup2(guy[2].x,guy[2].y,55,55);
     drawbmp(guy[1].x,guy[1].y,bmp2,1,24,39);
     drawbmp(guy[2].x,guy[2].y,bmp3,1,24,39);
     deletebmp(bmp2);
     deletebmp(bmp3);
     end;
     if (kbd>0) then
        begin
        case kbd of
        {88:x,83:d,86:v,67:c}
        {fire keys are 1) ctrl:17, 2) spc:32}
        17:
        begin
             DoShot (1,dir1,plyrs[1].shot);
        end;
        32:
        begin
             DoShot (2,dir2,plyrs[2].shot);
        end;
        37:
        begin
        if dir1<>3 then dir1:=3;
        bmp2:=loadbmp('c:\russ\scifair\samples\garett\bmp\guy3.bmp');
        str(dir1,s);
        bmp3:=loadbmp(concat(plyrs[1].weapon,s,'.bmp'));
        putbkup(bk[1].x,bk[1].y);
        guy[1].x:=guy[1].x-10;
        bk[1].x:=guy[1].x-18;
        bk[1].y:=guy[1].y;
        getbkup(bk[1].x,bk[1].y,55,55);
        drawbmp(guy[1].x,guy[1].y,bmp2,1,24,39);
        drawbmp(guy[1].x-18,guy[1].y+4,bmp3,1,18,14);
        deletebmp(bmp2);
        deletebmp(bmp3);
        end;
        38:
        begin
        if dir1<>1 then dir1:=1;
        bmp2:=loadbmp('c:\russ\scifair\samples\garett\bmp\guy1.bmp');
        str(dir1,s);
        bmp3:=loadbmp(concat(plyrs[1].weapon,s,'.bmp'));
        putbkup(bk[1].x,bk[1].y);
        guy[1].y:=guy[1].y-10;
        bk[1].x:=guy[1].x;
        bk[1].y:=guy[1].y-18;
        getbkup(bk[1].x,bk[1].y,55,55);
        drawbmp(guy[1].x,guy[1].y,bmp2,1,39,24);
        drawbmp(guy[1].x+21,guy[1].y-18,bmp3,1,14,18);
        deletebmp(bmp2);
        deletebmp(bmp3);
        end;
        39:
        begin
        if dir1<>4 then dir1:=4;
        bmp2:=loadbmp('c:\russ\scifair\samples\garett\bmp\guy4.bmp');
        str(dir1,s);
        bmp3:=loadbmp(concat(plyrs[1].weapon,s,'.bmp'));
        putbkup(bk[1].x,bk[1].y);
        guy[1].x:=guy[1].x+10;
        bk[1].x:=guy[1].x;
        bk[1].y:=guy[1].y;
        getbkup(bk[1].x,bk[1].y,55,55);
        drawbmp(guy[1].x,guy[1].y,bmp2,1,24,39);
        drawbmp(guy[1].x+24,guy[1].y+21,bmp3,1,18,14);
        deletebmp(bmp2);
        deletebmp(bmp3);
        end;
        40:
        begin
        if dir1<>2 then dir1:=2;
        bmp2:=loadbmp('c:\russ\scifair\samples\garett\bmp\guy2.bmp');
        str(dir1,s);
        bmp3:=loadbmp(concat(plyrs[1].weapon,s,'.bmp'));
        putbkup(bk[1].x,bk[1].y);
        guy[1].y:=guy[1].y+10;
        bk[1].x:=guy[1].x;
        bk[1].y:=guy[1].y;
        getbkup(bk[1].x,bk[1].y,55,55);
        drawbmp(guy[1].x,guy[1].y,bmp2,1,39,24);
        drawbmp(guy[1].x+6,guy[1].y+24,bmp3,1,14,18);
        deletebmp(bmp2);
        deletebmp(bmp3);
        end;              

        88:
        begin
        if dir2<>3 then dir2:=3;
        bmp2:=loadbmp('c:\russ\scifair\samples\garett\bmp\guyb3.bmp');
        str(dir2,s);
        bmp3:=loadbmp(concat(plyrs[2].weapon,s,'.bmp'));
        putbkup2(bk[2].x,bk[2].y);
        guy[2].x:=guy[2].x-10;
        bk[2].x:=guy[2].x-18;
        bk[2].y:=guy[2].y;
        getbkup2(bk[2].x,bk[2].y,55,55);
        drawbmp(guy[2].x,guy[2].y,bmp2,1,24,39);
        drawbmp(guy[2].x-18,guy[2].y+4,bmp3,1,18,14);
        deletebmp(bmp2);
        deletebmp(bmp3);
        end;
        68:
        begin
        if dir2<>1 then dir2:=1;
        bmp2:=loadbmp('c:\russ\scifair\samples\garett\bmp\guyb1.bmp');
        str(dir2,s);
        bmp3:=loadbmp(concat(plyrs[2].weapon,s,'.bmp'));
        putbkup2(bk[2].x,bk[2].y);
        guy[2].y:=guy[2].y-10;
        bk[2].x:=guy[2].x;
        bk[2].y:=guy[2].y-18;
        getbkup2(bk[2].x,bk[2].y,55,55);
        drawbmp(guy[2].x,guy[2].y,bmp2,1,39,24);
        drawbmp(guy[2].x+21,guy[2].y-18,bmp3,1,14,18);
        deletebmp(bmp2);
        deletebmp(bmp3);
        end;
        86:
        begin
        if dir2<>4 then dir2:=4;
        bmp2:=loadbmp('c:\russ\scifair\samples\garett\bmp\guyb4.bmp');
        str(dir2,s);
        bmp3:=loadbmp(concat(plyrs[2].weapon,s,'.bmp'));
        putbkup2(bk[2].x,bk[2].y);
        guy[2].x:=guy[2].x+10;
        bk[2].x:=guy[2].x;
        bk[2].y:=guy[2].y;
        getbkup2(bk[2].x,bk[2].y,55,55);
        drawbmp(guy[2].x,guy[2].y,bmp2,1,24,39);
        drawbmp(guy[2].x+24,guy[2].y+21,bmp3,1,18,14);
        deletebmp(bmp2);
        deletebmp(bmp3);
        end;
        67:
        begin
        if dir2<>2 then dir2:=2;
        bmp2:=loadbmp('c:\russ\scifair\samples\garett\bmp\guyb2.bmp');
        str(dir2,s);
        bmp3:=loadbmp(concat(plyrs[2].weapon,s,'.bmp'));
        putbkup2(bk[2].x,bk[2].y);
        guy[2].y:=guy[2].y+10;
        bk[2].x:=guy[2].x;
        bk[2].y:=guy[2].y;
        getbkup2(bk[2].x,bk[2].y,55,55);
        drawbmp(guy[2].x,guy[2].y,bmp2,1,39,24);
        drawbmp(guy[2].x+6,guy[2].y+24,bmp3,1,14,18);
        deletebmp(bmp2);
        deletebmp(bmp3);
        end;
        end;{case of end}
     end
     else
     begin
     if players=1 then
     begin
         if abs(guy[1].y-guy[2].y) > abs(guy[1].x-guy[2].x) then
         begin
         if guy[1].y > guy[2].y then sendmessage(WindowHandle,wm_keydown,67,0);
         if guy[1].y < guy[2].y then sendmessage(WindowHandle,wm_keydown,68,0);
         end
         else
         begin
         if guy[1].x > guy[2].x then sendmessage(WindowHandle,wm_keydown,86,0);
         if guy[1].x < guy[2].x then sendmessage(WindowHandle,wm_keydown,88,0);
         end;
         if abs(guy[1].y-guy[2].y)<25 then sendmessage(WindowHandle,wm_keydown,32,0);
         if abs(guy[1].x-guy[2].x)<25 then sendmessage(WindowHandle,wm_keydown,32,0);
     end; {players end}
     end; {if kbd end}
     kbd:=inkey;
     until (kbd=27) or (choice=-1);
end;

procedure HighScores;
var b,i,r:integer;
rr,tex:string;
begin
     if fileexists('c:\russ\scifair\samples\garett\highsco.dat') = true then
     begin
          reset(data2);
     end
     else
     begin
          rewrite(data2);
          for r:=1 to 7 do
          begin
              hs.a[r].name:='No name';
              hs.a[r].hits:=0;
              hs.a[r].wins:=0;
          end;
          write(data2,hs);
          close(data2);
          exit;        
     end;
     clrscr;
     drawb;
     read(data2,hs);
     hs.a[6].name:=temp.name;
     hs.a[6].hits:=temp.hits;
     hs.a[6].wins:=temp.wins;
     repeat
     b:=0;
     for r:=1 to 5 do
     begin
          if hs.a[r+1].hits < hs.a[r].hits then
          begin
             hs.a[7]:=hs.a[r];
             hs.a[r]:=hs.a[r+1];
             hs.a[r+1]:=hs.a[7];
             b:=1;
          end;
     end;
     until b=0;
     repeat
     b:=0;
     for r:=1 to 5 do
     begin
          if hs.a[r+1].wins > hs.a[r].wins then
          begin
             hs.a[7]:=hs.a[r];
             hs.a[r]:=hs.a[r+1];
             hs.a[r+1]:=hs.a[7];
             b:=1;
          end;
     end;
     until b=0;
     txt(10,10,1,rgb(255,255,255),'Rank  Name      Wins  Loses');
     for r:=1 to 5 do
     begin
          str(r,rr);
          txt(10,10+(50*r),1,rgb(255,255,255),rr);
          txt(110,10+(50*r),1,rgb(255,255,255),hs.a[r].name);
          str(hs.a[r].wins,rr);
          txt(310,10+(50*r),1,rgb(255,255,255),rr);
          str(hs.a[r].hits,rr);
          txt(390,10+(50*r),1,rgb(255,255,255),rr);
          for b:=1 to hs.a[r].wins do
          begin
              i:=rgb(100+random(155),100+random(155),0);
              setpen(i,0,1);
              setbrush(i,0,0);
              box(430+(b*10),5+(r*50),439+(b*10),(r*50)+45,0,0);
          end;
     end;
     seek(data2,0);
     write(data2,hs);
     close(data2);
     repeat until readkey<>'';
end;
procedure SaveGame;
var a,bb,cc,dd:integer;
c:longint;
s:string;
begin
     setpen(rgb(255,255,255),1,1);
     if plyrs[1].name= 'Noname' then
     begin
          messagebox (0,'You have no game to save yet!', 'Error',0);
          messagebeep(0);                              
          exit;
     end;
     if fileexists('c:\russ\scifair\samples\garett\advedata.dat') = true then
     begin
          reset(data);
     end
     else
     begin
          rewrite(data);
     end;
          clrscr;
          drawb;
          txt(150,10,1,rgb(255,255,255),'Save which player (1 or 2)?');
          readln(a);
          if a>2 then a:=2;
          if a<1 then a:=1;
          plyrs[a].howmany:=players;
          write(data,plyrs[a]);
          close(data);
     str(plyrs[a].timesplayed,tt);
     str(plyrs[a].wins,wns);
     str(plyrs[a].hits,hts);
     s:='Name:  '+plyrs[a].name+ ' Tms: ';
     insert(tt,s,length(s));
     s:=s+ ' Wins: '+wns+' Loses: '+hts;
     clrscr;
     drawb;
     txt(5,10,1,rgb(255,255,255),s);
     txt(200,110,1,rgb(255,255,255),'Saved: Press any key');
     repeat until readkey<>'';
     temp.name:=plyrs[a].name;
     temp.wins:=plyrs[a].wins;
     temp.hits:=plyrs[a].hits;
     highscores;
end;
procedure LoadGame;
var s:string;
begin
     if fileexists('c:\russ\scifair\samples\garett\advedata.dat') = true then
     begin
          reset(data);
          read(data,plyrs[1]);
     inc(plyrs[1].timesplayed);
     players:=1;
     str(plyrs[1].timesplayed,tt);
     str(plyrs[1].wins,wns);
     str(plyrs[1].hits,hts);
     s:='Name:  '+plyrs[1].name+ ' Tms: ';
     insert(tt,s,length(s));
     s:=s+ ' Wins: '+wns+' Loses: '+hts;
     clrscr;
     drawb;
     txt(5,10,1,rgb(255,255,255),s);
     txt(200,110,1,rgb(255,255,255),'Loaded: Press any key');
     repeat until readkey<>'';
     choice:=-3;
     newgame;
     end
     else
     begin
          messagebox(WindowHandle,'You have no games to load!','Error!',0);
     end;
end;

function Menu:integer;
var b,f:integer;
begin
    clrscr;
    drawb;
    setbrush(0,0,0);
    setpen(rgb(255,255,255),0,1);
    setfont('Times New Roman',30,2,0,0,0,0);
    buttoncounter:=0;
    drawbutton(10,10,78,'New');
    drawbutton(108,10,78,'Save');
    drawbutton(206,10,80,'Load');
    drawbutton(306,10,186,'High Scores');
    drawbutton(200,200,176,'Directions!');
    drawbutton(550,10,68,'Exit');
    choice:=0;
    Menu:=LoopTillClick;
end;

procedure Menu2;
begin
    repeat
          choice:=Menu;
          case choice of
          1: NewGame;
          2: SaveGame;
          3: LoadGame;
          4: HighScores;
          5: Directions;
          6: Quiting;
          end;
    until 'hell'='freezes over';
end;


var yy,xx:integer;
col:TColorRef;
b,f:integer;
t:longint;
z,z1:bmp;
begin
    settitle('World of Adventure');
    assign(data, 'c:\russ\scifair\samples\garett\advedata.dat');
    assign(data2,'c:\russ\scifair\samples\garett\highsco.dat');
    plyrs[1].name := 'Noname';
    plyrs[2].name:='Comp';
    plyrs[1].timesplayed := 1;
    plyrs[2].timesplayed:=1;
    plyrs[1].weapon:='c:\russ\scifair\samples\garett\bmp\guyswrc';
    plyrs[2].weapon:='c:\russ\scifair\samples\garett\bmp\guyswrb';
    plyrs[1].shot:='c:\russ\scifair\samples\garett\bmp\shotc';
    plyrs[2].shot:='c:\russ\scifair\samples\garett\bmp\shotb';
    setpen(0,0,0);
    setbrush(0,0,0);
    box(0,0,640,480,0,0);
    {146,46}
    z:=loadbmp('c:\russ\scifair\samples\garett\bmp\cool.bmp');
    z1:=loadbmp('c:\russ\scifair\samples\garett\bmp\cool2.bmp');
    for b:=150 downto 1 do
      begin
        unfreeze;
        drawbmp(b,trunc(240-(b/320*240)),z,1,321-b,trunc(241-(b/240*320)));
      end;

    for b:=150 downto 1 do
      begin
        unfreeze;
        drawbmp(b+320,trunc(240-(b/320*240)),z1,1,321-b,trunc(241-(b/240*320)));
      end;
    deletebmp(z);
    deletebmp(z1);

    for t:=1 to 1500 do unfreeze;

    for b:=1 to 640 do
    begin
        f:=round(((b / 320)*255));
        if b>320 then f:=255-f;
        setpen(rgb(f,1,0),0,1);
        qline(b,0,b,480);
    end;

    Menu2;

    donewincrt;

end.