program namehere;
uses wincrt;


type pwriter = ^twriter;
     twriter = object
     constructor init;
     procedure saysome; virtual; 
     end;

type ppoet = ^tpoet;
     tpoet = object(twriter)
     constructor init;
     procedure saysome; virtual;
     end;

constructor twriter.init;
  begin
  end;

constructor tpoet.init;
  begin
  end;

procedure twriter.saysome;
  begin
    writeln('It is raining.');
  end;
                                   
procedure tpoet.saysome;
  begin
    writeln('It is raining in Spaining.');
  end;

var poet:tpoet;
    writer:twriter;
    r:pwriter;
     
begin
  poet.init;
  writer.init;
  poet.saysome;

  r:=new





end.