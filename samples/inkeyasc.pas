uses easycrt,easygdi;

var a: char;

begin
  initwincrt;
  settitle('Type Something!');
  showcursor;

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