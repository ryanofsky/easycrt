uses easycrt;

var a: integer;

begin
  repeat
    repeat
      unfreeze;
      a:=inkey;
    until (a<>0) or ldown;
    write(a,' ');
  until ldown;
  donewincrt;
end.