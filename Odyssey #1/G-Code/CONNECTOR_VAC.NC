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

#XSTART = 55.793
#ZTOUCH = -61

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

(################### FLUX  ###################)

#FLUX_X = 678
#FLUX_Z = -76 
G01 X#FLUX_X   F20000   (MOVE TO FLUX)
G01 A60     F1080        (TILT) 
G01 Z#FLUX_Z   F800    (DIP IN FLUX) 
G01 Z0            (MOVE UP)
G04 P2.5	        (WAIT 2.5 SECOND, DRIP)
(M40                (TURN FLUX OFF)

(################### PRE-HEAT ###################)

#PREHEAT_X = 454
#PREHEAT_Z = -65

M16 (TURN ON SOLDER PUMP)
M34 (TURN ON N2)

G01 X#PREHEAT_X F20000      (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z (MOVE DOWN)
G04 P30.0            (WAIT 30 SECONDS)
G01 Z0             (MOVE UP)
G04 P1.0             (WAIT 1 SECOND)
(################### SOLDER ###################)


#SOLDER_X = 1537.5
#SOLDER_Z = -30

G01 X#SOLDER_X  F20000    (MOVE TO SOLDER POT)
G01 Z#SOLDER_Z       (MOVE DOWN TOWARDS WAVE)
G91                 (SWITCH TO RELAVTIVE COORDINATES)
G01 Z-5  F200      (DIP INTO SOLDER)
G04 P2.0            (WAIT 2.0 SECONDS)
G01 Z5 B-25 F200         (BACK OUT OF WAVE)
G01 Z3 B25 F20000       (BACK OUT OF WAVE)
G90                 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z0           (MOVE UP)
M17                 (TURN OFF SOLDER PUMP)
M35                 (TURN OFF N2)

(###################### RINSE ######################)

#RINSE_X = 264
#RINSE_Z = -75

M26                 (TURN RINSE ON)
G01 X#RINSE_X  F20000    (MOVE TO RINSE)
G01 Z#RINSE_Z       (MOVE DOWN)
G04 P2.5            (WAIT 2.5 SECONDS)
G01 Z0            (MOVE UP)
G04 P2.5            (WAIT 2.5 SECONDS)
M27                 (TURN RINSE OFF)

(################### HEAT DRY ###################)

G01 X#PREHEAT_X F20000     (MOVE TO PREHEAT)
G01 Z#PREHEAT_Z     (MOVE DOWN)
G04 P5.0           (WAIT 30 SECONDS)
G01 Z0            (MOVE UP)
G04 P1.0            (WAIT 1 SECOND)
(################### RETURN PARTS ###################)
G01 A0
G01 X[#XSTART + [#ROW*#PITCH]+50]  F20000
G01 X[#XSTART + [#ROW*#PITCH]]  F500
G04 P0.5            (WAIT 0.5 SECONDS)
G01 Z[#ZTOUCH + 0.5] F500       (PUT PARTS DOWN)
M33                 (TURN VACUUM OFF)
M29		        (TURN OFF VACUUM SOLENOID, SUCTION)
M43                 (OPEN TO ATMOSPHERE)
M44                 (CLOSE TO ATMOSPHERE)
(M24                 (TURN ON AIR KNIFE)
G04 P0.5            (WAIT 0.5 SECONDS)
G01 Z[#ZTOUCH + 1.0] F500       (MOVE UP)
G04 P5.5            (WAIT 5.5 SECONDS)
M25                 (TURN OFF AIR KNIFE)		
M43                 (OPEN TO ATMOSPHERE)
(G01 Z[#ZTOUCH + 2.0] F500       (MOVE UP)
G04 P2.5            (WAIT 2.5 SECONDS)
G01 Z0 F2000      (MOVE UP)

#ROW = #ROW +1
ENDWHILE
G28 		        (SEEK HOME, REF.)