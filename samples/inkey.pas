uses easycrt;

var a: integer;

begin
  repeat
    repeat
      a:=inkey;
    until (a<>0) or ldown;
    writeln(a);
  until ldown;
  donewincrt;
end.