( ********************** TYPICAL SETTINGS ***********************)
( *************** TEST BAR IN BETWEEN SPACERS *******************)
( ***************** PART THICKNESS [MM] = 3.5  ******************)
( ****************** TC TIP JUST TOUCHES WAVE *******************)
( ********************** AUTOFLUX = True  ***********************)
( ********************** FLUX SETTING = 55 **********************)
( ********************* RUN WITH FLUX EMPTY *********************)
( ********************** IR PREHEAT = True **********************)
( ********************** PREHEAT TEMP = 400 *********************)
( ********************** PREHEAT TIME [s] = 30 ******************)
( ********************** SOLDER SPEED [mm/s] = 300 **************)
( ********************** SOLDER PUMP [RPM] = 675 ****************)
(***********************************************************)

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
REAL #SOLDER_HEIGHT
REAL #SPEED_ACROSS_WAVE
REAL #ANGLE_OVER_WAVE
REAL #SOLDER_POSITION
REAL #SOLDER_DIP_DEPTH
REAL #SOLDER_DIP_SPEED_IN
REAL #SOLDER_DWELL
REAL #SOLDER_DIP_SPEED_OUT

REAL #CENTER  (VERTIACAL DISTANCE FROM CENTER TO BAR @ Z=0)
REAL #XCHANGE
REAL #ZCHANGE
(***********************************************************


(********************** OPERATOR ENTER PARAMETERS HERE ***********************
#PART_THICKNESS = 0.4
#CENTER = 180 (IN MM)
(***********************************************************
#FLUX_USED= "YES" 	        (ENTER "YES" OR "NO"
#FLUX_POT_CHOICE= "FLUX1" 	(ENTER "FLUX1" OR "FLUX2" TO SELECT FLUX 1 OR FLUX 2
#FLUX_USED_BETWEEN= "NO"    	(ENTER YES OR NO TO FLUX BETWEEN DIPS FOR PB-PBF OR PBF-PB
#FLUX_HEIGHT= -95 + #PART_THICKNESS	(SET THE BOTTOM OF THE LEAD TO JUST TOUCH THE SURFACE OF THE FLUX
#FLUX_DWELL= 0.5
#FLUX_DRIP_DWELL= 3
#FLUX_DRIP_ANGLE= 40
#FLUX_DIP_SPEED_IN= 2000
#FLUX_DIP_SPEED_OUT= 6000
#FLUX_DIP_DEPTH= 1

(***********************************************************
#PREHEAT_USED= "YES" 	        (ENTER "YES" OR "NO"
#PREHEAT_POSITION = 614
#PREHEAT_HEIGHT= -69 + #PART_THICKNESS
#PREHEAT_DWELL= 45


(***********************************************************
#SOLDER_POT_CHOICE= "LEADRAG"
#SOLDER_HEIGHT= -96.0 + #PART_THICKNESS
#SPEED_ACROSS_WAVE= 300
#SOLDER_POSITION = 1606
#SOLDER_DIP_DEPTH = 5
#SOLDER_DIP_SPEED_IN = 250
#SOLDER_DWELL = 4
#SOLDER_DIP_SPEED_OUT = 350 (Initially 550)
#ANGLE_OVER_WAVE= #ANGVAL
#PALLETWIDTH= 110              	(CHANGING THE PALLET WIDTH TO LESS ALLOWS THE DRAG ANGLE TO BE INCREASED
(***********************************************************



(*********************** END OF OPERATOR DATA INPUT ***************************

M98 PPARTLOAD
G01 X100 Z-5 F4000            	(MOVE TOOL HEAD INTO LOAD POSITION)

IF #FLUX_USED= "YES" THEN
M98 PFLUX		(MOVE TOOL HEAD TO FLUX POSITION AND FLUX
ENDIF

IF #PREHEAT_USED= "YES" THEN
M98 PPREHEAT		(MOVE TO PREHEAT POSITION AND PREHEAT
ENDIF


M98 PLEADFLAT	 	(MOVE TOOL HEAD TO SOLDER POT POSITION AND DIP)

IF #FLUX_USED= "YES" THEN
M98 PFLUX		(MOVE TOOL HEAD TO FLUX POSITION AND FLUX
ENDIF

IF #PREHEAT_USED= "YES" THEN
M98 PPREHEAT		(MOVE TO PREHEAT POSITION AND PREHEAT
ENDIF


M98 PLEADFLAT	 	(MOVE TOOL HEAD TO SOLDER POT POSITION AND DIP)


M98 PSOLDERPUMPSTOP

M98 PPARTUNLOAD			(MOVE TO UNLOAD POSITION
G56
M98 PUNLOAD
M30
