uses easycrt;

{draw screen is 624x437}





const
  fps = 4;  
  fframes = 2*fps;        {2 seconds}

type
  fighterprops = record
    xpos,ypos,Tangle,width,height, 
    lkneex,lkneey,rkneex,rkneey,lfootx,lfooty,rfootx,rfooty:integer;
    kick,punch,jump:boolean;
    end;

  pfighter = ^tfighter;
  tfighter = object
    position: fighterprops;
    futurepos: array[1..Fframes] of fighterprops;
    constructor init;
    destructor done; virtual;
    end;  

  constructor tfighter.init;
    begin
    end;

  destructor tfighter.done;
    begin
    end;

  procedure calcnext;
    begin
    end;

type
  pstickman = ^tstickman;
  tstickman = object(tfighter)
    constructor init;
    destructor done; virtual;
    procedure draw; virtual;
    end;

constructor tstickman.init;
  begin
    tfighter.init;
  end;

destructor tstickman.done;
  begin
    tfighter.done;
  end;

procedure tstickman.draw;
  begin
  end;



type

  pfighternode = ^tfighternode;
  tfighternode = record
    fighter: pfighter;
    next: pfighternode
    end;
  pfighterlist = ^tfighterlist;
  tfighterlist = object
    fighters: pfighternode;
    constructor init;
    destructor done; virtual;
    procedure Add(fighter: pfighter);
    procedure dobattle;
    end;

    constructor tfighterlist.init;
      begin
        fighters:=nil;
      end;

    destructor tfighterlist.done;
      var n:pfighternode;
      begin
        while fighters <> nil do
          begin
            n:=fighters;
            fighters:=n^.next;
            dispose(n^.fighter, Done);
            dispose(n);
          end;
      end;

    procedure tfighterlist.add(fighter: pfighter);
      var N: PfighterNode;
      begin
        New(N);
        N^.fighter := fighter;
        N^.Next := fighters;
        Fighters := N;
      end;

    procedure tfighterlist.dobattle;
      var  Current: PfighterNode;
      begin
        Current := Fighters;
        while Current <> nil do
        with Current^.Fighter^ do
        begin
          {draw; }
        end;
        Current := Current^.Next;
    end;

var stickman:tstickman;

begin

setbrush(0,0);

stickman.init;
stickman.position.xpos:=200;
stickman.position.ypos:=300;
stickman.draw;













{
Staff.Add(New(PHourly, Init('Karlon, Allison', 'Fork lift operator',
   12.95, 80)));
}




end.
