{ EasyCRT v2.01 }

{*******************************************************}
{                                                       }
{       Turbo Pascal for Windows Runtime Library        }
{       Windows CRT Interface Unit                      }
{                                                       }
{       Copyright (c) 1992 Borland International        }
{                                                       }
{*******************************************************}

unit easycrt2;

{$S-}

interface

uses WinTypes, WinProcs, WinDos, Strings, WObjects, easygdi;

const
  WindowOrg: TPoint =                          { CRT window origin }
    (X: cw_UseDefault; Y: cw_UseDefault);
  WindowSize: TPoint =                         { CRT window size }
    (X: cw_UseDefault; Y: cw_UseDefault);
  ScreenSize: TPoint = (X: 80; Y: 29{RWH 25}); { Screen buffer dimensions }
  Cursor: TPoint = (X: 0; Y: 0);               { Cursor location }
  Origin: TPoint = (X: 0; Y: 0);               { Client area origin }
  InactiveTitle: PChar = '%s - Inactive';      { Inactive window title }
  AutoTracking: Boolean = True;                { Track cursor on Write? }
  CheckEOF: Boolean = False;                   { Allow Ctrl-Z for EOF? }
  CheckBreak: Boolean = True;                  { Allow Ctrl-C for break? }

type
     Points = record
       x: Integer;
       y: Integer;
     end;

var
  WindowTitle: array[0..79] of Char;        { CRT window title }
  h:integer;
  Mouse: array [0..2] of integer;
  MouseLocO, MouseLocF: points;

procedure InitWinCrt;
procedure DoneWinCrt;

procedure WriteBuf(Buffer: PChar; Count: Word);
procedure WriteChar(Ch: Char);

function KeyPressed: Boolean;
function ReadKey: Char;
function ReadBuf(Buffer: PChar; Count: Word): Word;

procedure GotoXY(X, Y: Integer);
function WhereX: Integer;
function WhereY: Integer;
procedure ClrScr;
procedure ClrEol;

procedure CursorTo(X, Y: Integer);
procedure ScrollTo(X, Y: Integer);
procedure TrackCursor;

procedure AssignCrt(var F: Text);


{   <RUSS>    }
type HDC = THandle;
     BMP = THandle;

var DC:HDC;
    ThePen: HPen;
    OldPen: HPen;
    PrpPen: TLogPen;
    TheBrush: HBrush;
    OldBrush: HBrush;
    PrpBrush:TLogBrush;
    TheFont: HFont;
    OldFont: HFont;
    PrpFont: TLogFont;
    ink: word;
procedure InitDeviceContext;
procedure DoneDeviceContext;
function initdraw:HDC;
procedure stopdraw;
function rgb2(red,green,blue:longint):longint;
function getred(color:longint):integer;
function getgreen(color:longint):integer;
function getblue(color:longint):integer;
function gradient(color1,color2:longint; stepno,steps:integer):longint;
procedure settitle(lbl:string);
procedure circle(DC:HDC; xpos,ypos,radiusw,radiush:integer; color:longint;  linestyle,width:integer);
procedure line(DC:HDC; x1,y1,x2,y2:integer; color:longint;  linestyle,width:integer);
procedure pprint(DC:HDC; x,y:integer;  color:longint; txt:string);
procedure txt(x,y,align:integer; color:longint; txt:string);
procedure setfont(fontface:string; size,weight,italic,underline,strikeout:integer;angle:real );
procedure setpen(color: longint; linestyle, width: integer);
procedure setbrush(color:longint; style:integer);
procedure qline(x1,y1,x2,y2:integer);
procedure qcircle(xpos,ypos,radiusw,radiush:integer);
procedure qarc(xpos,ypos,radiusw,radiush,angle1,angle2,way:integer);
procedure pset(xpos,ypos: integer; color:longint);
function pixel(xpos,ypos:integer):longint;
procedure fill(xpos,ypos:integer; colorinfo:longint; filltype:integer);
procedure connectdots(var pointarray:points; count:integer);
procedure shape(var pointarray:points; count,method: integer);
procedure box(x1,y1,x2,y2,x3,y3:integer);
procedure drawpicture(DC:HDC; x,y:integer; filename:string);
function loadbmp(filename:string):BMP;
procedure drawbmp(x,y: integer;  bmpname: bmp;  stretched,width,height:integer);
procedure deletebmp(var thebmp:bmp);
function getwidth(thebmp:bmp):integer;
function getheight(thebmp:bmp):integer;
procedure maskbmp(x,y: integer;  themask,thepic: bmp;  stretched,wth,ht:integer);
procedure fullscreen;
procedure windowscreen;
procedure delay(milliseconds:real);
procedure unfreeze;
function inkey:word;
function inkeyasc:char;
function pc(st: string): pchar;

{Garett}
type image = record
    size:points;
    pts:array[0..100,0..100] of longint;
end;
var
   bx:image;

procedure GetBkup(xx,yy,xm,ym:integer);
procedure PutBkup(xx,yy:integer);
function TheDC:HDC;
function Min(X, Y: longint): longint;
function Max(X, Y: longint): longint;
const
     key_pgup:integer = 33;
     key_pgdn:integer = 34;
     key_end:integer = 35;
     key_home:integer = 36;
     key_left:integer = 37;
     key_up:integer = 38;
     key_right:integer = 39;
     key_down:integer = 40;
     key_insert:integer = 45;
     key_delete:integer = 46;
     key_let:integer = 65;
     key_number:integer = 48;
{/Garett}

const
  color: array[-1..15] of longint = (
      -1                              ,   {color -1 Transparent   }
      0 + (256 *   0) + (65536 *   0) ,   {color 0  Black         }
      0 + (256 *   0) + (65536 * 170) ,   {color 1  Blue          }
      0 + (256 * 170) + (65536 *   0) ,   {color 2  Green         }
      0 + (256 * 170) + (65536 * 170) ,   {color 3  Cyan          }
    170 + (256 *   0) + (65536 *   0) ,   {color 4  Red           }
    170 + (256 *   0) + (65536 * 170) ,   {color 5  Magenta       }
    170 + (256 *  85) + (65536 *   0) ,   {color 6  Brown         }
    170 + (256 * 170) + (65536 * 170) ,   {color 7  White         }
     85 + (256 *  85) + (65536 *  85) ,   {color 8  Gray          }
     85 + (256 *  85) + (65536 * 255) ,   {color 9  Light Blue    }
     85 + (256 * 255) + (65536 *  85) ,   {color 10 Light Green   }  
     85 + (256 * 255) + (65536 * 255) ,   {color 11 Light Cyan    }
    255 + (256 *  85) + (65536 *  85) ,   {color 12 Light Red     }
    255 + (256 *  85) + (65536 * 255) ,   {color 13 Light Magenta }
    255 + (256 * 255) + (65536 *  85) ,   {color 14 Yellow        }
    255 + (256 * 255) + (65536 * 255) );  {color 15 Bright White  }
{   </RUSS>    }

