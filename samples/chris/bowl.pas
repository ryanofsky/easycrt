program flip;
uses easygdi,easycrt2,winprocs;
const path = 'c:\russ\scifair\samples\chris\';

type scores=record
     name:string;
     points:integer;
     end;
type save=record
     n1,n2:string;
     t1,t2,f,com:integer;
     end;
var a,b,c,coms,d,f,l,m1,m2,p,pl,s,t1,t2,x,x1,x2,z:integer; r:word; frames,lane,pin,pinm:bmp; n1,n2,zn:string;
board:array[1..10,1..10] of integer;
pins:array[1..10,1..2] of integer;
hit:array[1..10] of integer;
name:array[1..2,1..10,1..3] of integer;
guy:array[1..2,1..10] of integer;
score:array[1..7] of scores;
sname:array[1..2] of save;
num:file of scores;
game:file of save;
procedure wait;
          begin
          repeat until keypressed;
          readkey;
          end;
procedure setpin;
          begin
          pins[1,1]:=480; pins[1,2]:=262;
          pins[2,1]:=510; pins[2,2]:=236;
          pins[3,1]:=510; pins[3,2]:=288;
          pins[4,1]:=540; pins[4,2]:=210;
          pins[5,1]:=540; pins[5,2]:=262;
          pins[6,1]:=540; pins[6,2]:=314;
          pins[7,1]:=570; pins[7,2]:=184;
          pins[8,1]:=570; pins[8,2]:=236;
          pins[9,1]:=570; pins[9,2]:=288;
          pins[10,1]:=570; pins[10,2]:=340;          
          for a:=1 to 10 do             
              begin
              hit[a]:=0;
              end;     
          end;
procedure frame;
          begin    
          drawbmp(0,143,lane,0,0,0);
          for a:=1 to 10 do
              if hit[a]=0 then drawbmp(pins[a,1],pins[a,2],pin,0,0,0);
          end;
procedure h(z:integer);
          begin
          if hit[z]<>1 then hit[z]:=1;
          end;
