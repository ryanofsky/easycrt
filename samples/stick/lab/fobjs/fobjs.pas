uses wobjects, winprocs, wintypes;

const fps = 5;
      gamespeed = 1;

      fframes = round(2*fps/gamespeed+1);

type tkeys = record
       left,right,up,down,punch,kick:integer;
     end;

type pfprops = ^tfprops;
     tfprops = record
       l1x,l2x,l2y,cx,cy,a1x,a2x,head,size: real;
       x,y,direction: integer;
       jump,walk,punch,kick: boolean;
     end;

type pgenf = ^tgenf;
     tgenf = object(Tobject)
       pos: array [1..fframes] of tfprops;
       keyscodes: tkeys;
       DC: HDC;
       HWindow: Hwnd;
       constructor init;
       destructor done; virtual;
       procedure draw; virtual;
       procedure setdraw(TheDC:HDC; TheWind: Hwnd); virtual;
       procedure advanceframe;
     end;

constructor tgenf.init;
  begin
  end;

destructor tgenf.done;
  begin
  end;

procedure tgenf.draw;
  begin
    messagebox(0,'TGENF.DRAW has been called','StickFighter Error',0);
  end;

procedure tgenf.setdraw(TheDC:HDC; TheWind: Hwnd);
  begin
    DC:=TheDC;
    HWindow:=TheWind;
  end;

procedure tgenf.advanceframe;
  var x: integer;
  begin
    for x:=1 to fframes-1 do
      begin
        pos[x]:=pos[x+1]
      end;
  end;

type pstickman = ^tstickman;
     tstickman = object(tgenf)
       procedure draw; virtual;
     end;

procedure tstickman.draw;
  begin
{   qcircle(DC,pos[1].x,pos[1].y,10,10);      }
  end;

var fpool: pcollection;
    x:integer;
    s: pgenf;

begin

{tcollection}

fpool:=new(pcollection,init(1,1));

s:=new(pstickman,init);


  fpool^.insert(s);           


for x:=0 to fpool^.count-1 do
  begin
    s:=fpool^.at(x);
    s^.draw;
  end;

fpool^.done;

end.