implementation

{ Double word record }

type
  LongRec = record
    Lo, Hi: Integer;
  end;

{ MinMaxInfo array }

type
  PMinMaxInfo = ^TMinMaxInfo;
  TMinMaxInfo = array[0..4] of TPoint;

{ Scroll key definition record }

type
  TScrollKey = record
    Key: Byte;
    Ctrl: Boolean;
    SBar: Byte;
    Action: Byte;
  end;

{Garett2}
procedure GetBkup(xx,yy,xm,ym:integer);
var y,x:integer;
begin
     bx.size.x:=xm;
     bx.size.y:=ym;
     for y:=1 to 100 do
          for x:=1 to 100 do
              bx.pts[x,y]:=0;
     for y:=yy to yy+Min(100,ym) do
          for x:=xx to xx+Min(100,xm) do
              bx.pts[x-xx,y-yy]:=GetPixel(TheDC,x,y);
end;

procedure PutBkup(xx,yy:integer);
var y,x:integer;
begin
     for y:=yy to yy+bx.size.y do
          for x:=xx to xx+bx.size.x do
              SetPixel(TheDC,x,y,bx.pts[x-xx,y-yy]);
end;
{/Garett2}

{ CRT window procedure }

function CrtWinProc(Window: HWnd; Message, WParam: Word;
  LParam: Longint): Longint; export; forward;

{ CRT window class }

const
  CrtClass: TWndClass = (
    style: cs_HRedraw + cs_VRedraw;
    lpfnWndProc: @CrtWinProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'TPWinCrt');

const
  CrtWindow: HWnd = 0;                  { CRT window handle }
  FirstLine: Integer = 0;               { First line in circular buffer }
  KeyCount: Integer = 0;                { Count of keys in KeyBuffer }
  Created: Boolean = False;       	{ CRT window created3? }
  Focused: Boolean = False;             { CRT window focused? }
  Reading: Boolean = False;             { Reading from CRT window? }
  Painting: Boolean = False;            { Handling wm_Paint? }

var
  SaveExit: Pointer;                    { Saved exit procedure pointer }
  ScreenBuffer: PChar;                  { Screen buffer pointer }
  ClientSize: TPoint;                   { Client area dimensions }
  Range: TPoint;                        { Scroll bar ranges }
  CharSize: TPoint;                     { Character cell size }
  CharAscent: Integer;                  { Character ascent }
{RWH  DC: HDC;}                         { Global device context }
  PS: TPaintStruct;                     { Global paint structure }
  SaveFont: HFont;                      { Saved device context font }
  KeyBuffer: array[0..63] of Char;      { Keyboard type-ahead buffer }

{ Scroll keys table }

const
  ScrollKeyCount = 12;
  ScrollKeys: array[1..ScrollKeyCount] of TScrollKey = (
    (Key: vk_Left;  Ctrl: False; SBar: sb_Horz; Action: sb_LineUp),
    (Key: vk_Right; Ctrl: False; SBar: sb_Horz; Action: sb_LineDown),
    (Key: vk_Left;  Ctrl: True;  SBar: sb_Horz; Action: sb_PageUp),
    (Key: vk_Right; Ctrl: True;  SBar: sb_Horz; Action: sb_PageDown),
    (Key: vk_Home;  Ctrl: False; SBar: sb_Horz; Action: sb_Top),
    (Key: vk_End;   Ctrl: False; SBar: sb_Horz; Action: sb_Bottom),
    (Key: vk_Up;    Ctrl: False; SBar: sb_Vert; Action: sb_LineUp),
    (Key: vk_Down;  Ctrl: False; SBar: sb_Vert; Action: sb_LineDown),
    (Key: vk_Prior; Ctrl: False; SBar: sb_Vert; Action: sb_PageUp),
    (Key: vk_Next;  Ctrl: False; SBar: sb_Vert; Action: sb_PageDown),
    (Key: vk_Home;  Ctrl: True;  SBar: sb_Vert; Action: sb_Top),
    (Key: vk_End;   Ctrl: True;  SBar: sb_Vert; Action: sb_Bottom));

{ Return the smaller of two integer values }

function Min(X, Y: longint): longint;
begin
  if X < Y then Min := X else Min := Y;
end;

{ Return the larger of two integer values }
function Max(X, Y: longint): longint;
begin
  if X > Y then Max := X else Max := Y;
end;

{ Allocate device context }

procedure InitDeviceContext;
begin
  if Painting then
    begin
      ReleaseDC(CrtWindow, DC);
      DC := BeginPaint(CrtWindow, PS)
    end;
{RWH
  if Painting then
    DC := BeginPaint(CrtWindow, PS) else
    DC := GetDC(CrtWindow);
}
  SaveFont := SelectObject(DC, GetStockObject(System_Fixed_Font));


end;

{ Release device context }

procedure DoneDeviceContext;
begin
  SelectObject(DC, SaveFont);
  if Painting then
    begin
      EndPaint(CrtWindow, PS);
      DC:=GetDC(CrtWindow);
      selectobject(DC, Thepen);
      selectobject(DC, Thebrush);
    end;
{RWH
   if Painting then
    EndPaint(CrtWindow, PS) else
    ReleaseDC(CrtWindow, DC);
}
end;

{ Show caret }

procedure ShowCursor;
begin
  CreateCaret(CrtWindow, 0, CharSize.X, 2);
  SetCaretPos((Cursor.X - Origin.X) * CharSize.X,
    (Cursor.Y - Origin.Y) * CharSize.Y + CharAscent);
  ShowCaret(CrtWindow);
end;

