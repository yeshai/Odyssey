
(################### SETUP ###################)
OSETUP
G59                 (SELECT 8UP TOOLING, OFFSETS)
G28 		        (SEEK HOME, REF.)
M99
(################### PICKUP ###################)
OPICKUP
M32                 (TURN VACUUM ON)
M43		       		(OPEN BLOW OFF)
G04 P0.5            (WAIT 0.5 SECONDS)
M44                 (CLOSE BLOW OFF)
M39                 (TURN FLUX ON)
M41                 (TURN N2 ON, PB-FREE)
M18 S#PUMP2RPM      (TURN SOLDER PUMP ON, PB-FREE)
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
M99
(################### FLUX #1 ###################)
OFLUX
(#FLUX_X = #XSTART + 648 (FLUX X @ A=60)
(#FLUX_Z = #ZTOUCH - 33 (FLUX Z @ A=60)

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
M40                (TURN FLUX OFF)
M99
(################### PRE-HEAT #1 ###################)
OPREHEAT1
(#PREHEAT_X = #XSTART + 588.5	(PRE-HEAT X @ A=0)
(#PREHEAT_Z = #ZTOUCH + 2.1	(PRE-HEAT Z @ A=0)

G01 X#PREHEAT_X F20000  (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z         (MOVE DOWN)
G04 P#PREHEAT_TIME_01     (WAIT PREHEAT_TIME_01 SECONDS)
G01 Z0            		(MOVE UP)
G04 P1.0            	(WAIT 1 SECOND)
M99
(################### PRE-HEAT #2 ###################)
OPREHEAT2
(#PREHEAT_X = #XSTART + 588.5	(PRE-HEAT X @ A=0)
(#PREHEAT_Z = #ZTOUCH + 2.1	(PRE-HEAT Z @ A=0)

G01 X#PREHEAT_X F20000  (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z         (MOVE DOWN)
G04 P#PREHEAT_TIME_02     (WAIT PREHEAT_TIME_01 SECONDS)
G01 Z0            		(MOVE UP)
G04 P1.0            	(WAIT 1 SECOND)
M99
(################### SOLDER ###################)
OSOLDER
(#SOLDER_X = #XSTART + 1817.92 (SOLDER X @ A=45)
#SOLDER_Z = #ZTOUCH + 19.52 	(SOLDER Z @ A=45)

G01 X#SOLDER_X F20000    (MOVE TO PB-FREE POT)
G01 A45 	F1080		(TILT 45 DEGREES)
G01 Z#SOLDER_Z            (MOVE DOWN TOWARDS WAVE)
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
M19                 (TURN SOLDER PUMP OFF, PB-FREE)
M42                 (TURN N2 OFF, PB-FREE)
M99
(###################### RINSE ######################)
ORINSE
(#RINSE_X = #XSTART + 189.5 (RINSE_X @ A=60)
(#RINSE_Z = #ZTOUCH - 34    (RINSE_Z @ A=60)

M26                      (TURN RINSE ON)
G01 X#RINSE_X  F20000    (MOVE TO RINSE)
G01 A60
G01 Z#RINSE_Z            (MOVE DOWN)
G91                      (SWITCH TO RELAVTIVE COORDINATES)
G01 B360 F2000      (SPIN IN RINSE)
G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z-20            (MOVE UP)
G04 P1.0            (WAIT 1.0 SECOND)
G01 A0   F1080       (LEVEL HEAD, A=0)
M27                 (TURN RINSE OFF)
M99
(################### RETURN PARTS ###################)
ORETURN
G01 X[#XSTART + [#ROW*#PITCH]+50]  F20000
G01 X[#XSTART-0.25 + [#ROW*#PITCH]]  F500 (ADD 0.25 MM FOR DROPOFF)
G04 P0.5            (WAIT 0.5 SECONDS)
G01 Z[#ZTOUCH + 2] F500       (PUT PARTS DOWN)
M33                 (TURN VACUUM OFF)
M29		        (TURN OFF VACUUM SOLENOID, SUCTION)
M43                 (OPEN TO ATMOSPHERE)
G04 P1.5            (WAIT 1.5 SECONDS)
G01 Z[#ZTOUCH +3] F500       (MOVE UP)
M44                 (CLOSE TO ATMOSPHERE)
M24                 (TURN ON AIR KNIFE)
G04 P2.0            (WAIT 2.0 SECONDS)
M25                 (TURN OFF AIR KNIFE)
M43                 (OPEN TO ATMOSPHERE)
G01 Z[#ZTOUCH + 4] F500       (MOVE UP)
G04 P1.0            (WAIT 1.0 SECOND)
G01 Z0 F2000      (MOVE UP)	
(################### END CYCLE ###################)
OEND_CYCLE
G28 		        (SEEK HOME, REF.)
M40                 (TURN FLUX OFF)
M99