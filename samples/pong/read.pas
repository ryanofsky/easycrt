program readfrmdsk;
uses wincrt;
var a: array[1..10] of integer;
    b: integer;
    x,y,z:string;
    name:string;
    ttt: file of integer;

begin;
randomize;
assign(ttt,'a:\ttt.dat');
reset(ttt);
for b:= 1 to 10 do
read(ttt,a[b]);
close(ttt);

for b := 1 to 10 do
begin;
writeln (a[b]);
end;
end.