procedure point(c:integer; p1,p2,p3,p4,p5:longint);          
          begin
          z:=0;
          if (p1=color[15])or(p2=color[15])or(p3=color[15])or(p4=color[15])or(p5=color[15]) then
          begin 
          if (c=255)or(c=260)or(c=285)or(c=290) then
             begin
             for a:=1 to 10 do
                 h(a);
             end;          
          if (c=195)or(c=350)then
             begin
             if (c=195) then h(7);
             if (c=350) then h(10);
             end;
          if (c=200)or(c=205) then
             begin
             h(4); h(7);
             end;
          if (c=345)or(c=340) then
             begin
             h(6); h(10);
             end;
          if c=210 then
             begin
             h(4); h(7); h(8);
             end;
          if c=335 then
             begin
             h(6); h(9); h(10);             
             end;
          if c=215 then
             begin
             h(2); h(4); h(7); h(8);
             end;
          if c=330 then
             begin
             h(3); h(6); h(9); h(10);
             end;
          if (c=220)or(c=225) then
             begin
             h(2); h(4); h(7); h(8); h(9);
             end;
          if (c=325)or(c=320) then
             begin
             h(3); h(6); h(8); h(9); h(10);
             end;
          if (c=230)or(c=235) then
             begin
             h(2); h(4); h(5); h(7); h(8); h(9);
             end;
          if (c=315)or(c=310) then
             begin
             h(3); h(5); h(6); h(8); h(9); h(10);
             end;
          if (c=240)or(c=245) then
             begin
             h(1); h(2); h(4); h(5); h(7); h(8); h(9);
             end;
          if (c=305)or(c=300) then
             begin
             h(1); h(3); h(5); h(6); h(8); h(9); h(10);
             end;
          if c=250 then
             begin
             h(1); h(2); h(3); h(4); h(5); h(6); h(7); h(8); h(9);
             end;
          if c=295 then
             begin
             h(1); h(2); h(3); h(4); h(5); h(6); h(8); h(9); h(10);
             end;
          if c=265 then
             begin
             h(1); h(2); h(3); h(4); h(5); h(7); h(8); h(9);
             end;
          if c=280 then
             begin
             h(1); h(2); h(3); h(5); h(6); h(8); h(9); h(10);
             end;
          if (c=270)or(c=275) then
             begin
             h(1); h(2); h(3); h(4); h(5); h(6); h(8); h(9);
             end;
          end;
          for a:=1 to 10 do              
              z:=z+hit[a];
          setfont('Times New Roman',7,0,0,0,0,0);
          if (s=1) then
             begin
             name[pl,f,1]:=z;
             if (z=10)and(pl=1) then txt(x1,42,1,color[15],'X');           
             if (z=10)and(pl=2) then txt(x2,77,1,color[15],'X');      
             str(z,zn);
             if (z<10)and(pl=1) then txt(x1,42,1,color[15],zn);
             if (z<10)and(pl=2) then txt(x2,77,1,color[15],zn);
             end;
          if (s=2)and(f<10) then
             begin
             name[pl,f,2]:=z-name[pl,f,1];
             if (z=10)and(pl=1) then txt(x1,42,1,color[15],'/');            
             if (z=10)and(pl=2) then txt(x2,77,1,color[15],'/');          
             str(name[pl,f,2],zn);
             if (z<10)and(pl=1) then txt(x1,42,1,color[15],zn);
             if (z<10)and(pl=2) then txt(x2,77,1,color[15],zn);
             end;          
          if (s=2)and(f=10) then
             begin
             if name[pl,10,1]<10 then name[pl,10,2]:=z-name[pl,10,1];
             if name[pl,10,1]=10 then name[pl,10,2]:=z;
             if (z=10)and(name[pl,10,1]=10)and(pl=1) then txt(x1,42,1,color[15],'X');               
             if (z=10)and(name[pl,10,1]=10)and(pl=2) then txt(x2,77,1,color[15],'X');           
             if (z=10)and(name[pl,10,1]<10)and(pl=1) then txt(x1,42,1,color[15],'/');        
             if (z=10)and(name[pl,10,1]<10)and(pl=2) then txt(x2,77,1,color[15],'/');        
             str(name[pl,10,2],zn);
             if (z<10)and(pl=1) then txt(x1,42,1,color[15],zn);
             if (z<10)and(pl=2) then txt(x2,77,1,color[15],zn);
             end;
          if (s=3)and(f=10) then
             begin
             if (name[pl,10,1]=10)and(name[pl,10,2]<10) then name[pl,10,3]:=z-name[pl,10,2];
             if (name[pl,10,1]+name[pl,10,2]=10)or(name[pl,10,1]+name[pl,10,2]=20) then name[pl,10,3]:=z;
             m1:=name[pl,10,1]; m2:=name[pl,10,2];
             if (z=10)and((m2=10)or(m1+m2=10))and(pl=1) then txt(x1,42,1,color[15],'X');    
             if (z=10)and((m2=10)or(m1+m2=10))and(pl=2) then txt(x2,77,1,color[15],'X');       
             if (z=10)and(m1=10)and(pl=1) then txt(x1,42,1,color[15],'/');              
             if (z=10)and(m1=10)and(pl=2) then txt(x2,77,1,color[15],'/');             
             str(name[pl,10,3],zn);
             if (z<10)and(pl=1) then txt(x1,42,1,color[15],zn);
             if (z<10)and(pl=2) then txt(x2,77,1,color[15],zn);
             end;          
          end;          
procedure add;
          begin                                  
          guy[pl,f]:=name[pl,f,1]+name[pl,f,2]+name[pl,f,3];
          setfont('Times New Roman',15,0,0,0,0,0);
          if name[pl,f,1]=10 then guy[pl,f]:=guy[pl,f]+10;
          if name[pl,f,2]=10 then guy[pl,f]:=guy[pl,f]+10;
          if name[pl,f,3]=10 then guy[pl,f]:=guy[pl,f]+10;
          if (name[pl,f,1]<>10)and(name[pl,f,1]+name[pl,f,2]=10) then guy[pl,f]:=guy[pl,f]+5;
          if (name[pl,f,2]<>10)and(name[pl,f,2]+name[pl,f,3]=10) then guy[pl,f]:=guy[pl,f]+5; 
          if pl=1 then t1:=t1+guy[1,f];
          if pl=2 then t2:=t2+guy[2,f];
          if pl=1 then str(t1,zn);
          if pl=2 then str(t2,zn);
          if pl=1 then txt(x,55,1,color[15],zn);
          if pl=2 then txt(x,88,1,color[15],zn);
          end;
