uses wncrt, winprocs, wintypes, strings, wobjects;

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

type SDC = ^StdDC;
     StdDC = record
       handle: HDC;
       ThePen, OldPen, NewPen: Hpen;
       TheBrush, OldBrush, NewBrush: HBrush;
       TheRegion, OldRegion, NewRegion: HRgn;
       TheBMP, OldBMP, NewBMP: HBitmap;
       TheFont, OldFont, NewFont: HFont;
       From: Thandle;
       Kind: Word;
     end;

type HDC = THandle;
     BMP = THandle;
     Points = record
       x: Integer;
       y: Integer;
     end;

function makeDC(FromWhat:Thandle; Form:Word):SDC;
  var bob: sdc;
  begin
    bob:=new(SDC);
    with bob^ do
      begin
        if form=0 then handle:=getDC(fromwhat);
        if form=1 then handle:=createcompatibleDC(Fromwhat);
        Oldpen    :=  0;
        OldBrush  :=  0;
        OldRegion :=  0;
        OldBMP    :=  0;
        OldFont   :=  0;
        From      :=  Fromwhat;
        Kind      :=  Form;
      end;
    makeDC:=bob;
  end;

procedure killDC(var it: SDC);
  begin
    with it^ do
      begin
        thepen:=selectobject(handle,oldpen);
        deleteobject(ThePen);
        thebrush:=selectobject(handle,oldbrush);
        deleteobject(TheBrush);
        thefont:=selectobject(handle,oldfont);
        deleteobject(Thefont);
        if kind=0 then releaseDC(from,handle);
        if kind=1 then deleteDC(handle);
      end;
    dispose(it);
  end;

procedure setpen(DC:SDC; color: longint; linestyle, width: integer);
  begin
    with DC^ do
      begin
        if color <> -1 then
          NewPen := CreatePen(linestyle, width, color)
        else
          NewPen := CreatePen(PS_NULL,width,0);
        thepen:=selectobject(handle,NewPen);
        if oldpen=0 then oldpen:=thepen else deleteobject(thepen);
      end;
  end;

procedure setbrush(DC:SDC; color,bcolor:longint; style: integer);
var brushstyle: tlogbrush;
  begin
    with DC^ do
      begin
        if bcolor < 0 then
          setbkmode(handle,1)
        else 
          begin
            setbkmode(handle,2);
            setbkcolor(handle,bcolor);
          end;
        if color < 0 then
          begin
            brushstyle.lbstyle:=BS_HOLLOW;
            newbrush:=CreateBrushIndirect(brushstyle);
          end;
        if style=0 then
          begin
            brushstyle.lbstyle:=BS_SOLID;
            brushstyle.lbcolor:=color;
            newbrush:=CreateBrushIndirect(brushstyle);
          end
        else
          newbrush:=createhatchbrush(style-1,color);;
        thebrush:=selectobject(handle,NewBrush);
        if oldbrush=0 then oldbrush:=thebrush else deleteobject(thebrush);
      end;
  end;

function pc(st: string): pchar;
  var p: array[0..1024] of char;
  begin
    strpcopy(p,st);
    pc := @p;
  end;  

procedure setfont(DC:SDC; fontface:string; size,weight,italic,underline,strikeout:integer;angle:real );
  var prpfont: tlogfont;
  begin
    with prpfont do
      begin
        lfHeight         := -1*size;
        lfWidth          := 0;
        lfEscapement     := round(angle*10);
        lfWeight         := weight*100;
        lfItalic         := byte(italic);
        lfUnderline      := byte(underline);
        lfStrikeout      := byte(strikeout);
{       lfcharset }
{       lfOutprecision   := OUT_TT_PRECIS; }
        lfQuality        := PROOF_QUALITY;
        lfPitchAndFamily := DEFAULT_PITCH or FF_DONTCARE;
        StrCopy(lfFaceName,pc(fontface));
      end;
    with DC^ do
      begin
        newfont:=createfontindirect(prpfont);
        thefont:=selectobject(handle,Newfont);
        if oldfont=0 then oldfont:=thefont else deleteobject(thefont);
      end;
  end;

