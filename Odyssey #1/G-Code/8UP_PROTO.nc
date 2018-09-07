
(################### SETUP ###################)

G59                 (SELECT 8UP TOOLING, OFFSETS)
G28 		        (SEEK HOME, REF.)
M43		        (OPEN BLOW OFF)
G04 P0.5            (WAIT 0.5 SECONDS)
M44                 (CLOSE BLOW OFF)
M32                 (TURN VACUUM ON)
M39                 (TURN FLUX ON)
M41                 (TURN N2 ON, PB-FREE)
M18 S#PUMP2RPM      (TURN SOLDER PUMP ON, PB-FREE)

(################### PICKUP ###################)

G52 X0 Y0 Z0 B0     (REZERO ALL)
G01 A0 F1080        (LEVEL HEAD)
G01 X54 F5000       (MOVE X TO PICK UP PARTS)
G01 Z-94.5 F500       (MOVE Z TO PICK UP PARTS)
M28		    (TURN ON VACUUM SOLENOID, SUCTION)
G04 P2.0            (WAIT 2 SECONDS)
G01 Z-30 F500       (MOVE UP)

(################### FLUX ###################)
(NOTE: AT A = 0, X = 869)

G01 X693   F20000   (MOVE TO FLUX)
G01 A60             (TILT)
G01 Z-89           (DIP IN FLUX) 
G91                 (SWITCH TO RELAVTIVE COORDINATES)
G01 B360 F20000     (SPIN 360 DEGREES)
G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z-20            (MOVE UP)
G04 P1.0	    (WAIT 1 SECOND, DRIP)
G01 A0              (SET ANGLE TO 0)
M40                 (TURN FLUX OFF)

(################### PRE-HEAT ###################)

G01 X623 F20000     (MOVE TO PREHEAT)
G01 Z-80.5            (MOVE DOWN)
G04 P30.0           (WAIT 30 SECONDS)
G01 Z-20            (MOVE UP)
G04 P1.0            (WAIT 1 SECOND)

(################### SOLDER ###################)

G01 X1888 F20000    (MOVE TO PB-FREE POT)
G01 A45 	F10000	(TILT 45 DEGREES)
G01 Z-56.5            (MOVE DOWN TOWARDS WAVE)
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
G01 Z-20            (MOVE UP)
G01 A0
M19                 (TURN SOLDER PUMP OFF, PB-FREE)
M42                 (TURN N2 OFF, PB-FREE)

(###################### RINSE ######################)
M26                 (TURN RINSE ON)
G01 X422            (MOVE TO RINSE)
G01 Z-84            (MOVE DOWN)
G91                 (SWITCH TO RELAVTIVE COORDINATES)
G01 B360 F2000      (SPIN IN RINSE)
G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z-20            (MOVE UP)
G91                 (SWITCH TO RELAVTIVE COORDINATES)
G01 X-20
G01 A45             (TILT TO DRIP)
G01 B360 F2000      (SPIN IN RINSE)
G04 P1.5            (WAIT 1.5 SECONDS)
G01 X20
G01 A-90            (TILT TO DRIP)
G01 B360 F2000      (SPIN IN RINSE)
G04 P1.5            (WAIT 1.5 SECONDS)
G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 A0              (LEVEL HEAD, A=0)
M27                 (TURN RINSE OFF)

(################### HEAT DRY ###################)

G01 X623 F20000     (MOVE TO PREHEAT)
G01 Z-80.5            (MOVE DOWN)
G04 P5.0           (WAIT 30 SECONDS)
G01 Z-20            (MOVE UP)
G04 P1.0            (WAIT 1 SECOND)

(################### RETURN PARTS ###################)

G01 X60 F20000
G01 X54 F500
G04 P0.5            (WAIT 0.5 SECONDS)
G01 Z-89 F500       (PUT PARTS DOWN)
M33                 (TURN VACUUM OFF)
M29		        (TURN OFF VACUUM SOLENOID, SUCTION)
M43                 (OPEN BLOW OFF)
(G01 Z-94.5            (MOVE UP SLIGHTLY)
G04 P4.0            (WAIT 4.0 SECONDS)
(G01 X52    (SHEER IF NEEDED)
(G01 Z-94            (MOVE UP SLIGHTLY)
G04 P1.0            (WAIT 1.0 SECOND)
M44                 (VACUUM BLOW OFF STOP)
G01 Z-20 F20000      (MOVE UP)
G01 X180 F20000      (MOVE OVER)