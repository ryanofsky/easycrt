DECLARE FUNCTION c$ (col!)
DECLARE FUNCTION acos! (x!)
DECLARE FUNCTION atan! (opp!, adj!)
CONST pi = 3.14159


SCREEN 12
CLS
J1 = 50
J2 = 50
Lx = 100
Ly = 100

speed = 40



top:

 
 
 
  xx = 0: yy = 0
  a$ = INKEY$
  IF a$ = CHR$(0) + "H" THEN yy = speed
  IF a$ = CHR$(0) + "P" THEN yy = -speed
  IF a$ = CHR$(0) + "K" THEN xx = -speed
  IF a$ = CHR$(0) + "M" THEN xx = speed
  Lx = Lx + xx
  Ly = Ly + yy
 
  x(1) = 150: Y(1) = 150
  x(3) = x(1) + Lx: Y(3) = Y(1) - Ly

  LOCATE 25, 20
  PRINT c$(15); "J2:  "; c$(7); ((x(3) - x(2)) ^ 2 + (Y(3) - Y(2)) ^ 2) ^ .5;


LOCATE 24, 20
PRINT c$(15); "ANG: "; c$(7); ang * 180 / pi;

ang = atan(Ly, Lx)
ang = ang + acos((J2 ^ 2 - J1 ^ 2 - (Lx ^ 2 + Ly ^ 2)) / (2 * J1 * (Lx ^ 2 + Ly ^ 2) ^ .5))

x(2) = x(1) + J1 * COS(ang)
Y(2) = Y(1) - J1 * SIN(ang)


  IF LEN(a$) <> 0 THEN
    LOCATE 24, 1
    PRINT c$(15); "J1:  "; c$(7); J1
    PRINT c$(15); "J2:  "; c$(7); J2
    PRINT c$(15); "Lx:  "; c$(7); Lx
    PRINT c$(15); "Ly:  "; c$(7); Ly
    LINE (0, 0)-(300, 300), 0, BF
    LINE (0, 0)-(300, 300), 8, B
    FOR a = 1 TO 2
      LINE (x(a), Y(a))-(x(a + 1), Y(a + 1)), 15
    NEXT a
    FOR a = 1 TO 3 STEP 2
     CIRCLE (x(a), Y(a)), 5, 12
    NEXT a
  END IF
GOTO top




'H P K M





FUNCTION acos (x)
IF x <= 1 AND x >= -1 THEN
  acos = ATN(1 / x * (1 ^ 2 - x ^ 2) ^ .5 / 1)
ELSE
  acos = 0
END IF

END FUNCTION

FUNCTION atan (opp, adj)
  p = 3.14159
  IF adj = 0 THEN a = p / 2 ELSE a = ATN(opp / adj)
  IF adj < 0 THEN a = a + p
  IF adj > 0 AND opp < 0 THEN a = a + 2 * p
  atan = a
END FUNCTION

FUNCTION c$ (col)
COLOR col
END FUNCTION

