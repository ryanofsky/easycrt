program projectile;
uses easycrt;

var Px0, Py0, Px, Py: integer;
    t, velocity, angle, gravity: real;
begin

  { Choose a velocity of around 250 to start off with }

  repeat
    gotoxy(1,2); clreol; gotoxy(1,1); clreol;
    write('Velocity:   '); readln(velocity);   if velocity = 0 then donewincrt;
    write('Angle:      '); readln(angle);

    Px0:=20;       {initial position}
    Py0:=400;
    t:=0;
    gravity:= 150; {acceleration of gravity}
    angle:=angle/180*pi;

    setbrush(color[1],0);

    repeat
      t  := t+0.1;
      Px := round( Px0 + t * velocity * cos(angle) );
      Py := round( Py0 - t * velocity * sin(angle) + gravity / 2 * sqr(t) );
      qcircle(Px,Py,10,10);
      gotoxy(70,1); write('(',px,',',py,')'); clreol;
      if ldown or rdown then donewincrt;
      delay(100);
    until Py > Py0; 
  until 1=2;
end.
