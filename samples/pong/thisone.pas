program dump; uses easycrt,winprocs;
var
 a,b,c,arrow_pos,target_pos,menu_pos,skill,players,points:integer;
 s:char;
 button:word;
 colorval:longint;
 players_scores:array[1..2] of integer;

{getpixel(dc,x,y);}

procedure action(total_options:integer);
 begin
  repeat
   pprint(dc,125,menu_pos*30+100,color[1],'-->');
   repeat
    button:=inkey;
   until button <> 0;
   box(125,menu_pos*30+80,149,menu_pos*30+120,1,1);
   if button=38 then
    begin
     if menu_pos=0 then
      menu_pos:=total_options-1
     else menu_pos:=menu_pos-1;
    end
   else if button=40 then
    begin
     if menu_pos=total_options-1 then
      menu_pos:=0
     else menu_pos:=menu_pos+1;
    end;
  until button=13;
 end;

procedure font(col:integer);
 begin
  setfont('Cosmic San MS',col,10,0,0,0,0);
 end;

procedure options;
 begin
  menu_pos:=0;
  repeat
  box(0,0,640,480,1,1);
  setfont('Cosmic San MS',15,10,0,0,0,0);
  pprint(dc,150,100,color[2],'SKILL LEVEL:');
   if skill=1 then
    pprint(dc,265,100,color[2],'EASY')
   else if skill=2 then
    pprint(dc,265,100,color[2],'AVERAGE')
   else pprint(dc,265,100,color[2],'HARD');
  setfont('Cosmic San MS',15,10,0,0,0,0);
  pprint(dc,150,130,color[2],'PLAYERS:');
   if players=1 then
    pprint(dc,235,130,color[2],'ONE')
   else if players=2 then
    pprint(dc,235,130,color[2],'TWO')
   else if players=3 then
    pprint(dc,235,130,color[2],'THREE')
   else pprint(dc,235,130,color[2],'VS. COMPUTER');
  pprint(dc,150,160,color[2],'RETURN TO MAIN');
  action(3);
  case menu_pos of
   0:
     begin
      if skill < 3 then
       skill:=skill+1
      else skill:=1;
     end;
   1:
     begin
      if players < 4 then
       players:=players+1
      else players:=1;
     end;
  end;

  until menu_pos = 2;
 end;

{BEGIN SPRITES}
procedure draw_target(t_pos:integer);
 begin
  setbrush(rgb(0,0,255),0); box(618,350-t_pos,625,415-t_pos,1,1);
  setbrush(rgb(255,255,255),0); box(615,363-t_pos,620,402-t_pos,1,1);
  setbrush(rgb(255,0,0),0); box(611,375-t_pos,616,390-t_pos,1,1);
  setbrush(color[0],0); box(618,416-t_pos,625,416-t_pos,1,1);
  box(615,403-t_pos,620,403-t_pos,1,1);
  box(611,391-t_pos,616,391-t_pos,1,1);
 end;
procedure draw_arrow(a_pos:integer);
 begin
  setfont('Cosmic San MS',25,1,0,0,0,0);
  pprint(dc,50+a_pos-3,60,color[0],'>');
  pprint(dc,0+a_pos-3,60,color[0],'>');
  pprint(dc,6+a_pos-3,60,color[0],'>');
  pprint(dc,12+a_pos-3,60,color[0],'>');
  line(dc,4+a_pos-3,74,5+a_pos,74,color[0],0,1);
  setfont('Cosmic San MS',25,1,0,0,0,0);
  pprint(dc,50+a_pos,60,color[2],'>');            
  pprint(dc,0+a_pos,60,color[2],'>');
  pprint(dc,6+a_pos,60,color[2],'>');
  pprint(dc,12+a_pos,60,color[2],'>');
  line(dc,5+a_pos,74,60+a_pos,74,color[2],0,1);
 end;
{END SPRITES}

procedure game;
 begin
  for a:= 1 to 5 do
   begin
    target_pos:=0;arrow_pos:=0;
    setbrush(color[0],0);
    box(0,0,640,480,1,1);
    setfont('Cosmic San MS',25,5,0,0,0,0);
    draw_target(0);
    draw_arrow(0); 
    repeat until keypressed;readkey;
    repeat
     target_pos:=target_pos+1;
     draw_target(target_pos);
     delay(1);
    until (keypressed) or (target_pos > 430);
    points:=0;
    if target_pos < 430 then
     repeat
      arrow_pos:=arrow_pos+3;
      target_pos:=target_pos+1;
      draw_arrow(arrow_pos);
      draw_target(target_pos);
      delay(1);
      colorval:=getpixel(dc,arrow_pos+65,74);
      if (getbvalue(colorval) =255) and (getrvalue(colorval) = 255) then
       points:=2
      else if getbvalue(colorval) = 255 then
       points:=1
      else if getrvalue(colorval) = 255 then
       points:=3;
     until (arrow_pos+50 > 605) or (points > 0);
    readkey;delay(500);
    box(0,0,640,480,1,1);setfont('Cosmic San MS',40,10,0,0,0,0);
    setfont('Cosmic San MS',40,15,0,0,0,0);
    if points = 1 then
     pprint(dc,65,100,color[1],'1')
    else if points = 2 then
     pprint(dc,65,100,color[1],'2')
    else if points = 3 then
     pprint(dc,65,100,color[1],'3')
    else pprint(dc,65,100,color[1],'0');
    pprint(dc,95,100,color[1],'POINTS');
    repeat until keypressed;readkey;
  end;
 end;


begin
repeat
 players:=1; skill:=1;
 setbrush(color[0],0);
 box(0,0,640,480,1,1);
 font(40);
 {for a:= 1 to 400 do
  begin
   pprint(dc,a-16,228,color[0],'>');
   line(dc,a-200,250,a,250,color[4],0,3);
   line(dc,a-201,250,a-200,250,color[0],0,3);
   pprint(dc,a-15,228,color[4],'>');
   for b:=1 to 10000 do;
  end;
 for a:= 1 to 150 do
  begin
   pprint(dc,200,200,gradient(color[0],color[4],a,150),'ARCHERY');
   delay(1);
  end;
 font(30);
 for a:= 1 to 150 do
  begin
   pprint(dc,280,250,gradient(color[0],color[1],a,150),'By');
   pprint(dc,200,285,gradient(color[0],color[2],a,150),'Robb Ritchey');
   delay(1);
  end;      
 repeat until keypressed;readkey;}
 menu_pos:=0;

 { MENU CODE }

 box(0,0,640,480,1,1);
 setfont('Cosmic San MS',15,10,0,0,0,0);
 pprint(dc,150,100,color[2],'SEE INSTRUCTIONS');
 setfont('Cosmic San MS',15,10,0,0,0,0);
 pprint(dc,150,130,color[2],'OPTIONS');
 pprint(dc,150,160,color[2],'PLAY GAME');
 pprint(dc,150,190,color[2],'SEE HIGH SCORES');
 pprint(dc,150,220,color[2],'QUIT ARCHERY');
 action(5);
 

 { END MENU CODE }

 case menu_pos of
  1:options;
  2:game;
 end;

until menu_pos=4;
end.
