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
#ROWS = 0 (COUNT STARTS AT 0)
(FOR 1 ROW, #ROWS = 0)
(FOR 6 ROWS, #ROWS = 5)

#XSTART = 16.351
#ZTOUCH = -59.5
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

#FLUX_X = 670.00 (FLUX X @ A=60)
#FLUX_Z = -85.0 (FLUX Z @ A=60)
G01 Z0
G01 A60     F1080        (TILT)
G01 X#FLUX_X   F20000   (MOVE TO FLUX) 
G04 P1.0             (ENSURE DIP BEFORE SPIN)
G01 Z#FLUX_Z           (DIP IN FLUX)
G04 P1.0             (ENSURE DIP BEFORE SPIN)
(G91                 (SWITCH TO RELAVTIVE COORDINATES)
(G01 B360 F20000     (SPIN 360 DEGREES)
(G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z0           (MOVE UP)
G04 P1.0	    	(WAIT 1 SECOND, DRIP)


(################### PRE-HEAT #1 ###################)

#PREHEAT_X = 642 (PRE-HEAT X @ A=0)
G01 A0 F500         (SET ANGLE TO 0)
#PREHEAT_Z = -51   (PRE-HEAT Z @ A=0)
G01 X#PREHEAT_X F20000     (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z            (MOVE DOWN)
G04 P20.0           	(WAIT 30 SECONDS)
G01 Z0            	(MOVE UP)
G04 P1.0            	(WAIT 1 SECOND)

(################### SOLDER #1 ###################)

#SOLDER_X = 1053 (SOLDER X @ A=60)
#SOLDER_Z = -77.5 (SOLDER Z @ A=60)

G01 A60 	F1080		(TILT 60 DEGREES)
G04 P1.0
G01 X#SOLDER_X F20000    (MOVE TO PB POT)
G04 P1.0
G01 Z#SOLDER_Z            (MOVE DOWN TOWARDS WAVE)
G04 P1.0
G91                 (SWITCH TO RELAVTIVE COORDINATES)

G01 Z-15  F600      (DIP INTO SOLDER)
G04 P2.0            (WAIT 2.0 SECOND)
G01 Z10 F20000        (BACK OUT OF WAVE)
G01 Z5 F20000       (BACK OUT OF WAVE)

G01 B90 F20000      (SPIN +90 DEGREES, B=90)

G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z0            (MOVE UP)

(################### FLUX #2 ###################)

G01 X#FLUX_X   F20000   (MOVE TO FLUX) 
G01 Z#FLUX_Z           (DIP IN FLUX)
G04 P1.0             (ENSURE DIP BEFORE SPIN)
G01 Z0           (MOVE UP)
G04 P1.0	    	(WAIT 1 SECOND, DRIP)


(################### PRE-HEAT #2 ###################)

G01 A0 F500         (SET ANGLE TO 0)
G01 X#PREHEAT_X F20000     (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z            (MOVE DOWN)
G04 P10.0           	(WAIT 10 SECONDS)
G01 Z0            	(MOVE UP)
G04 P1.0            	(WAIT 1 SECOND)

(################### SOLDER #2 ###################)

G01 A60 	F1080		(TILT 45 DEGREES)
G04 P1.0
G01 X#SOLDER_X F20000    (MOVE TO PB POT)
G04 P1.0
G01 Z#SOLDER_Z            (MOVE DOWN TOWARDS WAVE)
G04 P1.0
G91                 (SWITCH TO RELAVTIVE COORDINATES)

G01 Z-15  F600      (DIP INTO SOLDER)
G04 P2.0            (WAIT 2.0 SECOND)
G01 Z10 F20000      (BACK OUT OF WAVE)
G01 Z5 F20000       (BACK OUT OF WAVE)

G01 B90 F20000      (SPIN +90 DEGREES, B=180)

G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z0            (MOVE UP)

(################### FLUX #3 ###################)

G01 X#FLUX_X   F20000   (MOVE TO FLUX) 
G01 Z#FLUX_Z           (DIP IN FLUX)
G04 P1.0             (ENSURE DIP BEFORE SPIN)
G01 Z0           (MOVE UP)
G04 P1.0	    	(WAIT 1 SECOND, DRIP)


(################### PRE-HEAT #3 ###################)

G01 A0 F500         (SET ANGLE TO 0)
G01 X#PREHEAT_X F20000     (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z            (MOVE DOWN)
G04 P10.0           	(WAIT 10 SECONDS)
G01 Z0            	(MOVE UP)
G04 P1.0            	(WAIT 1 SECOND)

(################### SOLDER #3 ###################)

G01 A60 	F1080		(TILT 45 DEGREES)
G04 P1.0
G01 X#SOLDER_X F20000    (MOVE TO PB POT)
G04 P1.0
G01 Z#SOLDER_Z            (MOVE DOWN TOWARDS WAVE)
G04 P1.0
G91                 (SWITCH TO RELAVTIVE COORDINATES)

G01 Z-15  F600      (DIP INTO SOLDER)
G04 P2.0            (WAIT 2.0 SECOND)
G01 Z10 F20000        (BACK OUT OF WAVE)
G01 Z5 F20000       (BACK OUT OF WAVE)

G01 B90 F20000      (SPIN +90 DEGREES, B=270)

G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z0            (MOVE UP)

(################### FLUX #4 ###################)

G01 X#FLUX_X   F20000   (MOVE TO FLUX) 
G01 Z#FLUX_Z           (DIP IN FLUX)
G04 P1.0             (ENSURE DIP BEFORE SPIN)
G01 Z0           (MOVE UP)
G04 P1.0	    	(WAIT 1 SECOND, DRIP)


(################### PRE-HEAT #4 ###################)

G01 A0 F500         (SET ANGLE TO 0)
G01 X#PREHEAT_X F20000     (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z            (MOVE DOWN)
G04 P10.0           	(WAIT 10 SECONDS)
G01 Z0            	(MOVE UP)
G04 P1.0            	(WAIT 1 SECOND)

(################### SOLDER #4 ###################)

G01 A60 	F1080		(TILT 45 DEGREES)
G04 P1.0
G01 X#SOLDER_X F20000    (MOVE TO PB POT)
G04 P1.0
G01 Z#SOLDER_Z            (MOVE DOWN TOWARDS WAVE)
G04 P1.0
G91                 (SWITCH TO RELAVTIVE COORDINATES)

G01 Z-15  F600      (DIP INTO SOLDER)
G04 P2.0            (WAIT 1.0 SECOND)
G01 Z10 F20000          (BACK OUT OF WAVE)
G01 Z5 F20000       (BACK OUT OF WAVE)

G01 B90 F20000      (SPIN +90 DEGREES, B=270)

G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z0            (MOVE UP)


(###################### RINSE ######################)

#RINSE_X = 435.00 (RINSE_X @ A=0)
G01 A0 F500         (SET ANGLE TO 0)
G04 P1.0            (WAIT 1.0 SECONDS)
#RINSE_Z = -57.00 (RINSE_Z @ A=0)
M26                      (TURN RINSE ON)
G01 X#RINSE_X  F20000    (MOVE TO RINSE)
G01 Z#RINSE_Z            (MOVE DOWN)
G91                      (SWITCH TO RELAVTIVE COORDINATES)
G04 P14.0            (WAIT 14.0 SECOND)
G01 B360 F2000      (SPIN IN RINSE)
G04 P14.0            (WAIT 14.0 SECOND)
G01 B360 F2000      (SPIN IN RINSE)
G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z-20            (MOVE UP)
G04 P1.0            (WAIT 1.0 SECOND)
G01 A0   F1080      (LEVEL HEAD, A=0)
M27                 (TURN RINSE OFF)

(################### RETURN PARTS ###################)

G01 X[#XSTART + [#ROW*#PITCH]+50]  F20000
G01 X[#XSTART + [#ROW*#PITCH]]  F500
G04 P0.5            (WAIT 0.5 SECONDS)
G01 Z[#ZTOUCH + 3] F500       (PUT PARTS DOWN)
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
G01 Z[#ZTOUCH + 4.5] F500       (MOVE UP)
G04 P1.0            (WAIT 1.0 SECOND)
G01 Z0 F2000      (MOVE UP)	
#ROW = #ROW +1
ENDWHILE
G28 		        (SEEK HOME, REF.)