uses easycrt;

var a: integer;

begin
  initwincrt;
  settitle('Press a key to see it' +''''+'s virtual key code');

  repeat
    repeat
      a:=inkey;
      unfreeze;
    until (a<>0) or ldown;
    write(a:4);
  until ldown;

  donewincrt;
end.