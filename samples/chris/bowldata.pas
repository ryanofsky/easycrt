program bowldata;
uses wincrt;     
type scores=record
     name:string;
     points:integer;
     end;
var a:integer;
num:file of scores;
score:array[1..7] of scores;
begin
     assign(num,'c:\russ\scifair\samples\chris\nums.dat');
     rewrite(num);
     for a:=1 to 7 do
         with score[a] do 
              begin
              name:='Bob';
              points:=15;
              end;
     for a:=1 to 7 do
         write(num,score[a]);
     close(num);
end.