{ Hide caret }

procedure HideCursor;
begin
  DestroyCaret;
end;

{ Update scroll bars }

procedure SetScrollBars;
begin
  SetScrollRange(CrtWindow, sb_Horz, 0, Max(1, Range.X), False);
  SetScrollPos(CrtWindow, sb_Horz, Origin.X, True);
  SetScrollRange(CrtWindow, sb_Vert, 0, Max(1, Range.Y), False);
  SetScrollPos(CrtWindow, sb_Vert, Origin.Y, True);
end;

{ Terminate CRT window }

procedure Terminate;
begin
  if Focused and Reading then HideCursor;
  Halt(255);
end;

{ Set cursor position }

procedure CursorTo(X, Y: Integer);
begin
  Cursor.X := Max(0, Min(X, ScreenSize.X - 1));
  Cursor.Y := Max(0, Min(Y, ScreenSize.Y - 1));
end;

{ Scroll window to given origin }

procedure ScrollTo(X, Y: Integer);
begin
  if Created then
  begin
    X := Max(0, Min(X, Range.X));
    Y := Max(0, Min(Y, Range.Y));
    if (X <> Origin.X) or (Y <> Origin.Y) then
    begin
      if X <> Origin.X then SetScrollPos(CrtWindow, sb_Horz, X, True);
      if Y <> Origin.Y then SetScrollPos(CrtWindow, sb_Vert, Y, True);
      ScrollWindow(CrtWindow,
	(Origin.X - X) * CharSize.X,
	(Origin.Y - Y) * CharSize.Y, nil, nil);
      Origin.X := X;
      Origin.Y := Y;
      UpdateWindow(CrtWindow);
    end;
  end;
end;

{ Scroll to make cursor visible }

procedure TrackCursor;
begin
  ScrollTo(Max(Cursor.X - ClientSize.X + 1, Min(Origin.X, Cursor.X)),
    Max(Cursor.Y - ClientSize.Y + 1, Min(Origin.Y, Cursor.Y)));
end;

{ Return pointer to location in screen buffer }

function ScreenPtr(X, Y: Integer): PChar;
begin
  Inc(Y, FirstLine);
  if Y >= ScreenSize.Y then Dec(Y, ScreenSize.Y);
  ScreenPtr := @ScreenBuffer[Y * ScreenSize.X + X];
end;

{ Update text on cursor line }

procedure ShowText(L, R: Integer);
begin
  if L < R then
  begin
    InitDeviceContext;
    TextOut(DC, (L - Origin.X) * CharSize.X,
      (Cursor.Y - Origin.Y) * CharSize.Y,
      ScreenPtr(L, Cursor.Y), R - L);
    DoneDeviceContext;
  end;
end;

{ Write text buffer to CRT window }

procedure WriteBuf(Buffer: PChar; Count: Word);
var
  L, R: Integer;

procedure NewLine;
begin
  ShowText(L, R);
  L := 0;
  R := 0;
  Cursor.X := 0;
  Inc(Cursor.Y);
  if Cursor.Y = ScreenSize.Y then
  begin
    Dec(Cursor.Y);
    Inc(FirstLine);
    if FirstLine = ScreenSize.Y then FirstLine := 0;
    FillChar(ScreenPtr(0, Cursor.Y)^, ScreenSize.X, ' ');
    ScrollWindow(CrtWindow, 0, -CharSize.Y, nil, nil);
    UpdateWindow(CrtWindow);
  end;
end;

begin
  InitWinCrt;
  L := Cursor.X;
  R := Cursor.X;
  while Count > 0 do
  begin
    case Buffer^ of
      #32..#255:
	begin
	  ScreenPtr(Cursor.X, Cursor.Y)^ := Buffer^;
	  Inc(Cursor.X);
	  if Cursor.X > R then R := Cursor.X;
	  if Cursor.X = ScreenSize.X then NewLine;
	end;
      #13:
	NewLine;
      #8:
	if Cursor.X > 0 then
	begin
	  Dec(Cursor.X);
	  ScreenPtr(Cursor.X, Cursor.Y)^ := ' ';
	  if Cursor.X < L then L := Cursor.X;
	end;
      #7:
        MessageBeep(0);
    end;
    Inc(Buffer);
    Dec(Count);
  end;
  ShowText(L, R);
  if AutoTracking then TrackCursor;
end;

{ Write character to CRT window }

procedure WriteChar(Ch: Char);
begin
  WriteBuf(@Ch, 1);
end;

{ Return keyboard status }

function KeyPressed: Boolean;
var
  M: TMsg;
begin
  InitWinCrt;
  while PeekMessage(M, 0, 0, 0, pm_Remove) do
  begin
    if M.Message = wm_Quit then Terminate;
    TranslateMessage(M);
    DispatchMessage(M);
  end;
  KeyPressed := KeyCount > 0;
end;

{ Read key from CRT window }

function ReadKey: Char;
begin
  TrackCursor;
  if not KeyPressed then
  begin
    Reading := True;
    if Focused then ShowCursor;
    repeat until KeyPressed;
    if Focused then HideCursor;
    Reading := False;
  end;
  ReadKey := KeyBuffer[0];
  Dec(KeyCount);
  Move(KeyBuffer[1], KeyBuffer[0], KeyCount);
end;

{ Read text buffer from CRT window }

function ReadBuf(Buffer: PChar; Count: Word): Word;
var
  Ch: Char;
  I: Word;