procedure release(c:integer);
          var p1,p2,p3,p4,p5:longint;
          begin
          p:=25; p1:=0; p2:=0; p3:=0; p4:=0; p5:=0;
          for a:=1 to 56 do
              begin
              getbkup(p-20,c-20,40,40);
              qcircle(p,c,20,20);
              putbkup(p-20,c-20);
              p:=p+10;
              if p1<>color[15] then p1:=pixel(p+10,c);
              if p2<>color[15] then p2:=pixel(p,c+10);
              if p3<>color[15] then p3:=pixel(p,c-10);
              if p4<>color[15] then p4:=pixel(p+3,c+5);
              if p5<>color[15] then p5:=pixel(p+3,c-5);
              end;
          point(c,p1,p2,p3,p4,p5);
          end; 
procedure intro;
          label bowl;
          begin          
bowl:     frame;
          setpen(color[0],0,1);
          setbrush(color[0],0);
          if f=0 then
             begin
             for a:=0 to 622 do
                 qline(a,0,a,142);
             txt(75,20,1,color[4],'BOWLING');
             b:=25; c:=195; d:=0;
             for a:=1 to 18 do
                 begin
                 getbkup(b-20,c-20,40,40);
                 qcircle(b,c,20,20);              
                 putbkup(b-20,c-20);
                 c:=c+5;
                 end;
             f:=f+1;
             release(c);
             goto bowl;
             end;
          for a:=1 to 122 do 
              begin
              setfont('Times New Roman',a,0,0,0,0,0);
              txt(10,10,0,color[4],'X');
              for b:=0 to 622 do
                  qline(b,0,b,142);              
              drawbmp(0,143,lane,0,0,0);
              end;
          txt(10,10,1,color[4],'X STRIKE');
          delay(2000);
          end;
procedure think(var cc:integer);
          begin         
          r:=random(31)+1;
          cc:=(r*5)+195          
          end;
procedure saves(n1,n2:string; t1,t2,f,com:integer);
          var sv:save;
          begin
          sv.n1:=n1;
          sv.n2:=n2;
          sv.t1:=t1;
          sv.t2:=t2;
          sv.f:=f-1;
          sv.com:=com;
          assign(game,path+'game.dat');
          rewrite(game);
          write(game,sv);       
          close(game);
          end;
procedure menu;
          begin
          clrscr;
          gotoxy(33,1); write('BOWLING!');
          gotoxy(35,3); write('MENU');
          gotoxy(28,4); write('1. Directions.');
          gotoxy(28,5); write('2. Game (2 player).');
          gotoxy(28,6); write('3. Game (1 player).');
          gotoxy(28,7); write('4. High score list.');
          gotoxy(28,8); write('5. Load last saved game.');
          gotoxy(28,9); write('6. Unload game.');
          gotoxy(28,10); write('7. Exit.');
          end;
procedure directions;
          begin
          clrscr;
          setfont('Times New Roman',20,0,0,0,0,0);
          txt(312,1,1,color[15],'I rule');
          txt(312,1,3,color[0],'BOWLING');
          txt(312,25,3,color[0],'This game is exactly like the game we know and love.');
          txt(312,50,3,color[0],'To play this game you first pick 1 player or 2 player.');
          txt(312,75,3,color[0],'Then you enter your name and the game will begin.');
          txt(312,100,3,color[0],'When in the game the ball will move up and down automatically');
          txt(312,125,3,color[0],'To release the ball you must hit the SPACEBAR.');
          txt(312,150,3,color[0],'You are scored by how many pins you hit down with the ball.');
          txt(312,175,3,color[0],'You get one point for each pin you knock down and bonus points are avalible.');
          txt(312,200,3,color[0],'If you hit all 10 pins down with ONE roll you get 10 points +10 bonus points.');
          txt(312,225,3,color[0],'If you hit all 10 pins down with TWO rolls you get 10 points +5 bonus points.');
          txt(312,250,3,color[0],'The objective of this game is to get as many points as possible.');
          txt(312,275,3,color[0],'Hint: to knock all the pins down release the ball between the center arrow and');
          txt(312,300,3,color[0],'to one right above it or the one right below it.');
          txt(312,325,3,color[0],'To exit game at any time hit the BACKSPACE key.');
          txt(312,350,3,color[0],'You may save you game at the top of each frame by hitting the TAB key.');
          txt(312,385,3,color[0],'(hit any key to continue)');
          wait;
          end;
