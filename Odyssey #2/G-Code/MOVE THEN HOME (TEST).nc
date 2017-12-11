#R:\Manufacturing\Robotic Solder\Odyssey Programs\Odyssey #2\SUBROUTINES\ODYSSEY2 SUBROUTINES.nc
M98 PLOAD (Turn on dross wiper, airknife and lights. Then, HOME)
(Initialization Complete)
G52 X0 Y0 Z0  (Calibration Offsets)
G01 X900 F20000 (Move to X=900)
G04 P2 (Wait 2 Seconds)

M98 PPARTUNLOAD			(MOVE TO UNLOAD POSITION)
G56
M98 PUNLOAD
M30 (END PROGRAM AND RESET)
