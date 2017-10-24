#R:\Manufacturing\Robotic Solder\Odyssey Programs\Odyssey #1\SUBROUTINES\MICROSS SUB UTILITIES ROTARY.nc
G52 X0 Y0 Z0  (Calibration Offsets)

(********************** DECLARE VARIABLES ********************)
REAL #r               (ROW COUNT
REAL #step            (ROW PITCH
REAL #start           (INITIAL POCKET
REAL #n
REAL #pick

(************************ SET PARAMETERS *************************)

#r = 6              (ROW COUNT
#step = 25.797      (ROW PITCH
#start = 206.534    (INITIAL POCKET

#n = 1

(************************ MAIN G-CODE *************************)
WHILE #n<#r+1 DO

#pick = #start-[#n-1]*#step

G01 Z-5 F10000

M98 PPARTLOADROTARY
G01 X#pick F8000
G01 Z-74.5 F2000
M28 G04 P1                         	(TURN VACUUM PICKUP ON)
G01 Z-5 F6000                	(RETURN TO PROCESS POSITION)
M37



G30 P5			(MOVE TO FLUX POSITION, REF. PT)

G01 A-20
G01 Z-72.05
G04 P1
G01 Z-5

G01 X720 A20
G01 Z-96.
G04 P1
G01 Z-5
G04 P2
G01 A0

M98 PPARTPREHEATROTARY		(MOVE TO PREHEAT STATION
G01 X550 Z-60 F6000
G04 P20                                   (PREHEAT DWELL
G01 Z-5       F6000                      (RETURN TO PROCESS POSITION
M16
M34

M98 PROTARYDSPWAVERIGHTLEAD	(MOVE TO LEAD SOLDER POT

G01 X1590 Z-30 A0
G01 Z-41.5
G01 x1606 F1000
G04 P2
G01 X1590 F180
G01 Z-30 F6000

G01 X1650 A0
G01 Z-41.5
G01 x1635 F1000
G04 P2
G01 X1650 F180

G01 Z-5 F6000
M17
M35


M98 PPARTWASH			(MOVE TO WASH STATION
G01 X350
G01 Z-73.7 F6000			(MOVE TO PROCESS DEPTH
G92 B0
G91
G04 P10
G90
G01 Z-5 F4000



(M98 PDRYON			(MOVE TO DRY STATION
(G01 x550 z-5 F10000
(G01 A0
(G01 Z-35
(G91
(G04 P10
(G90
(G01 Z-5
(G99
(M98 PDRYOFF

M98 PPARTUNLOAD			(MOVE TO UNLOAD STATION
G01 X#pick
G01 Z-74.5 F6000
M29
G04 P10.0
G91
G01 X-10
G90
G04 P2
G01 Z-5 F6000
(M33

#n=#n+1

ENDWHILE

G56
M98 PUNLOAD
M30.1