procedure game1;
          const com=0;
          label bowl,rebowl,done,done1;
          begin
          if (l=1)and(coms<>com) then goto done1;
          setfont('Times New Roman',15,0,0,0,0,0);
          txt(10,40,0,color[15],'Loading');
          clrscr;
          if l<>1 then
             begin
             write('Enter player''s 1 name--->');
             readln(n1);
             write('Enter player''s 2 name--->');
             readln(n2);
             end;
          drawbmp(0,0,frames,0,0,0);
          txt(55,50,1,color[15],n1);
          txt(55,85,1,color[15],n2);
          if l=1 then
             begin
             str(t1,zn);
             txt(x,55,1,color[15],zn);
             str(t2,zn);             
             txt(x,88,1,color[15],zn);
             end;
          setpin;
rebowl:   frame;
          delay(1000);
          setpin;
          setpen(color[0],0,1);
          setbrush(color[15],0);
          if (f>0)and(l=0) then add;
          l:=0;
          if pl=1 then
             begin
             pl:=2; s:=1;
             if f<10 then x2:=x2+30;
             if f=10 then x2:=x2+20;
             qcircle(43,93,5,5);
             setbrush(color[0],0);
             qcircle(43,58,5,5);
             goto bowl;
             end;
          if pl=2 then
             begin
             pl:=1; f:=f+1; s:=1; x:=x+40;
             if f<10 then x1:=x1+30;
             if f=10 then x1:=x1+20;
             qcircle(43,58,5,5);
             setbrush(color[0],0);
             qcircle(43,93,5,5);
             end;          
bowl:     frame;          
          setbrush(color[0],0);
          b:=25; c:=195; d:=0;          
          repeat
          for a:=1 to 31 do
              begin
              getbkup(b-20,c-20,40,40);
              qcircle(b,c,20,20);              
              putbkup(b-20,c-20);
              r:=inkey;
              if r=08 then goto done1;
              if (r=09)and(s=1)and(pl=1)and(f<10) then
                 begin
                 saves(n1,n2,t1,t2,f,com);
                 gotoxy(35,18); write('SAVED');
                 end;
              if r=32 then
                 begin
                 release(c);
                 s:=s+1;               
                 if pl=1 then x1:=x1+10;
                 if (pl=1)and(s=3)and(f<10) then x1:=x1-10;
                 if pl=2 then x2:=x2+10;
                 if (pl=2)and(s=3)and(f<10) then x2:=x2-10;
                 if (s=2)and(name[pl,f,1]<10) then goto bowl;
                 if (s=2)and(f<10)and(name[pl,f,1]=10) then goto rebowl;
                 if (s=2)and(f=10)and(name[pl,f,1]=10) then
                    begin
                    frame;
                    delay(1000);
                    setpin;
                    goto bowl;
                    end;
                 if (s=3)and(f<10) then goto rebowl;
                 if (s=3)and(f=10)and(name[pl,10,1]+name[pl,10,2]<10)and(pl=1) then goto rebowl;
                 if (s=3)and(f=10)and(name[pl,10,1]+name[pl,10,2]<10)and(pl=2) then goto done;
                 if (s=3)and(f=10)and(name[pl,10,1]=10)and(name[pl,10,2]<10) then goto bowl;
                 if (s=3)and(f=10)and(name[pl,10,1]+name[pl,10,2]>=10) then
                    begin
                    frame;
                    delay(1000);
                    setpin;
                    goto bowl;
                    end;
                 if (s=4)and(f=10)and(pl=1) then goto rebowl;
                 if (s=4)and(f=10)and(pl=2) then goto done;
                 end;
              delay(1);
              if d=0 then c:=c+5;
              if d=1 then c:=c-5;
              end;
          if c=350 then d:=1;
          if c=195 then d:=0;
          until a=0;
