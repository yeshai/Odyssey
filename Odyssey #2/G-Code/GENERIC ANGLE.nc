#R:\Manufacturing\Robotic Solder\Odyssey Programs\Odyssey #2\SUBROUTINES\ODYSSEY2 SUBROUTINES.nc

( ******************** TYPICAL SETTINGS *********************)
( ******************** AUTOFLUX = True  *********************)
( ******************** IR PREHEAT = True  *******************)
( ******************** PREHEAT TIME [s] = 60 ****************)
( ******************** SOLDER SPEED [mm/s] = 500 ************)
( ******************** SOLDER PUMP [RPM] = 500 **************)
(************************************************************)

(******************** DECLARE VARIABLES ********************)
REAL #FLUX_HEIGHT
REAL #FLUX_TIME
REAL #FLUX_DRIP_TIME
REAL #FLUX_DRIP_ANGLE
REAL #FLUX_DIP_SPEED_IN
REAL #FLUX_DIP_SPEED_OUT
REAL #FLUX_DIP_DEPTH
REAL #PREHEAT_HEIGHT
REAL #SOLDER_HEIGHT
REAL #ANGHYP
REAL #VERTCHANGE
REAL #PALLETWIDTH
REAL #RADIUS
REAL #PI
REAL #XC (X COORDIANTE ON CIRCLE)
REAL #ZC (Z COORDIANTE ON CIRCLE)
REAL #M (TANGENT LINE SLOPE)
REAL #ZINT (TANGENT LINE INTERCEPT)
REAL #XL (X COORDIANTE ON TANGENT LINE)
REAL #ZL (Z COORDIANTE ON TANGENT LINE)
(***********************************************************)
(********************** SET PARAMETERS *********************)


(*********************** CONSTANTS *************************)
#RADIUS = 166.0652
#PI = 3.1416


(************************** FLUX ***************************)
#FLUX_HEIGHT= -75.5 + #PART_THICKNESS	
#FLUX_TIME= 0.5        		(TIME IN FLUX)
#FLUX_DRIP_TIME= 3     		(TIME TO DRIP OFF FLUX)
#FLUX_DRIP_ANGLE= 40    	(ANGLE TO DRIP OFF FLUX)
#FLUX_DIP_SPEED_IN= 2000	
#FLUX_DIP_SPEED_OUT= 6000
#FLUX_DIP_DEPTH= 1        

(*********************** PREHEAT ***************************)
#PREHEAT_HEIGHT= -65 + #PART_THICKNESS

(************************ SOLDER ***************************)
#PALLETWIDTH= 60.5522
#SOLDER_HEIGHT= -70 + #PART_THICKNESS 

(********************* MAIN PROGRAM ************************)
M98 PLOAD (INITIALIZE AND HOME)
G52 X0 Y0 Z0  (SET CALIBRATION OFFSETS)

M98 PPARTLOAD

IF #FLUX_USED= TRUE THEN
	M98 PFLUX		  (MOVE TO FLUX POSITION AND DIP)
ENDIF

IF #PREHEAT_USED= TRUE THEN
	M98 PPREHEAT	 (MOVE TO PREHEAT POSITION AND PREHEAT)
ENDIF

M98 PPUMPSTART       (START SOLDER PUMP)
M98 PSOLDERDIP		 (MOVE TO SOLDER POT POSITION AND DIP)

M98 PPARTUNLOAD		(MOVE TO UNLOAD POSITION)
G56
M98 PUNLOAD
M30 				(END PROGRAM AND RESET)