uses easycrt;

var a: char;

begin
  repeat
    repeat
      a:=inkeyasc;
    until (ord(a)<>0) or ldown;
    hidecursor;
    write(a);
    showcursor;
  until ldown;
  donewincrt;
end.