done:     frame;
          add;
          score[6].name:=n1; score[6].points:=t1;
          score[7].name:=n2; score[7].points:=t2;
done1:    if l=0 then
             begin
             gotoxy(29,19); writeln('Game Done (hit any key)');
             end;
          if l=1 then
             begin
             gotoxy(23,19); writeln('Load as 1 player game (hit any key)');
             end;          
          wait;
          end;
procedure game2;
          const com=1;
          label bowl,rebowl,done,done1,bob;
          begin          
          if (l=1)and(coms<>com) then goto done1;
          setfont('Times New Roman',15,0,0,0,0,0);
          txt(10,40,0,color[15],'Loading');
          clrscr;
          if l<>1 then
             begin
             write('Enter player''s 1 name--->');
             readln(n1);
             n2:='Computer';
             end;
          drawbmp(0,0,frames,0,0,0);
          txt(55,50,1,color[15],n1);
          txt(55,85,1,color[15],n2);          
          if l=1 then
             begin
             str(t1,zn);
             txt(x,55,1,color[15],zn);
             str(t2,zn);
             txt(x,88,1,color[15],zn);
             end;
          setpin;
rebowl:   frame;
          delay(1000);
          setpin;
          setpen(color[0],0,1);
          setbrush(color[15],0);
          if (f>0)and(l=0) then add;
          l:=0;
          if pl=1 then
             begin
             pl:=2; s:=1;
             if f<10 then x2:=x2+30;
             if f=10 then x2:=x2+20;
             qcircle(43,93,5,5);
             setbrush(color[0],0);
             qcircle(43,58,5,5);
             goto bowl;
             end;
          if pl=2 then
             begin
             pl:=1; f:=f+1; s:=1; x:=x+40;
             if f<10 then x1:=x1+30;
             if f=10 then x1:=x1+20;
             qcircle(43,58,5,5);
             setbrush(color[0],0);
             qcircle(43,93,5,5);
             end;          
bowl:     frame;       
          setbrush(color[0],0);
          b:=25; c:=195; d:=0;          
          if pl=2 then think(c);         
          if pl=2 then goto bob;
          repeat
          for a:=1 to 31 do
              begin
              getbkup(b-20,c-20,40,40);
              qcircle(b,c,20,20);              
              putbkup(b-20,c-20);
              r:=inkey;
              if r=08 then goto done1;
              if (r=09)and(s=1)and(pl=1)and(f<10) then
                 begin
                 saves(n1,n2,t1,t2,f,com);
                 gotoxy(35,18); write('SAVED');
                 end;
              if r=32 then
                 begin
bob:             release(c);
                 s:=s+1;
                 if pl=1 then x1:=x1+10;
                 if (pl=1)and(s=3)and(f<10) then x1:=x1-10;
                 if pl=2 then x2:=x2+10;
                 if (pl=2)and(s=3)and(f<10) then x2:=x2-10;
                 if (s=2)and(name[pl,f,1]<10) then goto bowl;
                 if (s=2)and(f<10)and(name[pl,f,1]=10) then goto rebowl;
                 if (s=2)and(f=10)and(name[pl,f,1]=10) then
                    begin
                    frame;
                    delay(1000);
                    setpin;
                    goto bowl;
                    end;
                 if (s=3)and(f<10) then goto rebowl;
                 if (s=3)and(f=10)and(name[pl,10,1]+name[pl,10,2]<10)and(pl=1) then goto rebowl;
                 if (s=3)and(f=10)and(name[pl,10,1]+name[pl,10,2]<10)and(pl=2) then goto done;
                 if (s=3)and(f=10)and(name[pl,10,1]=10)and(name[pl,10,2]<10) then goto bowl;
                 if (s=3)and(f=10)and(name[pl,10,1]+name[pl,10,2]>=10) then
                    begin
                    frame;
                    delay(1000);
                    setpin;
                    goto bowl;
                    end;
                 if (s=4)and(f=10)and(pl=1) then goto rebowl;
                 if (s=4)and(f=10)and(pl=2) then goto done;
                 end;
              delay(1);
              if d=0 then c:=c+5;
              if d=1 then c:=c-5;
              end;
          if c=350 then d:=1;
          if c=195 then d:=0;
          until a=0;
