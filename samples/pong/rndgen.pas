program writ2dsk;
uses wincrt;
var a: array[1..60] of integer;
    b,C,D,E,F,G,SWAPS:integer;
    TH: ARRAY[1..60] OF INTEGER;
    HU: ARRAY[1..60] OF INTEGER;
    T: ARRAY [1..60] OF INTEGER;
    U: ARRAY [1..60] OF INTEGER;
    x,y,z:string;
    name:string;
    ttt: file of integer;

begin;
randomize;
for b := 1 to 60 do
begin;
a[b] := random(10000);
write (a[b],'  ');
end;
REPEAT;
UNTIL KEYPRESSED;
for C := 1 to 60 do
FOR D := C TO 60 DO
   begin;
     if A[C] > A[D] then
       begin
         swaps:=A[C];  A[C]:=A[D];  A[D]:=swaps;
       end;
   end;

end.