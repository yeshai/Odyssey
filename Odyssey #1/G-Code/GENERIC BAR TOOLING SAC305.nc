#R:\Manufacturing\Robotic Solder\Odyssey Programs\Odyssey #1\SUBROUTINES\ODYSSEY1 SUBROUTINES.nc
M98 PLOAD
(Initialization Complete )
G52 X0 Y0 Z0  (Calibration Offsets)


( ********************** MAIN G-CODE ***********************

(DECLARE VARIABLES HERE
(***********************************************************
REAL #PART_THICKNESS
REAL #ANGHYP
REAL #VERTCHANGE
REAL #PALLETWIDTH
(***********************************************************
STRING #FLUX_USED
STRING #FLUX_POT_CHOICE
STRING #FLUX_USED_BETWEEN
INTEGER #FLUX_BETWEEN_FLAG
REAL #FLUX_HEIGHT
REAL #FLUX_DWELL
REAL #FLUX_DRIP_DWELL
REAL #FLUX_DRIP_ANGLE
REAL #FLUX_DIP_SPEED_IN
REAL #FLUX_DIP_SPEED_OUT
REAL #FLUX_DIP_DEPTH
(***********************************************************
STRING #PREHEAT_USED
REAL #PREHEAT_POSITION
REAL #PREHEAT_HEIGHT
REAL #PREHEAT_DWELL
(***********************************************************
STRING #SOLDER_POT_CHOICE
REAL #SOLDER_HEIGHT_PBF
REAL #SPEED_ACROSS_WAVE_PBF
REAL #ANGLE_OVER_WAVE_PBF
REAL #SOLDER_POSITION_PBF
(***********************************************************
STRING #WASH_TYPE
STRING #WASH_USED
REAL #WASH_HEIGHT
REAL #NUMBER_OF_WASH_SHAKES
REAL #WASH_DWELL
REAL #WASH_DRIP_DWELL
REAL #WASH_DRIP_ANGLE
REAL #WASH_SPEED_IN
REAL #WASH_SPEED_OUT
(***********************************************************
STRING #DRY_TYPE
STRING #DRY_USED
REAL #DRY_HEIGHT
REAL #NUMBER_OF_DRY_SHAKES
REAL #DRY_DWELL
(***********************************************************

(********************** OPERATOR ENTER PARAMETERS HERE ***********************
#PART_THICKNESS = 1

(***********************************************************
#FLUX_USED= "NO" 	        (ENTER "YES" OR "NO"
#FLUX_POT_CHOICE= "FLUX1" 	(ENTER "FLUX1" OR "FLUX2" TO SELECT FLUX 1 OR FLUX 2
#FLUX_USED_BETWEEN= "NO"    	(ENTER YES OR NO TO FLUX BETWEEN DIPS FOR PB-PBF OR PBF-PB
#FLUX_HEIGHT= -97.0 		(SET THE BOTTOM OF THE LEAD TO JUST TOUCH THE SURFACE OF THE FLUX
#FLUX_DWELL= 0.6
#FLUX_DRIP_DWELL= 3
#FLUX_DRIP_ANGLE= 40
#FLUX_DIP_SPEED_IN= 2000
#FLUX_DIP_SPEED_OUT= 6000
#FLUX_DIP_DEPTH= 1

(***********************************************************
#PREHEAT_USED= "YES" 	        (ENTER "YES" OR "NO"
#PREHEAT_POSITION = 615
#PREHEAT_HEIGHT= -90 + #PART_THICKNESS
#PREHEAT_DWELL= 10

(***********************************************************
#SOLDER_POT_CHOICE= "LEADFREEDRAG"
#SOLDER_HEIGHT_PBF= -80 + #PART_THICKNESS
#SPEED_ACROSS_WAVE_PBF= 600
#SOLDER_POSITION_PBF = 1900
#ANGLE_OVER_WAVE_PBF= 0
#PALLETWIDTH= 170              	(CHANGING THE PALLET WIDTH TO LESS ALLOWS THE DRAG ANGLE TO BE INCREASED
(***********************************************************
#WASH_USED= "NO" (ENTER "YES" OR "NO"
#WASH_TYPE= "WASHSHAKE"         (ENTER "WASH" OR "WASHSHAKE" TO SELECT STATIONARY OR SHAKING WASH
#WASH_HEIGHT= -103.0		(SET TO THE DEPTH YOU WANT TO SUBMERGE THE PART IN THE WASH
#NUMBER_OF_WASH_SHAKES= 30      (IF SHAKE WASH SELECTED
#WASH_DWELL= 10                 (IF STATIONARY WASH SELECTED
#WASH_DRIP_DWELL= 4
#WASH_DRIP_ANGLE= 20
#WASH_SPEED_IN= 4000
#WASH_SPEED_OUT= 6000

(***********************************************************
#DRY_USED= "NO"                 (ENTER "YES" OR "NO"
#DRY_TYPE= "DRY"           	(ENTER "DRY" OR "DRYSHAKE" TO SELECT STATIONARY OR VERTICAL OSCILLATIONS
#DRY_HEIGHT= -10		(SET THE HEIGHT THAT GIVES THE BEST COVERAGE FOR THE AIR KNIFE
#NUMBER_OF_DRY_SHAKES= 5
#DRY_DWELL= 2

(***********************************************************

(*********************** END OF OPERATOR DATA INPUT ***************************

M98 PPARTLOAD
G01 X100 Z-5 F4000            	(MOVE TOOL HEAD INTO LOAD POSITION)

IF #FLUX_USED= "YES" THEN
M98 #FLUX_POT_CHOICE		(MOVE TOOL HEAD TO FLUX POSITION AND FLUX
ENDIF

IF #PREHEAT_USED= "YES" THEN
M98 PPREHEAT		(MOVE TO PREHEAT POSITION AND PREHEAT
ENDIF

M98 PPUMP2START
M98 PLEADFREEDRAG		 	(MOVE TOOL HEAD TO SOLDER POT POSITION AND DIP

IF #WASH_USED= "YES" THEN
M98 PPARTWASH			(MOVE TO WASH STATION AND WASH
ENDIF

IF #DRY_USED= "YES" THEN
M98 PPARTDRY			(TURN ON AIR KNIFE FOR DRY ASSIST
ENDIF

M98 PSOLDERPUMPSTOP

M98 PPARTUNLOAD			(MOVE TO UNLOAD POSITION
G56
M98 PUNLOAD
M30
