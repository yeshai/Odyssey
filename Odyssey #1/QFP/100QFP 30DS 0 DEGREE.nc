#C:\MaestroLite Data\MICROSS SUB UTILITIES ODYSSEY CREWE - 2.nc
(M98 PPUMP1START
M98 PLOAD
(Initialization Complete )
G52 X0 Y0 Z0  (Calibration Offsets)
 
 
( ********************** MAIN G-CODE *********************** 

(DECLARE VARIABLES HERE
(***********************************************************
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
REAL #PREHEAT_HEIGHT
REAL #PREHEAT_DWELL
(***********************************************************
STRING #SOLDER_POT_CHOICE
REAL #SOLDER_HEIGHT_PB
REAL #SPEED_ACROSS_WAVE_PB
REAL #ANGLE_OVER_WAVE_PB
REAL #SOLDER_HEIGHT_PBF
REAL #SPEED_ACROSS_WAVE_PBF
REAL #ANGLE_OVER_WAVE_PBF
INTEGER #NUMBER_OF_DIPS
REAL #SOLDER_POSITION_PB
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

(***********************************************************
#FLUX_USED= "YES" 	        (ENTER "YES" OR "NO"
#FLUX_POT_CHOICE= "FLUX1" 	(ENTER "FLUX1" OR "FLUX2" TO SELECT FLUX 1 OR FLUX 2
#FLUX_USED_BETWEEN= "YES"    	(ENTER YES OR NO TO FLUX BETWEEN DIPS FOR PB-PBF OR PBF-PB
#FLUX_HEIGHT= -96.0		(SET THE BOTTOM OF THE LEAD TO JUST TOUCH THE SURFACE OF THE FLUX
#FLUX_DWELL= 0.5
#FLUX_DRIP_DWELL= 2
#FLUX_DRIP_ANGLE= 35
#FLUX_DIP_SPEED_IN= 2000
#FLUX_DIP_SPEED_OUT= 6000
#FLUX_DIP_DEPTH= 1

(***********************************************************
#PREHEAT_USED= "YES" 	        (ENTER "YES" OR "NO"
#PREHEAT_HEIGHT= -70
#PREHEAT_DWELL= 40

(***********************************************************
#SOLDER_POT_CHOICE= "LEADDRAG"  (ENTER "LEADDRAG" OR "LEADFREEDRAG" TO SELECT LEADED SOLDER OR LEAD FREE SOLDER OR PBF-PB OR PB-PBF
#SOLDER_HEIGHT_PB= -62.9        (-107.0AT40DEG
#SPEED_ACROSS_WAVE_PB= 600
#ANGLE_OVER_WAVE_PB= 0
#SOLDER_POSITION_PB= 1623        (1540=40DEG

#SOLDER_HEIGHT_PBF= -67
#SPEED_ACROSS_WAVE_PBF= 1000
#ANGLE_OVER_WAVE_PBF= 0
#NUMBER_OF_DIPS= 1            	(NUMBER OF DIPS
#SOLDER_POSITION_PBF= 1909.4
#PALLETWIDTH= 150              	(CHANGING THE PALLET WIDTH TO LESS ALLOWS THE DRAG ANGLE TO BE INCREASED
(***********************************************************
#WASH_USED= "NO"                (ENTER "YES" OR "NO"
#WASH_TYPE= "WASHSHAKE"         (ENTER "WASH" OR "WASHSHAKE" TO SELECT STATIONARY OR SHAKING WASH
#WASH_HEIGHT= -96.5		(SET TO THE DEPTH YOU WANT TO SUBMERGE THE PART IN THE WASH
#NUMBER_OF_WASH_SHAKES= 20      (IF SHAKE WASH SELECTED
#WASH_DWELL= 10                 (IF STATIONARY WASH SELECTED
#WASH_DRIP_DWELL= 3
#WASH_DRIP_ANGLE= 10
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
#FLUX_BETWEEN_FLAG= 0
WHILE #NUMBER_OF_DIPS>0 DO	(PROCESSES STAGES BETWEEN WHILE AND ENDWHILE FOR NUMBER_OF_DIPS

IF #FLUX_USED= "YES" THEN
M98 P#FLUX_POT_CHOICE		(MOVE TOOL HEAD TO FLUX POSITION AND FLUX
ENDIF


M98 PPARTPREHEAT		(MOVE TO PREHEAT POSITION AND PREHEAT


IF #SOLDER_POT_CHOICE= "LEADDRAG" THEN
M98 PLEADDRAG		 	(MOVE TOOL HEAD TO SOLDER POT POSITION AND DIP
ENDIF

IF #SOLDER_POT_CHOICE= "LEADFREEDRAG" THEN
M98 PLEADFREEDRAG		(MOVE TOOL HEAD TO SOLDER POT POSITION AND DIP
ENDIF

IF #SOLDER_POT_CHOICE= "PBF-PB" THEN
M98 PLEADFREEDRAG		(MOVE TOOL HEAD TO SOLDER POT POSITION AND DIP
IF #FLUX_USED_BETWEEN= "YES" THEN
M98 P#FLUX_POT_CHOICE		(MOVE TOOL HEAD TO FLUX POSITION AND FLUX
#FLUX_BETWEEN_FLAG=1
M98 PPARTPREHEAT		(MOVE TO PREHEAT POSITION AND PREHEAT
ENDIF
M98 PLEADDRAG		 	(MOVE TOOL HEAD TO SOLDER POT POSITION AND DIP
ENDIF

IF #SOLDER_POT_CHOICE= "PB-PBF" THEN
M98 PLEADDRAG		 	(MOVE TOOL HEAD TO SOLDER POT POSITION AND DIP
IF #FLUX_USED_BETWEEN= "YES" THEN
M98 P#FLUX_POT_CHOICE		(MOVE TOOL HEAD TO FLUX POSITION AND FLUX
#FLUX_BETWEEN_FLAG=1
M98 PPARTPREHEAT		(MOVE TO PREHEAT POSITION AND PREHEAT
ENDIF
M98 PLEADFREEDRAG		(MOVE TOOL HEAD TO SOLDER POT POSITION AND DIP
ENDIF

#NUMBER_OF_DIPS= #NUMBER_OF_DIPS-1

ENDWHILE

IF #WASH_USED= "YES" THEN
M98 PPARTWASH			(MOVE TO WASH STATION AND WASH
ENDIF


IF #DRY_USED= "YES" THEN
M98 PPARTDRY			(TURN ON AIR KNIFE FOR DRY ASSIST

ENDIF
#FLUX_BETWEEN_FLAG=0
M98 PPARTUNLOAD			(MOVE TO UNLOAD POSITION

G56
M98 PUNLOAD
M30.1