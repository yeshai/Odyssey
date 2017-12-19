#R:\Manufacturing\Robotic Solder\Odyssey Programs\Odyssey #2\SUBROUTINES\ODYSSEY2 SUBROUTINES.nc
M98 PLOAD (TURN ON DROSS WIPER, AIR-KNIFE AND LIGHTS. THEN, HOME)
G52 X0 Y0 Z0  (CALIBRATION OFFSET)
G01 X900 F20000 (MOVE TO X=900, FEEDRATE = 20000)
G04 P2 (WAIT 2 SECONDS)

M98 PPARTUNLOAD			(MOVE TO UNLOAD POSITION)
G56						(PROGRAM ZERO)
M98 PUNLOAD				(RUN UNLOAD SUBROUTINE)
M30 (END PROGRAM AND RESET)
