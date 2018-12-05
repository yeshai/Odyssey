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

#XSTART = 46.5
#ZTOUCH = -57.8
#ZTOUCH = #ZTOUCH + 4.2 (-53.6 ADD PART & NOZZLE)
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
M34                 (TURN N2 ON, PB-FREE)
M16 S#PUMP1RPM      (TURN SOLDER PUMP ON, PB-FREE)

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

(#FLUX_X = 694.5 (FLUX X @ A=60)
(#FLUX_Z = -85.4 (FLUX Z @ A=60)
(UPDATED TO RELATIVE TO START)
#FLUX_X = #XSTART + 648 (FLUX X @ A=60)
#FLUX_Z = #ZTOUCH - 31.8


G01 X#FLUX_X   F20000   (MOVE TO FLUX)
G01 A60     F1080        (TILT) 
G01 Z#FLUX_Z           (DIP IN FLUX)
G04 P0.5             (ENSURE DIP BEFORE SPIN)
G91                 (SWITCH TO RELAVTIVE COORDINATES)
G01 B360 F20000     (SPIN 360 DEGREES)
G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z-20            (MOVE UP)
G04 P1.0	    	(WAIT 1 SECOND, DRIP)
G01 A0 F500         (SET ANGLE TO 0)
(M40                (TURN FLUX OFF)

(################### PRE-HEAT #1 ###################)

(#PREHEAT_X = 635	(PRE-HEAT X @ A=0)
(#PREHEAT_Z = -51.5	(PRE-HEAT Z @ A=0)
(UPDATED TO RELATIVE TO START)
#PREHEAT_X = #XSTART + 588.5
#PREHEAT_Z = #ZTOUCH + 2.1
G01 X#PREHEAT_X F20000     (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z            (MOVE DOWN)
G04 P30.0           	(WAIT 30 SECONDS)
G01 Z0            	(MOVE UP)
G04 P1.0            	(WAIT 1 SECOND)

(################### SOLDER #1 ###################)

(#SOLDER_X = 1569(SOLDER X @ A=45)
(#SOLDER_Z = -12.9	(SOLDER Z @ A=45, 10MM from WAVE)
(UPDATED TO RELATIVE TO START)
#SOLDER_X = #XSTART + 1522.5
#SOLDER_Z = #ZTOUCH + 40.7

G01 A45 	F1080		(TILT 45 DEGREES)
G04 P1.0
G01 X#SOLDER_X F20000    (MOVE TO PB POT)
G04 P1.0
G01 Z#SOLDER_Z            (MOVE DOWN TOWARDS WAVE)
G04 P1.0
G91                 (SWITCH TO RELAVTIVE COORDINATES)

G01 Z-10  F600      (DIP INTO SOLDER)
G04 P1.0            (WAIT 1.0 SECOND)
G01 B5   F600	  (SPIN +5 DEGREES, B=5)
G01 Z5 F300         (BACK OUT OF WAVE)
G01 Z5 F20000       (BACK OUT OF WAVE)
G01 B-5 F20000      (SPIN -5 DEGREES, B=0) 

G01 B90             (SPIN TO TIN, SIDE 2)
G01 Z-10  F600      (DIP INTO SOLDER)
G04 P1.0            (WAIT 1.0 SECOND)
G01 B5   F600	  (SPIN +5 DEGREES, B=95)
G01 Z5 F300         (BACK OUT OF WAVE)
G01 Z5 F20000       (BACK OUT OF WAVE)
G01 B-5 F20000      (SPIN -5 DEGREES, B=90) 

G01 B90             (SPIN TO TIN, SIDE 3)
G01 Z-10  F600      (DIP INTO SOLDER)
G04 P1.0            (WAIT 1.0 SECOND)
G01 B5   F600	  (SPIN +5 DEGREES, B=185)
G01 Z5 F300         (BACK OUT OF WAVE)
G01 Z5 F20000       (BACK OUT OF WAVE)
G01 B-5 F20000      (SPIN -5 DEGREES, B=180) 

G01 B90             (SPIN TO TIN, SIDE 4)
G01 Z-10  F600      (DIP INTO SOLDER)
G04 P1.0            (WAIT 1.0 SECOND)
G01 B5   F600	  (SPIN +5 DEGREES, B=275)
G01 Z5 F300         (BACK OUT OF WAVE)
G01 Z5 F20000       (BACK OUT OF WAVE)
G01 B-5 F20000      (SPIN -5 DEGREES, B=270) 

G01 B90 F20000      (SPIN +90 DEGREES, B=0)

G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z0            (MOVE UP)
G01 A0       F1080
M17                 (TURN SOLDER PUMP OFF, PB)
M35                 (TURN N2 OFF, PB)


(###################### RINSE ######################)

(#RINSE_X = 236		(RINSE_X @ A=60)
(#RINSE_Z = -89	(RINSE_Z @ A=60)
(UPDATED TO RELATIVE TO START)
#RINSE_X = #XSTART + 189.5
#RINSE_Z = #ZTOUCH - 35.4

M26                      (TURN RINSE ON)
G01 X#RINSE_X  F20000    (MOVE TO RINSE)
G01 A60
G01 Z#RINSE_Z            (MOVE DOWN)
G91                      (SWITCH TO RELAVTIVE COORDINATES)
G01 B360 F2000      (SPIN IN RINSE)
G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z-20            (MOVE UP)
G01 A0   F1080      (LEVEL HEAD, A=0)
M27                 (TURN RINSE OFF)

(################### HEAT DRY ###################)

(G01 X#PREHEAT_X F20000     (MOVE TO PREHEAT)
(G01 Z#PREHEAT_Z             (MOVE DOWN)
(G04 P5.0           (WAIT 30 SECONDS)
(G01 Z-20            (MOVE UP)
(G04 P1.0            (WAIT 1 SECOND)

(################### RETURN PARTS ###################)

G01 X[#XSTART + [#ROW*#PITCH]+50]  F20000
G01 X[#XSTART + [#ROW*#PITCH]]  F500
(G91                 (SWITCH TO RELAVTIVE COORDINATES)
(G01 B90 F2000      (SPIN 90 DEGREES)
(G90                 (SWITCH TO ABSOLUTE COORDINATES)
G04 P0.5            (WAIT 0.5 SECONDS)
G01 Z[#ZTOUCH + 1.5] F500       (PUT PARTS DOWN)
M33                 (TURN VACUUM OFF)
M29		        (TURN OFF VACUUM SOLENOID, SUCTION)
M43                 (OPEN TO ATMOSPHERE)
M44                 (CLOSE TO ATMOSPHERE)
M24                 (TURN ON AIR KNIFE)
G04 P2.5            (WAIT 0.5 SECONDS)
M43                 (OPEN TO ATMOSPHERE)
G01 Z[#ZTOUCH + 2.5] F500       (MOVE UP)
G04 P1.5            (WAIT 3.5 SECONDS)
M25                 (TURN OFF AIR KNIFE)
G04 P1.0            (WAIT 1.0 SECOND)
M24                 (TURN ON AIR KNIFE)
G01 Z[#ZTOUCH + 4.5] F500       (MOVE UP)
G04 P1.5            (WAIT 1.5 SECONDS)
M25                 (TURN OFF AIR KNIFE)
M43                 (OPEN TO ATMOSPHERE)
G04 P2.0            (WAIT 2.0 SECONDS)
G01 Z0 F2000      (MOVE UP)	
M43                 (OPEN TO ATMOSPHERE)
#ROW = #ROW +1
ENDWHILE
G28 		        (SEEK HOME, REF.)
(M40                 (TURN FLUX OFF)