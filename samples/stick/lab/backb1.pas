{************************************************}
{                                                }
{   Turbo Pascal for Windows                     }
{   Demo program                                 }
{   Copyright (c) 1991 by Borland International  }
{                                                }
{************************************************}

program MyProgram;

uses WinTypes, WinProcs, WObjects, Strings,easycrt;


function pc(strng:string):pchar;
var step1: array[0..1000] of Char;
  begin
    StrPCopy(step1,strng);
    pc:=@step1;
  end;

type
  TMyApplication = object(TApplication)
    procedure InitMainWindow; virtual;
  end;

type
  PMyWindow = ^TMyWindow;
  TMyWindow = object(TWindow)
    TheDC, MemDC, UseDC: HDC;
    ThePen, Oldpen: HPen;
    c: string;
    p: pchar;
    Region: HRGN;
    blank: Hbitmap;
    constructor Init(AParent: PWindowsObject; ATitle: PChar);
    destructor done; virtual;
    procedure WMPaint(var Msg: TMessage); virtual wm_First + wm_Paint;
  end;

constructor Tmywindow.Init(AParent: PWindowsObject; ATitle: PChar);
  begin
    twindow.init(AParent,ATitle);
    blank := LoadBmp('C:\Russ\stick\blank.bmp');
  end;

destructor Tmywindow.done; 
  begin
    deletebmp(blank);
    twindow.done;
  end;

procedure tmywindow.WMPaint(var Msg: TMessage); 
  begin
    defwndproc(msg);
    TheDC := getDC(Hwindow);
    MemDC := CreateCompatibleDC(TheDC);
    REGION:=CreateRectRgn(0,0,200,200);
    Selectobject(MemDC, blank);
    writeln(Region);
    writeln(SelectClipRgn(MemDC,Region));


    UseDC:=MemDC;

    ThePen:=CreatePen(0,5,RGB(0,0,255));
    OldPen:=Selectobject(UseDC,ThePen);

    writeln(ellipse(UseDC,10,10,50,60));
    writeln(textOut(UseDC,30,30,'Hello',5));
    writeln(BitBlt(TheDC,0,0,200,200,MemDC,0,0,SrcCopy));



    writeln(Deleteobject(REGION));
    ThePen:=Selectobject(UseDC,OldPen);
    writeln(DeleteObject(ThePen));
    writeln(DeleteDC(MemDC));
    writeln(ReleaseDC(TheDC, Hwindow));
  end;

procedure TMyApplication.InitMainWindow;
begin
  MainWindow := New(PMyWindow, Init(nil, 'Sample ObjectWindows Program'));
end;
var
  MyApp: TMyApplication;

begin
  MyApp.Init('MyProgram');
  MyApp.Run;
  MyApp.Done;
end.
