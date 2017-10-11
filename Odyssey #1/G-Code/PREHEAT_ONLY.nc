#R:\Manufacturing\Robotic Solder\Odyssey Programs\Odyssey #1\SUBROUTINES\ODYSSEY1 SUBROUTINES.nc
M98 PLOAD
(Initialization Complete )
G52 X0 Y0 Z0  (Calibration Offsets)


( ********************** MAIN G-CODE ***********************

(DECLARE VARIABLES HERE
(***********************************************************
REAL #PART_THICKNESS
REAL #PREHEAT_DWELL
REAL #PREHEAT_POSITION
REAL #PREHEAT_HEIGHT
(***********************************************************

(********************** OPERATOR ENTER PARAMETERS HERE ***********************
#PART_THICKNESS = 0

#PREHEAT_DWELL= 60 (PREHEAT TIME)
#PREHEAT_POSITION = 625
#PREHEAT_HEIGHT= -90 + #PART_THICKNESS
(*********************** END OF OPERATOR DATA INPUT ***************************

M98 PPARTLOAD
G01 X100 Z-5 F4000            	(MOVE TOOL HEAD INTO LOAD POSITION)

M98 PPARTPREHEAT		(MOVE TO PREHEAT POSITION AND PREHEAT

M98 PPARTUNLOAD			(MOVE TO UNLOAD POSITION
G56
M98 PUNLOAD
M30