procedure txt(DC: SDC; x,y,align:integer; color:longint; text:string);
var aln,lng:integer;
    p: pchar;
  begin
    with DC^ do
      begin
        case align of
          1: aln:=TA_LEFT;
          2: aln:=TA_RIGHT;
          3: aln:=TA_CENTER;
        end;
        settextalign(handle,aln);
        settextcolor(handle,color);
        lng:=setbkmode(handle,1);
        p:=pc(text);
        textout(handle,x,y,p,strlen(p));
        setbkmode(handle,lng);
      end;
  end;

procedure box(DC:SDC; x1,y1,x2,y2,x3,y3:integer);
  begin
    roundrect(DC^.handle,x1,y1,x2,y2,x3,y3);
  end;

procedure qcircle(DC:SDC; xpos,ypos,radiusw,radiush:integer);
var x1,y1,x2,y2,c,d:integer;
  begin
    x1:=xpos-radiusw;  y1:=ypos-radiush;  x2:=xpos+radiusw;  y2:=ypos+radiush;
    Ellipse(DC^.handle, X1,Y1,X2,Y2);
  end;

procedure qline(DC: SDC; x1,y1,x2,y2:integer);
var ends:array[1..2] of tpoint;
  begin
    ends[1].x:=x1;  ends[1].y:=y1;  ends[2].x:=x2;  ends[2].y:=y2;
    polyline(DC^.handle,ends,2);
  end;

procedure Qarc(DC: SDC; xpos,ypos,radiusw,radiush,angle1,angle2,way:integer);
var x1,y1,x2,y2,x3,y3,x4,y4,c,d:integer;
  begin
    x1:=xpos-radiusw;  y1:=ypos-radiush;  x2:=xpos+radiusw;  y2:=ypos+radiush;
    x3:=xpos+round(radiusw*(cos(angle1/180*pi))); y3:=ypos-round(radiush*(sin(angle1/180*pi)));
    x4:=xpos+round(radiusw*(cos(angle2/180*pi))); y4:=ypos-round(radiush*(sin(angle2/180*pi)));
    case way of
      0: arc(DC^.handle, X1,Y1,X2,Y2,X3,Y3,X4,Y4);
      1: chord(DC^.handle, X1,Y1,X2,Y2,X3,Y3,X4,Y4);
      2: pie(DC^.handle, X1,Y1,X2,Y2,X3,Y3,X4,Y4);
    end;
  end;

(* ------------     Bitmap Routines    -------------- *)


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

function loadbmp(filename:string):BMP;
begin
  bitmaphandle:=0;
  IconImageValid := False;
  Stretch := False;
  loadbitmapfile(pc(filename));
  loadbmp:=BitMapHandle;  
  bitmaphandle:=0;
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

procedure drawbmp(DC: SDC; x,y: integer;  bmpname: bmp;  stretched,width,height:integer);
var info:tpaintstruct;
  begin
    IconImageValid := False;
    if stretched=0 then Stretch := False else stretch:=True;
    bitmaphandle:=bmpname;
    Paint(DC^.handle,x,y,width,height,srccopy,info);
  end;

procedure deletebmp(var thebmp:bmp);
begin
  deleteobject(thebmp);
  deleteobject(BitMapHandle);
end;

procedure maskbmp(DvC:SDC; x,y: integer;  themask,thepic: bmp;  stretched,wth,ht:integer);
var memdc,tempdc: HDC;
    Infob:tbitmap;
    info:tpaintstruct;
    dwidth,dheight,rwidth,rheight:integer;
    DC:HDC;
  begin
    DC:=DvC^.handle;
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

procedure drawpicture(DC:HDC; x,y:integer; filename:string);
var info:tpaintstruct;
begin
  IconImageValid := False;
  Stretch := False;
  loadbitmapfile(pc(filename));
  Paint(DC,x,y,0,0,srccopy,info);
  deleteobject(BitMapHandle);
