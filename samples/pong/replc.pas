program num;
uses wincrt;
var a,b,c,d:integer;
    x,y,z: char;
    s: string;
begin;
readln (S);
CLRSCR;
for a := 1 to (lenGTH(s)) do
    begin;
    x := s[a];
    FOR B := 1 TO (ORD(X) - 64) DO
          begin;
          gotoxy (b+5,A);
          WRITE (x);
          gotoxy (78-b,A);
          write (x);
          end;

end;
end.