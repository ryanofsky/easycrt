program raining;
uses easycrt,wobjects;

type pman = ^tman;
     tman = object(tobject)
       procedure  print; virtual; 
     end;
     plawyer = ^tlawyer;
     tlawyer = object(tman)
       name:string;
       procedure print; virtual;
       procedure sue; virtual;
       constructor init(nme:string);
     end;

procedure tman.print;
  begin
    writeln('Man');
  end;

procedure tlawyer.print;
  begin
    writeln('Lawyer: ',name);
  end;

procedure tlawyer.sue;
  begin
    writeln('Sue');
  end;

constructor tlawyer.init(nme:string);
  begin
    name:=nme;
  end;

var group:pcollection;
    dude: pman;
    x:integer;

begin

group := new (pcollection);
group^.init(1,1);
group^.insert(new(plawyer,init('0')));
group^.insert(new(plawyer,init('1')));
group^.insert(new(plawyer,init('2')));
group^.insert(new(plawyer,init('3')));
group^.insert(new(plawyer,init('4')));

group^.atinsert(3,new(plawyer,init('A')));

for x:= 0 to group^.count-1 do
  begin
    dude:=group^.at(x);
    dude^.print;
  end;



group^.done;


end.