end;

procedure selectbmp(DC: SDC; Picture: BMP);
  begin
    DC^.oldbmp := selectobject(DC^.handle,picture);
  end;

procedure deselectbmp(DC: SDC);
  begin
    DC^.thebmp := selectobject(DC^.handle,DC^.oldbmp);
    deleteobject(DC^.thebmp);
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

procedure unfreeze(Wnd: Hwnd);
var Msg: TMsg;
  begin  
    while PeekMessage(Msg, Wnd, 0, 0, pm_Remove) do
    begin
(*  Experimental--                                                       *)
      if Msg.Message = WM_QUIT then begin Application^.Done; halt; end;
      TranslateMessage(Msg);
(*  --Experimental                                                       *)
      DispatchMessage(Msg);
    end;
  end;
  

procedure defreeze;
var msg: TMsg;
  begin
    while PeekMessage(Msg,0,0,0,PM_REMOVE) do
    begin
      if Msg.Message = WM_QUIT then begin Application^.Done; halt; end;
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
  end;
 
procedure startdelay(var t: longint);
  begin
    t := gettickcount;
  end;

procedure finishdelay(milliseconds,t:longint; wnd:hwnd);
  begin
    repeat
      unfreeze(Wnd);
    until gettickcount-t>=milliseconds;
  end;

procedure delay(milliseconds:longint; Wnd:Hwnd);
var t: longint;
  begin
    t:=gettickcount;
    repeat
    unfreeze(Wnd);
    until gettickcount-t>=milliseconds;
  end;

function atan(x,y:real): real;
  begin                                 
    if y <> 0 then
      if x <> 0 then                  
        if x > 0 then                 
          atan := arctan(y/x)
        else
          if y > 0 then               
            atan := pi + arctan(y/x)
          else
            atan := arctan(y/x) - pi
      else                              
        if y >= 0 then
          atan := pi/2             
         else
          atan := -pi/2           
     else                               
      if x >= 0 then
        atan := 0                  
       else
        atan := - Pi                 
  end;                                

function asin(x: real): real;
  begin
    if x = 1 then
      asin := pi / 2
    else
      if x = - 1 then
        asin := pi / -2
      else
        asin := arctan(x / sqrt(1 - sqr(x)));
  end;

function acos(x: real): real;
  begin

   (* not mathematically correct, but painless way to fix program *)
      if abs(x) > 1 then acos:=pi else
   (* done *)
    if x = 0 then
      acos := pi / 2
    else
      if x < 0 then
        acos := pi - arctan(sqrt(1 - sqr(X)) / abs(X))
      else
        acos := arctan(sqrt(1 - sqr(X)) / abs(X))
   end;

function min(x,y: real): real;
  begin
    if x<y then min:=x else min:=y;
  end;

function max(x,y: real): real;
  begin
    if x>y then max:=x else max:=y;
  end;

function badtri(A,B,C:real): bool;
  begin
    A:=abs(a); B:=abs(b); c:=abs(c);
    if (a+b<c) or (b+c<a) or (a+c<b) then badtri:=true else badtri:=false;
  end;

function abovezero(number: integer):integer;
  begin
    if number < 0 then abovezero := 0 else abovezero := number;
  end;



var dman: SDC;
    x: integer;
    q: string;
    p: pchar;
begin
  write;
  repeat
    
  q:='Russ'+' Man';
  p:=pc(q);


    dman := makeDC(CrtWindow,0);
    for x:=1 to 55 do
      begin
        setpen(dman,rgb(0,0,255),0,4);
        setbrush(dman,rgb(255,0,0),rgb(0,255,0),1);
        setfont(dman,'Times New Roman',50,0,0,0,0,30);
      end;
    ellipse(dman^.handle,20,20,50,60);
    txt(dman,220,320,1,color[12],'Russ is niftay');
    qarc(dman,200,200,30,20,45,270,1);
    killDC(dman);
  until keypressed;

  writeln(p,strlen(p));
end.