begin
  I := 0;
  repeat
    Ch := ReadKey;
    case Ch of
      #8:
	if I > 0 then
	begin
	  Dec(I);
	  WriteChar(#8);
	end;
      #32..#255:
	if I < Count - 2 then
	begin
	  Buffer[I] := Ch;
	  Inc(I);
	  WriteChar(Ch);
	end;
    end;
  until (Ch = #13) or (CheckEOF and (Ch = #26));
  Buffer[I] := Ch;
  Inc(I);
  if Ch = #13 then
  begin
    Buffer[I] := #10;
    Inc(I);
    WriteChar(#13);
  end;
  TrackCursor;
  ReadBuf := I;
end;

{ Set cursor position }

procedure GotoXY(X, Y: Integer);
begin
  CursorTo(X - 1, Y - 1);
end;

{ Return cursor X position }

function WhereX: Integer;
begin
  WhereX := Cursor.X + 1;
end;

{ Return cursor Y position }

function WhereY: Integer;
begin
  WhereY := Cursor.Y + 1;
end;

{ Clear screen }

procedure ClrScr;
begin
  InitWinCrt;
  FillChar(ScreenBuffer^, ScreenSize.X * ScreenSize.Y, ' ');
  Longint(Cursor) := 0;
  Longint(Origin) := 0;
  SetScrollBars;
  InvalidateRect(CrtWindow, nil, True);
  UpdateWindow(CrtWindow);
end;

{ Clear to end of line }

procedure ClrEol;
begin
  InitWinCrt;
  FillChar(ScreenPtr(Cursor.X, Cursor.Y)^, ScreenSize.X - Cursor.X, ' ');
  ShowText(Cursor.X, ScreenSize.X);
end;

{ wm_Create message handler }

procedure WindowCreate;
begin
  Created := True;
  GetMem(ScreenBuffer, ScreenSize.X * ScreenSize.Y);
  FillChar(ScreenBuffer^, ScreenSize.X * ScreenSize.Y, ' ');
  if not CheckBreak then
    EnableMenuItem(GetSystemMenu(CrtWindow, False), sc_Close,
      mf_Disabled + mf_Grayed);
end;

{ wm_Paint message handler }

procedure WindowPaint;
var
  X1, X2, Y1, Y2: Integer;
  a:string;
begin
  Painting := True;
  InitDeviceContext;
  X1 := Max(0, PS.rcPaint.left div CharSize.X + Origin.X);
  X2 := Min(ScreenSize.X,
    (PS.rcPaint.right + CharSize.X - 1) div CharSize.X + Origin.X);
  Y1 := Max(0, PS.rcPaint.top div CharSize.Y + Origin.Y);
  Y2 := Min(ScreenSize.Y,
    (PS.rcPaint.bottom + CharSize.Y - 1) div CharSize.Y + Origin.Y);
  a:=' ';
  while Y1 < Y2 do
  begin
    if ScreenPtr(X1,Y1) <> @a then TextOut(DC, (X1 - Origin.X) * CharSize.X, (Y1 - Origin.Y) * CharSize.Y,
         ScreenPtr(X1, Y1), X2 - X1);
    Inc(Y1);
  end;
  DoneDeviceContext;
  Painting := False;
end;

{ wm_VScroll and wm_HScroll message handler }

procedure WindowScroll(Which, Action, Thumb: Integer);
var
  X, Y: Integer;

function GetNewPos(Pos, Page, Range: Integer): Integer;
begin
  case Action of
    sb_LineUp: GetNewPos := Pos - 1;
    sb_LineDown: GetNewPos := Pos + 1;
    sb_PageUp: GetNewPos := Pos - Page;
    sb_PageDown: GetNewPos := Pos + Page;
    sb_Top: GetNewPos := 0;
    sb_Bottom: GetNewPos := Range;
    sb_ThumbPosition: GetNewPos := Thumb;
  else
    GetNewPos := Pos;
  end;
end;

begin
  X := Origin.X;
  Y := Origin.Y;
  case Which of
    sb_Horz: X := GetNewPos(X, ClientSize.X div 2, Range.X);
    sb_Vert: Y := GetNewPos(Y, ClientSize.Y, Range.Y);
  end;
  ScrollTo(X, Y);
end;

{ wm_Size message handler }

procedure WindowResize(X, Y: Integer);
begin
  if Focused and Reading then HideCursor;
  ClientSize.X := X div CharSize.X;
  ClientSize.Y := Y div CharSize.Y;
  Range.X := Max(0, ScreenSize.X - ClientSize.X);
  Range.Y := Max(0, ScreenSize.Y - ClientSize.Y);
  Origin.X := Min(Origin.X, Range.X);
  Origin.Y := Min(Origin.Y, Range.Y);
  SetScrollBars;
  if Focused and Reading then ShowCursor;
end;

{ wm_GetMinMaxInfo message handler }

procedure WindowMinMaxInfo(MinMaxInfo: PMinMaxInfo);
var
  X, Y: Integer;
  Metrics: TTextMetric;
begin
  InitDeviceContext;
  GetTextMetrics(DC, Metrics);
  CharSize.X := Metrics.tmMaxCharWidth;
  CharSize.Y := Metrics.tmHeight + Metrics.tmExternalLeading;
  CharAscent := Metrics.tmAscent;
  X := Min(ScreenSize.X * CharSize.X + GetSystemMetrics(sm_CXVScroll),
    GetSystemMetrics(sm_CXScreen)) + GetSystemMetrics(sm_CXFrame) * 2;
  Y := Min(ScreenSize.Y * CharSize.Y + GetSystemMetrics(sm_CYHScroll) +
    GetSystemMetrics(sm_CYCaption), GetSystemMetrics(sm_CYScreen)) +
    GetSystemMetrics(sm_CYFrame) * 2;
  MinMaxInfo^[1].x := X;
  MinMaxInfo^[1].y := Y;
  MinMaxInfo^[3].x := CharSize.X * 16 + GetSystemMetrics(sm_CXVScroll) +
    GetSystemMetrics(sm_CXFrame) * 2;
  MinMaxInfo^[3].y := CharSize.Y * 4 + GetSystemMetrics(sm_CYHScroll) +
    GetSystemMetrics(sm_CYFrame) * 2 + GetSystemMetrics(sm_CYCaption);
  MinMaxInfo^[4].x := X;
  MinMaxInfo^[4].y := Y;
  DoneDeviceContext;
end;

{ wm_Char message handler }

procedure WindowChar(Ch: Char);
begin
  if CheckBreak and (Ch = #3) then Terminate;
  if KeyCount < SizeOf(KeyBuffer) then
  begin
    KeyBuffer[KeyCount] := Ch;
    Inc(KeyCount);
  end;
end;

{ wm_KeyDown message handler }

procedure WindowKeyDown(KeyDown: Byte);
var
  CtrlDown: Boolean;
  I: Integer;
begin
  if CheckBreak and (KeyDown = vk_Cancel) then Terminate;
  CtrlDown := GetKeyState(vk_Control) < 0;
  for I := 1 to ScrollKeyCount do
    with ScrollKeys[I] do
      if (Key = KeyDown) and (Ctrl = CtrlDown) then
      begin
       {WindowScroll(SBar, Action, 0); }
	Exit;
      end;
end;

{ wm_SetFocus message handler }

procedure WindowSetFocus;
begin
  Focused := True;
  if Reading then ShowCursor;
end;

{ wm_KillFocus message handler }

procedure WindowKillFocus;
begin
  if Reading then HideCursor;
  Focused := False;
end;

{ wm_Destroy message handler }

procedure WindowDestroy;
begin
  FreeMem(ScreenBuffer, ScreenSize.X * ScreenSize.Y);
  Longint(Cursor) := 0;
  Longint(Origin) := 0;
  PostQuitMessage(0);
  Created := False;
end;

{ CRT window procedure }

function CrtWinProc(Window: HWnd; Message, WParam: Word;
  LParam: Longint): Longint;
begin
  CrtWinProc := 0;
  CrtWindow := Window;
  case Message of
    {Garett}
    wm_LButtonDown:
    begin
         Mouse[0]:=1;
         MouseLocO.x:=LOWORD(lparam);
         MouseLocO.y:=HIWORD(lparam);
    end;
    wm_LButtonUp:
    begin
         Mouse[0]:=0;
         MouseLocF.x:=LOWORD(lparam);
         MouseLocF.y:=HIWORD(lparam);
    end;
    {/Garett}
    wm_Create: WindowCreate;
    wm_Paint: WindowPaint;
    wm_VScroll: WindowScroll(sb_Vert, WParam, LongRec(LParam).Lo);
    wm_HScroll: WindowScroll(sb_Horz, WParam, LongRec(LParam).Lo);
    wm_Size: WindowResize(LongRec(LParam).Lo, LongRec(LParam).Hi);
    wm_GetMinMaxInfo: WindowMinMaxInfo(PMinMaxInfo(LParam));
    wm_Char: WindowChar(Char(WParam));
    wm_KeyDown: begin ink:=wParam; WindowKeyDown(Byte(WParam)); end;
    wm_SetFocus: WindowSetFocus;
    wm_KillFocus: WindowKillFocus;
    wm_Destroy: WindowDestroy;
  else
    CrtWinProc := DefWindowProc(Window, Message, WParam, LParam);
  end;
end;

{ Text file device driver output function }

function CrtOutput(var F: TTextRec): Integer; far;
begin
  if F.BufPos <> 0 then
  begin
    WriteBuf(PChar(F.BufPtr), F.BufPos);
    F.BufPos := 0;
    KeyPressed;
  end;
  CrtOutput := 0;
end;

{ Text file device driver input function }

function CrtInput(var F: TTextRec): Integer; far;
begin
  F.BufEnd := ReadBuf(PChar(F.BufPtr), F.BufSize);
  F.BufPos := 0;
  CrtInput := 0;
end;

{ Text file device driver close function }

function CrtClose(var F: TTextRec): Integer; far;
begin
  CrtClose := 0;
end;

{ Text file device driver open function }

function CrtOpen(var F: TTextRec): Integer; far;
begin
  if F.Mode = fmInput then
  begin
    F.InOutFunc := @CrtInput;
    F.FlushFunc := nil;
  end else
  begin
    F.Mode := fmOutput;
    F.InOutFunc := @CrtOutput;
    F.FlushFunc := @CrtOutput;
  end;
  F.CloseFunc := @CrtClose;
  CrtOpen := 0;
end;

{ Assign text file to CRT device }

procedure AssignCrt(var F: Text);
begin
  with TTextRec(F) do
  begin
    Handle := $FFFF;
    Mode := fmClosed;
    BufSize := SizeOf(Buffer);
    BufPtr := @Buffer;
    OpenFunc := @CrtOpen;
    Name[0] := #0;
  end;
end;

{ Create CRT window if required }

procedure InitWinCrt;
begin
  if not Created then
  begin
    CrtWindow := CreateWindow(
      CrtClass.lpszClassName,
      WindowTitle,
      ws_maximize + ws_OverlappedWindow + ws_HScroll + ws_VScroll
{RWH} + CS_BYTEALIGNCLIENT + CS_SAVEBITS,
      WindowOrg.X, WindowOrg.Y,
      WindowSize.X, WindowSize.Y,
      0,
      0,
      HInstance,
      nil);
    ShowWindow(CrtWindow, 5{RWH CmdShow});
    UpdateWindow(CrtWindow);
{    DC:=getDC(CrtWindow); }
  end;
end;

{ Destroy CRT window if required }

procedure DoneWinCrt;
begin
{RWH}
  deleteobject(ThePen);
  deleteobject(OldPen);
  deleteobject(TheBrush);
  deleteobject(OldBrush);
  if Created then DestroyWindow(CrtWindow);
  Halt(0);
end;

{ WinCrt unit exit procedure }

procedure ExitWinCrt; far;
var
  P: PChar;
  Message: TMsg;
  Title: array[0..127] of Char;
begin
  ExitProc := SaveExit;
  if Created and (ErrorAddr = nil) then
  begin
    P := WindowTitle;
    WVSPrintF(Title, InactiveTitle, P);
    SetWindowText(CrtWindow, Title);
    EnableMenuItem(GetSystemMenu(CrtWindow, True), sc_Close, mf_Enabled);
    CheckBreak := False;
 {RWH}
    deleteobject(ThePen);
    deleteobject(OldPen);
    deleteobject(TheBrush);
    deleteobject(OldBrush);
    ReleaseDC(CrtWindow, DC);
    while GetMessage(Message, 0, 0, 0) do
    begin
      TranslateMessage(Message);
      DispatchMessage(Message);
    end;
  end;
end;

{   <RUSS>    }

function initdraw:HDC;
  begin
    initdraw:=DC;
  end;

procedure stopdraw;
  begin
  end;

function pc(st: string): pchar;
  var p: array[0..1024] of char;
  begin
    strpcopy(p,st);
    pc := @p;
  end;


procedure settitle(lbl:string);
begin
  SetWindowText(CrtWindow, pc(lbl));
  StrCopy(WindowTitle, pc(lbl))
end;

function rgb2(red,green,blue:longint):longint;
  begin
    if red>255 then red:=red mod 255;
    if green>255 then green:=green mod 255;
    if blue>255 then blue:=blue mod 255;
    rgb2:=red+(256*green)+(65536*blue);
  end;

function getred(color:longint):integer;
var green,blue: integer;
  begin
    {rgb:=red+(256*green)+(65536*blue);}
    blue:=color div 65536;
    green:=(color-blue*65536) div 256;
    getred:=color-65536*blue-256*green;
  end;

function getgreen(color:longint):integer;
var blue: integer;
  begin
    {rgb:=red+(256*green)+(65536*blue);}
    blue:=color div 65536;
    getgreen:=(color-(blue*65536)) div 256;
  end;

function getblue(color:longint):integer;
var blue: integer;
  begin
    blue:=color div 65536;
    getblue:=blue;
  end;

function gradient(color1,color2:longint; stepno,steps:integer):longint;
var rd,grn,blu: integer;
  begin
    rd:=round((stepno*(getred(color2)-getred(color1))) / steps);
    grn:=round((stepno*(getgreen(color2)-getgreen(color1))) / steps);
    blu:=round((stepno*(getblue(color2)-getblue(color1))) / steps);
    gradient:=rgb2(rd+getred(color1),grn+getgreen(color1),blu+getblue(color1));
  end;

procedure circle(DC:HDC; xpos,ypos,radiusw,radiush:integer; color:longint;  linestyle,width:integer);
var x1,y1,x2,y2:integer;
  begin
    x1:=xpos-radiusw;  y1:=ypos-radiush;  x2:=xpos+radiusw;  y2:=ypos+radiush;
    ThePen := CreatePen(linestyle, width, color);
    OldPen := SelectObject(DC, ThePen);
    Ellipse(DC, X1,Y1,X2,Y2);
    ThePen:=SelectObject(DC, OldPen);
    DeleteObject(ThePen);
    ThePen:=OldPen;
  end;

procedure line(DC:HDC; x1,y1,x2,y2:integer; color:longint;  linestyle,width:integer);
var ends:array[1..2] of tpoint;
  begin
    ends[1].x:=x1;  ends[1].y:=y1;  ends[2].x:=x2;  ends[2].y:=y2;
    ThePen := CreatePen(linestyle, width, color);
    OldPen := SelectObject(DC, ThePen);
    polyline(DC,ends,2);
    ThePen:=SelectObject(DC, OldPen);
    DeleteObject(ThePen);
    ThePen:=OldPen;
  end;

procedure txt(x,y,align:integer; color:longint; txt:string);
var aln,lng:integer;
  begin
    case align of
      1: aln:=TA_LEFT;
      2: aln:=TA_RIGHT;
      3: aln:=TA_CENTER;
      end;
    lng:=length(txt);
    TheFont := CreateFontIndirect(PrpFont);
    OldFont := SelectObject(DC, TheFont);
    settextalign(DC,aln);
    setbkmode(DC,1);  settextcolor(DC,color); textout(DC,x,y,pc(txt),lng); settextcolor(DC,0);
    TheFont:=SelectObject(DC, OldFont);
    DeleteObject(TheFont);
    TheFont:=OldFont;
  end;

procedure pprint(DC:HDC; x,y:integer;  color:longint; txt:string);
var lng:integer;
  begin
    lng:=length(txt);
    TheFont := CreateFontIndirect(PrpFont);
    OldFont := SelectObject(DC, TheFont);
    setbkmode(DC,1);  settextcolor(DC,color); textout(DC,x,y,pc(txt),lng); settextcolor(DC,0);
    TheFont:=SelectObject(DC, OldFont);
    DeleteObject(TheFont);
    TheFont:=OldFont;
  end;

procedure setfont(fontface:string; size,weight,italic,underline,strikeout:integer;angle:real );
  begin
    PrpFont.lfHeight         := -1*size;
    PrpFont.lfWidth          := 0;
    PrpFont.lfEscapement     := round(angle*10);
    PrpFont.lfWeight         := weight*100;
    PrpFont.lfItalic         := byte(italic);
    PrpFont.lfUnderline      := byte(underline);
    PrpFont.lfStrikeout      := byte(strikeout);
{   PrpFont.lfcharset }
{   PrpFont.lfOutprecision   := OUT_TT_PRECIS; }
    PrpFont.lfQuality        := PROOF_QUALITY;
    PrpFont.lfPitchAndFamily := DEFAULT_PITCH or FF_DONTCARE;
    StrCopy(Prpfont.lfFaceName,pc(fontface));
  end;

procedure setpen(color: longint; linestyle, width: integer);
  begin
    if color <> -1 then
      ThePen := CreatePen(linestyle, width, color)
    else
    ThePen := CreatePen(PS_NULL,width,0);
    oldpen:=selectobject(DC,ThePen);
    deleteobject(oldpen);
  end;

procedure setbrush(color:longint; style: integer);
var brushstyle: tlogbrush;
  begin
    if color=-1 then
      begin
        brushstyle.lbstyle:=BS_HOLLOW;
        thebrush:=CreateBrushIndirect(brushstyle);
      end
    else
      if style=0 then
        begin
          brushstyle.lbstyle:=BS_SOLID;
          brushstyle.lbcolor:=color;
          thebrush:=CreateBrushIndirect(brushstyle);
        end
      else
        thebrush:=createhatchbrush(style-1,color);;
    oldbrush:=selectobject(DC,thebrush);
    deleteobject(oldbrush);
  end;

{
1	Horizontal Line.
2	Vertical Line.
3       Downward Diagonal.
4	Upward Diagonal.
5 	Cross.
6	Diagonal Cross.
}

procedure qline(x1,y1,x2,y2:integer);
var ends:array[1..2] of tpoint;
  begin
    ends[1].x:=x1;  ends[1].y:=y1;  ends[2].x:=x2;  ends[2].y:=y2;
    polyline(DC,ends,2);
  end;

procedure qcircle(xpos,ypos,radiusw,radiush:integer);
var x1,y1,x2,y2,c,d:integer;
  begin
    x1:=xpos-radiusw;  y1:=ypos-radiush;  x2:=xpos+radiusw;  y2:=ypos+radiush;
    Ellipse(DC, X1,Y1,X2,Y2);
  end;

procedure Qarc(xpos,ypos,radiusw,radiush,angle1,angle2,way:integer);
var x1,y1,x2,y2,x3,y3,x4,y4,c,d:integer;
  begin
    x1:=xpos-radiusw;  y1:=ypos-radiush;  x2:=xpos+radiusw;  y2:=ypos+radiush;
    x3:=xpos+round(radiusw*(cos(angle1/180*pi))); y3:=ypos-round(radiush*(sin(angle1/180*pi)));
    x4:=xpos+round(radiusw*(cos(angle2/180*pi))); y4:=ypos-round(radiush*(sin(angle2/180*pi)));
    case way of
      0: arc(DC, X1,Y1,X2,Y2,X3,Y3,X4,Y4);
      1: chord(DC, X1,Y1,X2,Y2,X3,Y3,X4,Y4);
      2: pie(DC, X1,Y1,X2,Y2,X3,Y3,X4,Y4);
    end;
  end;

procedure pset(xpos,ypos: integer; color:longint);
  begin
    setpixel(DC,xpos,ypos,color);
  end;

function pixel(xpos,ypos:integer):longint;
  begin
    pixel:=getpixel(DC,xpos,ypos);
  end;

procedure fill(xpos,ypos:integer; colorinfo:longint; filltype:integer);
  begin
    EXTFLOODFILL(DC,xpos,ypos,colorinfo,filltype);
  end;

procedure box(x1,y1,x2,y2,x3,y3:integer);
  begin
    roundrect(DC,x1,y1,x2,y2,x3,y3);
  end;

procedure connectdots(var pointarray:points; count:integer);
  begin
    Polyline(DC,pointarray,count)
  end;

procedure shape(var pointarray:points; count,method: integer);
  begin
    setpolyfillmode(DC,method);     {1=alternate, 2=winding}
    polygon(DC,pointarray,count);
  end;

var BitMapHandle: HBitmap;
    IconizedBits: HBitmap;
    IconImageValid: Boolean;
    Stretch: Boolean;
    Width, Height: LongInt;
procedure AHIncr; far; external 'KERNEL' index 114;
procedure GetBitmapData(var TheFile: File;
  BitsHandle: THandle; BitsByteSize: Longint);
type
  LongType = record
    case Word of
      0: (Ptr: Pointer);
      1: (Long: Longint);
      2: (Lo: Word;
	  Hi: Word);
  end;
var
  Count: Longint;
  Start, ToAddr, Bits: LongType;
begin
  Start.Long := 0;
  Bits.Ptr := GlobalLock(BitsHandle);
  Count := BitsByteSize - Start.Long;
  while Count > 0 do
  begin
    ToAddr.Hi := Bits.Hi + (Start.Hi * Ofs(AHIncr));
    ToAddr.Lo := Start.Lo;
    if Count > $4000 then Count := $4000;
    BlockRead(TheFile, ToAddr.Ptr^, Count);
    Start.Long := Start.Long + Count;
    Count := BitsByteSize - Start.Long;
  end;
  GlobalUnlock(BitsHandle);
end;
function OpenDIB(var TheFile: File): Boolean;
var
  bitCount: Word;
  size: Word;
  longWidth: Longint;
  DCHandle: HDC;
  BitsPtr: Pointer;
  BitmapInfo: PBitmapInfo;
  BitsHandle, NewBitmapHandle: THandle;
  NewPixelWidth, NewPixelHeight: Word;
begin
  OpenDIB := True;
  Seek(TheFile, 28);
  BlockRead(TheFile, bitCount, SizeOf(bitCount));
  if bitCount <= 8 then
  begin
    size := SizeOf(TBitmapInfoHeader) + ((1 shl bitCount) * SizeOf(TRGBQuad));
    BitmapInfo := MemAlloc(size);
    Seek(TheFile, SizeOf(TBitmapFileHeader));
    BlockRead(TheFile, BitmapInfo^, size);
    NewPixelWidth := BitmapInfo^.bmiHeader.biWidth;
    NewPixelHeight := BitmapInfo^.bmiHeader.biHeight;
    longWidth := (((NewPixelWidth * bitCount) + 31) div 32) * 4;
    BitmapInfo^.bmiHeader.biSizeImage := longWidth * NewPixelHeight;
    GlobalCompact(-1);
    BitsHandle := GlobalAlloc(gmem_Moveable or gmem_Zeroinit,
      BitmapInfo^.bmiHeader.biSizeImage);
    GetBitmapData(TheFile, BitsHandle, BitmapInfo^.bmiHeader.biSizeImage);
    DCHandle := CreateDC('Display', nil, nil, nil);
    BitsPtr := GlobalLock(BitsHandle);
    NewBitmapHandle :=
      CreateDIBitmap(DCHandle, BitmapInfo^.bmiHeader, cbm_Init, BitsPtr,
      BitmapInfo^, 0);
    DeleteDC(DCHandle);
    GlobalUnlock(BitsHandle);
    GlobalFree(BitsHandle);
    FreeMem(BitmapInfo, size);
    if NewBitmapHandle <> 0 then
    begin
      if BitmapHandle <> 0 then DeleteObject(BitmapHandle);
      BitmapHandle := NewBitmapHandle;
      Width := NewPixelWidth;
      Height := NewPixelHeight;
    end
    else
      OpenDIB := False;
  end
  else
    OpenDIB := False;
end;
function LoadBitmapFile(Name: PChar): Boolean;
var
  TheFile: File;
  TestWin30Bitmap: Longint;
  MemDC: HDC;
begin
  LoadBitmapFile := False;
  Assign(TheFile, Name);
  Reset(TheFile, 1);
  Seek(TheFile, 14);
  BlockRead(TheFile, TestWin30Bitmap, SizeOf(TestWin30Bitmap));
  if TestWin30Bitmap = 40 then
    if OpenDIB(TheFile) then
    begin
      LoadBitmapFile := True;
      IconImageValid := False;
    end
    else
      MessageBox(0, 'EASYCRT:  Unable to create Windows 3.0 bitmap from file.',
	Name, mb_Ok)
  else
      MessageBox(0, 'EASYCRT:  Not a Windows 3.0 bitmap file.  Convert using Paintbrush.', Name, mb_Ok);
  Close(TheFile);
end;
procedure Paint(PaintDC:HDC;  xpos,ypos,wth,ht:integer; Rop:longint; var PaintInfo: TPaintStruct);
var
  MemDC: HDC;
  OldBitmap: HBitmap;
  R: TRect;
  Info:tbitmap;
begin
  getobject(BitMapHandle,10,@info);
  width:=info.bmwidth;
  height:=info.bmheight;
  if BitMapHandle <> 0 then
  begin
    MemDC := CreateCompatibleDC(PaintDC);
      SelectObject(MemDC, BitMapHandle);
      if Stretch then
        begin
          GetClientRect(CrtWindow, R);
   	  SetCursor(LoadCursor(0, idc_Wait));
          SetStretchBltMode(PaintDC,3);
          StretchBlt(PaintDC, xpos, ypos, wth, ht, MemDC, 0, 0,
	    width, Height, Rop);  
	  SetCursor(LoadCursor(0, idc_Arrow));
        end
      else
        begin
          if wth <> 0 then width  := wth;
          if ht  <> 0 then height := ht;
	  BitBlt(PaintDC, xpos, ypos, Width, Height, MemDC, 0, 0, Rop);
        end;
    DeleteDC(MemDC);
  end;
end;

procedure drawpicture(DC:HDC; x,y:integer; filename:string);
var info:tpaintstruct;
begin
  IconImageValid := False;
  Stretch := False;
  loadbitmapfile(pc(filename));
  Paint(DC,x,y,0,0,srccopy,info);
  deleteobject(BitMapHandle);
end;

function loadbmp(filename:string):BMP;
begin
  bitmaphandle:=0;
  IconImageValid := False;
  Stretch := False;
  loadbitmapfile(pc(filename));
  loadbmp:=BitMapHandle;  
  bitmaphandle:=0;
end;

procedure drawbmp(x,y: integer;  bmpname: bmp;  stretched,width,height:integer);
var info:tpaintstruct;
  begin
    IconImageValid := False;
    if stretched=0 then Stretch := False else stretch:=True;
    bitmaphandle:=bmpname;
    Paint(DC,x,y,width,height,srccopy,info);
  end;

procedure deletebmp(var thebmp:bmp);
begin
  deleteobject(thebmp);
  deleteobject(BitMapHandle);
end;

procedure maskbmp(x,y: integer;  themask,thepic: bmp;  stretched,wth,ht:integer);
var memdc,tempdc: HDC;
    Infob:tbitmap;
    info:tpaintstruct;
    dwidth,dheight,rwidth,rheight:integer;
  begin
    IconImageValid := False;
    if stretched=0 then Stretch := False else stretch:=True;
    getobject(thepic,10,@infob); rwidth:=infob.bmwidth; rheight:=infob.bmheight;
    if wth <> 0 then dwidth  := wth else dwidth  :=rwidth;
    if ht  <> 0 then dheight := ht  else dheight :=rheight;;
    bitmaphandle:=themask; paint(DC,x,y,dwidth,dheight,dstinvert,info);   
    bitmaphandle:=themask; paint(DC,x,y,dwidth,dheight,srcpaint,info);  
    bitmaphandle:=themask; paint(DC,x,y,dwidth,dheight,dstinvert,info);  
    tempdc:=createcompatibledc(DC);    Selectobject(tempdc, thepic);
    memdc:=createcompatibledc(tempDC); SelectObject(memdc, thepic);
    BitBlt(tempDC,0,0,rWidth,rHeight, MemDC, 0, 0, srccopy);
    deletedc(memdc);
    memdc:=createcompatibledc(tempDC); SelectObject(memdc, themask);
    BitBlt(tempDC,0,0,rWidth,rHeight, MemDC, 0, 0, srcand);
    deletedc(memdc);
    StretchBlt(DC,X,Y,DWidth,DHeight,tempDC,0,0,RWidth,RHeight,srcpaint);
    deletedc(tempdc); 
  end;

function getwidth(thebmp:bmp):integer;
var Infob:tbitmap;
  begin
    getobject(thebmp,10,@infob);
    getwidth:=infob.bmwidth;
  end;

function getheight(thebmp:bmp):integer;
var Infob:tbitmap;
  begin
    getobject(thebmp,10,@infob);
    getheight:=infob.bmheight;
  end;



const dbxresname: pchar = 'CALC';

var dbx:integer;
    dbxhandle:hwnd;

function dbxproc(Dlg: HWnd; Msg, wParam: Word; lParam: LongInt): LongInt; export;
  begin
    dbxproc:=DefDlgProc(Dlg,Msg,wParam,lParam);
  end;

procedure fullscreen;
  begin
  dbx:=DialogBox(HInstance,dbxresname,CrtWindow,@dbxproc);
  end;

procedure windowscreen;
  begin
  enddialog(dbxhandle,dbx);
  end;

procedure delay(milliseconds:real);
var t: real;
  begin
    t:=gettickcount;
    repeat
    unfreeze;
    until milliseconds<=gettickcount-t;
  end;



{
function inkey:word;
  begin
  inkey:=ink;
  ink:=0;
  end;
      }

procedure unfreeze;
var M: TMsg;
  begin  
    while PeekMessage(M, 0, 0, 0, pm_Remove) do
    begin
      if M.Message = wm_Quit then Terminate;
      DispatchMessage(M);
    end;
  end;

function inkey:word;
begin  
  unfreeze;
  inkey:=ink;
  ink:=0;
end;

function inkeyasc:char;
  begin
    inkeyasc:=chr(0);
    while keypressed do inkeyasc:=readkey;
  end;




{   </RUSS>    }

{Garett}

function TheDC:HDC;
begin
    TheDC:=DC;
end;

{/Garett}
begin
  if HPrevInst = 0 then
  begin
    CrtClass.hInstance := HInstance;
    CrtClass.hIcon := LoadIcon(0, idi_Application);
    CrtClass.hCursor := LoadCursor(0, idc_Arrow);
    CrtClass.hbrBackground := GetStockObject(White_Brush);
    RegisterClass(CrtClass);
  end;
  AssignCrt(Input);
  Reset(Input);
  AssignCrt(Output);
  Rewrite(Output);
  GetModuleFileName(HInstance, WindowTitle, SizeOf(WindowTitle));
  SaveExit := ExitProc;
  ExitProc := @ExitWinCrt;
{RWH}
   DC:=getDC(CrtWindow);  
   initwincrt;

end.