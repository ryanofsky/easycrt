uses wincrt;

var i: integer;

begin
  randomize;
  writeln('Welcome to WinCRT');
  writeln;
  for i := 1 to 15 do
    writeln(random(32000)); 
end.
