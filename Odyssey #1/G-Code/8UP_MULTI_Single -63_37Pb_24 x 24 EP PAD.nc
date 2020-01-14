(*** CYCLE TIME = 4:45 ***)
REAL #PITCH
REAL #ROWS
REAL #ROW

REAL #XSTART (X @ FIRST ROW)
REAL #ZTOUCH (Z WHERE NOZZLE MAKE CONTACT) 

REAL #FLUX_X
REAL #FLUX_Z

REAL #PREHEAT_X
REAL #PREHEAT_Z 

REAL #SOLDER_X 
REAL #SOLDER_Z

REAL #RINSE_X
REAL #RINSE_Z

#ROW = 0 (FIRST ROW)
#ROWS = 5 (COUNT STARTS AT 0)
(FOR 1 ROW, #ROWS = 0)
(FOR 6 ROWS, #ROWS = 5)

#XSTART = 50.26
#ZTOUCH = -51.25
#PITCH = 42.3418 (1.667 INCHES)

(################### SETUP ###################)

G59                 (SELECT 8UP TOOLING, OFFSETS)
G28 		        (SEEK HOME, REF.)
WHILE #ROW <= #ROWS DO
M32                 (TURN VACUUM ON)
M43		       		(OPEN BLOW OFF)
G04 P0.5            (WAIT 0.5 SECONDS)
M44                 (CLOSE BLOW OFF)
M39                 (TURN FLUX ON)


(################### PICKUP ###################)

G52 X0 Y0 Z0 A0 B0     (REZERO ALL)
G01 A0 F1080        	(LEVEL HEAD)
G01 X[#XSTART + [#ROW*#PITCH]] F5000       (MOVE X TO PICK UP PARTS)
G01 Z[#ZTOUCH] F500       (MOVE Z TO PICK UP PARTS)
M28		    		(TURN ON VACUUM SOLENOID, SUCTION)
G04 P5.5            (WAIT 3.5 SECONDS)
G01 Z-30 F500       (MOVE UP)
G91                 (SWITCH TO RELAVTIVE COORDINATES)
G01 X10
G90                 (SWITCH TO ABSOLUTE COORDINATES)

(################### FLUX #1 ###################)

#FLUX_X = 854(FLUX X @ A=0)
#FLUX_Z = -50.1(FLUX Z @ A=0)


G01 X#FLUX_X   F20000   (MOVE TO FLUX)
G01 A0     F1080        (TILT) 
G01 Z#FLUX_Z           (DIP IN FLUX)
G04 P1.5             (DWELL)
G01 Z-20            (MOVE UP)
G04 P1.0	    	(WAIT 1 SECOND, DRIP)
G01 A0 F500         (SET ANGLE TO 0)
(M40                (TURN FLUX OFF)

M34                 (TURN N2 ON, PB-FREE)
M16 S#PUMP1RPM      (TURN SOLDER PUMP ON, PB-FREE)
(################### PRE-HEAT #1 ###################)

#PREHEAT_X = #XSTART + 588.5 (PRE-HEAT X @ A=0)
#PREHEAT_Z = #ZTOUCH + 4.1 (PRE-HEAT Z @ A=0)
G01 X#PREHEAT_X F20000     (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z            (MOVE DOWN)
G04 P20.0           	(WAIT 30 SECONDS)
G01 Z0            	(MOVE UP)
G04 P1.0            	(WAIT 1 SECOND)

(################### SOLDER #1 ###################)

#SOLDER_X = 1720.65 (SOLDER X @ A=0)
#SOLDER_Z = -7(SOLDER Z @ A=0)

G01 A0 	
G04 P1.0
G01 X#SOLDER_X F20000    (MOVE TO PB POT)
G04 P1.0
G01 Z#SOLDER_Z            (MOVE DOWN TOWARDS WAVE)
G04 P1.0
G91                 (SWITCH TO RELAVTIVE COORDINATES)

G01 Z-10 B180  F4000      (DIP INTO SOLDER)
(G04 P2.0            (WAIT 3.0 SECONDS)
(G01 B180   F4000     (SPIN)
G01 Z10 B180 F1000         (BACK OUT OF WAVE)

G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z0            (MOVE UP)
G01 A0       F1080
M17                 (TURN SOLDER PUMP OFF, PB)
M35                 (TURN N2 OFF, PB)


(###################### RINSE ######################)

#RINSE_X = 437(RINSE_X @ A=0)
#RINSE_Z = -49  (RINSE_X @ A=0)

M26                      (TURN RINSE ON)
G01 X#RINSE_X  F20000    (MOVE TO RINSE)
G01 A0
G01 Z#RINSE_Z            (MOVE DOWN)
G91                      (SWITCH TO RELAVTIVE COORDINATES)
G01 B360 F4000      (SPIN IN RINSE)
G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z-20            (MOVE UP)
G04 P1.0            (WAIT 1.0 SECOND)
G01 A0   F1080      (LEVEL HEAD, A=0)
M27                 (TURN RINSE OFF)


(################### RETURN PARTS ###################)

G01 X[#XSTART + [#ROW*#PITCH]+50]  F20000
G01 X[#XSTART + [#ROW*#PITCH]]  F500
G04 P0.5            (WAIT 0.5 SECONDS)
G01 Z[#ZTOUCH + 2] F500       (PUT PARTS DOWN)
M33                 (TURN VACUUM OFF)
M29		        (TURN OFF VACUUM SOLENOID, SUCTION)
M43                 (OPEN TO ATMOSPHERE)
G04 P1.5            (WAIT 1.5 SECONDS)
G01 Z[#ZTOUCH +3.5] F500       (MOVE UP)
M44                 (CLOSE TO ATMOSPHERE)
M24                 (TURN ON AIR KNIFE)
G04 P2.0            (WAIT 2.0 SECONDS)
M25                 (TURN OFF AIR KNIFE)
M43                 (OPEN TO ATMOSPHERE)
G01 Z[#ZTOUCH + 5] F500       (MOVE UP)
G04 P1.0            (WAIT 1.0 SECOND)
G01 Z0 F2000      (MOVE UP)	
#ROW = #ROW +1
ENDWHILE
G28 		        (SEEK HOME, REF.)