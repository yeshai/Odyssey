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


#ROW = 0
#ROWS = 0 (COUNT STARTS AT 0)
#PITCH = 42.3418 (1.667 INCHES)

#XSTART = 56.793
#ZTOUCH = -60.4
#ZTOUCH = #ZTOUCH + 9.7 (ADD SUCTION CUP & PART)

WHILE #ROW <= #ROWS DO 

(################### SETUP ###################)

G59                 (SELECT 8UP TOOLING, OFFSETS)
G28 		        (SEEK HOME, REF.)
M32                 (TURN VACUUM ON)
M43		        (OPEN BLOW OFF)
G04 P0.5            (WAIT 0.5 SECONDS)
M44                 (CLOSE BLOW OFF)

(################### PICKUP ###################)

G52 X0 Y0 Z0 A0 B0     (REZERO ALL)
G01 A0 F1080        (LEVEL HEAD)
G01 X[#XSTART + [#ROW*#PITCH]] F5000       (MOVE X TO PICK UP PARTS)
G01 Z[#ZTOUCH] F500       (MOVE Z TO PICK UP PARTS)
M28		    (TURN ON VACUUM SOLENOID, SUCTION)
G04 P3.5            (WAIT 3.5 SECONDS)
G01 Z0 F500       (MOVE UP)
G91                 (SWITCH TO RELAVTIVE COORDINATES)
G01 B90 F2000      (SPIN 90 DEGREES)
G90                 (SWITCH TO ABSOLUTE COORDINATES)

(################### FLUX  ###################)

#FLUX_X = 864
#FLUX_Z = -42 
G01 X#FLUX_X   F20000   (MOVE TO FLUX)
G01 Z#FLUX_Z        (DIP IN FLUX) 
G01 Z0            (MOVE UP)
G04 P1.0	        (WAIT 1 SECOND, DRIP)
G01 A0 F500         (SET ANGLE TO 0)
(M40                (TURN FLUX OFF)

(################### PRE-HEAT ###################)

#PREHEAT_X = 640
#PREHEAT_Z = -30

G01 X#PREHEAT_X F20000      (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z (MOVE DOWN)
G04 P30.0            (WAIT 30 SECONDS)
G01 Z0             (MOVE UP)
G04 P1.0             (WAIT 1 SECOND)

(################### SOLDER ###################)


#SOLDER_X = 1715
#SOLDER_Z = 0

G01 X#SOLDER_X  F20000    (MOVE TO SOLDER POT)
G01 Z#SOLDER_Z       (MOVE DOWN TOWARDS WAVE)
G91                 (SWITCH TO RELAVTIVE COORDINATES)
G01 B-90 F2000      (SPIN -90 DEGREES)
G01 Z-6  F600      (DIP INTO SOLDER)
G04 P1.0            (WAIT 1.0 SECOND)
G01 Z3 F300         (BACK OUT OF WAVE)
G01 Z3 F20000       (BACK OUT OF WAVE)
G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z0           (MOVE UP)
G01 A0       F1080
(M19                 (TURN SOLDER PUMP OFF, PB-FREE)
(M42                 (TURN N2 OFF, PB-FREE)

(###################### RINSE ######################)

#RINSE_X = 447.4
#RINSE_Z = -41

M26                 (TURN RINSE ON)
G01 X#RINSE_X  F20000    (MOVE TO RINSE)
G01 Z#RINSE_Z       (MOVE DOWN)
G04 P2.5            (WAIT 2.5 SECONDS)
G01 Z0            (MOVE UP)
G91                 (SWITCH TO RELAVTIVE COORDINATES)
G01 X-115 F20000
G01 A45             (TILT TO DRIP)
G01 A5 F2000             (SHAKE)
G01 A-5 F2000             (SHAKE)
G01 A10 F2000             (SHAKE)
G01 A-10 F2000             (SHAKE)
G04 P2.5            (WAIT 2.5 SECONDS)
G01 A5 F2000             (SHAKE)
G01 A-5 F2000             (SHAKE)
G01 X230 F20000
G01 A-90            (TILT TO DRIP)
G01 A5 F2000             (SHAKE)
G01 A-5 F2000             (SHAKE)
G01 A10 F2000             (SHAKE)
G01 A-10 F2000             (SHAKE)
G04 P2.5            (WAIT 2.5 SECONDS)
G01 A5 F2000             (SHAKE)
G01 A-5 F2000             (SHAKE)
G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 A0   F1080      (LEVEL HEAD, A=0)
M27                 (TURN RINSE OFF)

(################### HEAT DRY ###################)

G01 X#PREHEAT_X F20000     (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z     (MOVE DOWN)
G04 P5.0           (WAIT 30 SECONDS)
G01 Z0            (MOVE UP)
G04 P1.0            (WAIT 1 SECOND)

(################### RETURN PARTS ###################)

G01 X[#XSTART + [#ROW*#PITCH]+50]  F20000
G01 X[#XSTART + [#ROW*#PITCH]]  F500
G04 P0.5            (WAIT 0.5 SECONDS)
G01 Z[#ZTOUCH + 0.5] F500       (PUT PARTS DOWN)
M33                 (TURN VACUUM OFF)
M29		        (TURN OFF VACUUM SOLENOID, SUCTION)
M43                 (OPEN TO ATMOSPHERE)
M44                 (CLOSE TO ATMOSPHERE)
M24                 (TURN ON AIR KNIFE)
G04 P0.5            (WAIT 0.5 SECONDS)
G01 Z[#ZTOUCH + 1.0] F500       (MOVE UP)
G04 P5.5            (WAIT 5.5 SECONDS)
M25                 (TURN OFF AIR KNIFE)		
M43                 (OPEN TO ATMOSPHERE)
G01 Z[#ZTOUCH + 2.0] F500       (MOVE UP)
G04 P2.5            (WAIT 2.5 SECONDS)
G01 Z0 F2000      (MOVE UP)

#ROW = #ROW +1
ENDWHILE
G28 		        (SEEK HOME, REF.)