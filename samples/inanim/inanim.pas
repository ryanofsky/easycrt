uses easycrt,easygdi,winprocs;    { winprocs is included for the GetTickCount command below }

const spotspeed = 6;              { This controls how many pixels spot can move in a frame }


var cool: array[1..8] of bmp;                 { array of 8 bitmaps }
    spotx,spoty,spotxx,spotyy,frame:integer;  { spot position and direction variables, spot frame number }
    i:word;                                   { used for keyboard input }
    time,lasttime:longint;                    { used with GetTickCount }
    
begin

  cool[1] := loadbmp(appdir + '\cool1.bmp');  { loads spot bitmap files, frame 1 }
  cool[2] := loadbmp(appdir + '\cool2.bmp');  { loads spot bitmap files, frame 2 }
  cool[3] := loadbmp(appdir + '\cool3.bmp');  { loads spot bitmap files, frame 3 }
  cool[4] := loadbmp(appdir + '\cool4.bmp');  { loads spot bitmap files, frame 4 }
  cool[5] := loadbmp(appdir + '\cool5.bmp');  { loads spot bitmap files, frame 5 }
  cool[6] := loadbmp(appdir + '\cool6.bmp');  { loads spot bitmap files, frame 6 }
  cool[7] := loadbmp(appdir + '\cool7.bmp');  { loads spot bitmap files, frame 7 }
  cool[8] := loadbmp(appdir + '\cool8.bmp');  { loads spot bitmap files, frame 8 }

  initwincrt;                                     { creates and displays EasyCRT window }
  setborder(sysmenu,0);                           { Gets rid of system menu and close box }
  setborder(scrollbar,0);                         { Gets rid of scroll bars }
  setborder(minbox,0);                            { Gets rid of minimize box }
  setborder(maxbox,0);                            { Gets rid of maximize box }
  settitle('Use the Arrow Keys to Move Spot...'); { Sets the EasyCRT window title }
  setbehave(restrictsize,false);                  { No restrictions on window size }

  spotx := getwidth(CRT) div 2;                   { sets initial spot position to } 
  spoty := getheight(CRT) div 2;                  { the middle of the screen      }
  spotxx := 0;                                    { sets initial spot direction   }
  spotyy := 0;                                    { to zero }
  frame := 0;                                     { initalizes lasttime variable  }
  lasttime := 0;                                  

  repeat
    time := gettickcount;                { stores the number of milliseconds windows has
                                           been running into time variable (right click
                                           gettickcount for more info }

    if (time - lasttime > 100) then      { determines whether 100 milliseconds have passed }
      begin                              { since the last spot frame change }
        inc(frame);
        if frame > 8 then frame := 1;
        lasttime := time;
      end;

    i := inkey;                          { stores keyboard input in i }
    case i of
    vk_up:    begin spotxx := 0; spotyy := -spotspeed; end; { responds to keyboard input         }
    vk_down:  begin spotxx := 0; spotyy :=  spotspeed; end; { see help topic 'Virtual Key Codes' }
    vk_right: begin spotyy := 0; spotxx :=  spotspeed; end; { for more info                      }
    vk_left:  begin spotyy := 0; spotxx := -spotspeed; end;
    end;


    inc(spotx,spotxx);                                      { moves spot in current direction }
    inc(spoty,spotyy);

    if (spotx > getwidth(CRT)-getwidth(cool[1])) or (spotx < 0) then spotxx := spotxx * -1;
    if (spoty > getheight(CRT)-getheight(cool[1])) or (spoty < 0) then spotyy := spotyy * -1;
                                                    { reverses spot if he ventures off screen }

    copybmp(cool[frame],CRT,spotx,spoty);           { draws spot at current position }

    delay(30);                                      { delays for 30 milliseconds, releases
                                                      control to other windows programs } 

    setpen(CRT,color[-1],solid,0);                  { sets pen to invisible }
    setbrush(CRT,color[15],color[-1],solid);        { set brush to white    }
    box(CRT,spotx,spoty,spotx+getwidth(cool[1])+1,spoty+getheight(cool[1]),0,0);
                                                    { erases old spot }

  until ldown or rdown or (i=vk_escape);            { loops until mouse button is pressed or
                                                      user hits escape key                  }

  for i := 1 to 8 do killbmp(cool[i]);              { frees spot bitmaps from memory }
  donewincrt;                                       { closes easycrt window }

end.