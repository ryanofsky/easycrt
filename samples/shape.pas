uses easycrt,easygdi;


{

  This program shows you how to use a memory bmp as a buffer for graphics.

  First, it creates a blank bmp in memory that is the same size as the
  EasyCRT window.

  Then, instead of drawing to the screen, it draws to the memory bmp it created

  After that it uses the copybmp command to copy the bmp onto the screen.

    Drawing using this technique can have some advantages. The most important one
  is that it will completely eliminate screen flicker. Normally when you animate
  something, you have to erase it after every step before you can draw the next
  step. It is this erasing and redrawing which causes flicker. When you do everything
  in memory the user never sees the erasing step and there is no flicker.

  The disadvantage of using this technique is that it is slower and it uses up more
  computer resources. It is also very much affected by the windows screen settings.
  It will run much slower in 24 bit color mode than in 8 bit or 16 bit color.
  You can change these settings under Control Panel | Display | Settings | Colors
  if you want to experiment.

  In this program you get to see it both ways. To run it using the buffer technique, set
  the usebuffer constant (below) to true. To see it drawn directly to the screen set
  usebuffer to false. You can also observe the effects of changing the delay time.

  }
   

const NumberOfPoints = 5;     { number of points in the shape }
      maxvelocity = 20;       { maximum speed of a point      }
      usebuffer = true;       { use buffer                    }
      delaytime = 30;         { # of milliseconds to delay between frames }

type tPointsInMotion = record                                { position of points }
    position,velocity: array [1..NumberOfPoints] of points;
  end;


var theshape: tPointsInMotion;                           { position of points }
    i,j,k:integer;                                       { scratch variables }
    buffer:bmp;                                          { buffer bmp variable }
begin
  randomize;                                             { randomizes random numbers }
  initwincrt;                                            { opens easyscrt window }
  settitle('Shape Demo');

  if usebuffer then                          { creates a buffer is usebuffer is true }
    buffer := makeblankbmp(CRT,getwidth(CRT),getheight(CRT))
  else
    buffer := CRT;

  for i := 1 to NumberOfPoints do            { sets random initial positions and speeds }
    begin
      theshape.position[i].x := random(getwidth(buffer));
      theshape.position[i].y := random(getheight(buffer));

      theshape.velocity[i].x := random(maxvelocity*2+1)-maxvelocity;
      theshape.velocity[i].y := random(maxvelocity*2+1)-maxvelocity;
    end; 



  repeat

    for i := 1 to NumberOfPoints do                                  { updates points }
    with theshape do
      begin
        inc(position[i].x,velocity[i].x);
        if (position[i].x > getwidth(buffer)) or (position[i].x < 0) then
          velocity[i].x := velocity[i].x * -1;

        inc(position[i].y,velocity[i].y);
        if (position[i].y > getheight(buffer)) or (position[i].y < 0) then
          velocity[i].y := velocity[i].y * -1;
      end;


    setpen(buffer,color[-1],solid,0);                             { erases last frame }
    setbrush(buffer,color[0],color[0],solid);
    box(buffer,0,0,getwidth(buffer),getheight(buffer),0,0);

    setpen(buffer,color[9],solid,3);                                { draws new shape }
    setbrush(buffer,color[12],color[0],grid);
    shape(buffer,theshape.position,numberofpoints,alternate);

    if usebuffer then copybmp(buffer,CRT,0,0);              { copies buffer to screen }

    delay(delaytime);                                         { delays between frames }

  until ldown or rdown or keypressed;                  { repeats until button pressed }

  if usebuffer then killbmp(buffer);                            { destroys buffer bmp }

  donewincrt;                                                 { closes easycrt window }


end.