done:     frame;
          add;
          score[6].name:=n1; score[6].points:=t1;
          score[7].name:=n2; score[7].points:=t2;
done1:    if l=0 then
             begin
             gotoxy(29,19); writeln('Game Done (hit any key)');
             end;
          if l=1 then
             begin
             gotoxy(23,19); writeln('Load as 2 player game (hit any key)');
             end;
          wait;
          end;
procedure chart;
          var lu,ran:integer; sc:scores;
          begin
          assign(num,'path+nums.dat');
          reset(num);
          clrscr;
          for a:=1 to 5 do              
              read(num,score[a]);
          for a:=1 to 6 do
              for b:=1+a to 7 do
                  if score[a].points<score[b].points then
                     begin
                     sc:=score[a]; score[a]:=score[b]; score[b]:=sc;
                     end;
          rewrite(num);
          for a:=1 to 5 do
              write(num,score[a]);
          close(num);
          gotoxy(36,1); write('High Scores');
          gotoxy(5,3); write('NAME');
          gotoxy(20,3); write('Points');
          gotoxy(53,3); write('Scale');
          gotoxy(29,4); write('0  24  48   72  96   120  144  168  192  216  240');
          for a:=1 to 5 do
              begin
              lu:=0;
              c:=length(score[a].name);
              for d:=1 to c do
                  lu:=lu+ord(score[a].name[d]);
              ran:=random(3)+19;
              lu:=lu div ran;
              gotoxy(1,a+5); write(a,'. ',score[a].name,' (',lu,')');
              gotoxy(22,a+5); write(score[a].points);
              b:=score[a].points div 5;              
              f:=0;
              for d:=0 to b-1 do
                  begin
                  f:=f+1;
                  if f>c then f:=1;
                  gotoxy(d+29,a+5); write(copy(score[a].name,f,1));
                  end;
              end;
          gotoxy(1,15); write('Number in ( ) is you luck number');
          gotoxy(1,20); write('hit any key to continue');
          wait;
          end;
procedure load;
          var sv:save;
          begin
          assign(game,path+'game.dat');
          reset(game);
          read(game,sv);       
          close(game);
          n1:=sv.n1;
          n2:=sv.n2;
          t1:=sv.t1;
          t2:=sv.t2;
          f:=sv.f;
          coms:=sv.com;          
          l:=1;
          end;
procedure stop;
          begin
          clrscr;
          gotoxy(26,12); write(chr(164),'Thanks For Playing',chr(164));
          delay(2000);
          donewincrt;
          end;
begin
     randomize;
     pin:=loadbmp(path+'pin.bmp');
     pinm:=loadbmp(path+'pinmask.bmp');
     frames:=loadbmp(path+'frame.bmp');
     lane:=loadbmp(path+'lane.bmp');
     setfont('Times New Roman',100,0,0,0,0,0);
     txt(10,40,0,color[15],'Loading');
     l:=0;
     setpin;
     intro;
     repeat
     if l=0 then
        begin
        writeln('reset');
        f:=0; pl:=2; x:=120; x1:=142; x2:=142; t1:=0; t2:=0; name[1,10,3]:=0; name[2,10,3]:=0;
        end;
     if l=1 then
        begin
        pl:=2; x:=120+(f*40); x1:=142+(f*40); x2:=142+(f*40); name[1,10,3]:=0; name[2,10,3]:=0;
        end;
     for a:=1 to 10 do
         for b:=1 to 3 do
             begin
             name[1,a,b]:=0;
             name[2,a,b]:=0;
             end;
     menu;
     gotoxy(28,12); write('Enter Number--->');
     readln(a);
     case a of
          1:directions;
          2:game1;
          3:game2;
          4:chart;
          5:load;
          6:l:=0;
          7:stop;
          end;
     until a=-5;
     stop;
end.


