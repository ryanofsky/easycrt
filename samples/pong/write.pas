program writ2dsk;
uses wincrt;
var a: array[1..10] of integer;
    b: integer;
    x,y,z:string;
    name:string;
    ttt: file of integer;

begin;
randomize;
for b := 1 to 8 do
begin;
a[b] := random(20);
writeln (a[b]);
end;
readln (a[9]);
readln (a[10]);
assign(ttt,'a:\ttt.dat');
rewrite(ttt);
for b:= 1 to 10 do
write(ttt,a[b]);
close(ttt);
end.