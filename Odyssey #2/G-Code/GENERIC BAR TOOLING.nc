#C:\Users\Odyssey.User\Desktop\Odyssey #2\SUBROUTINES\ODYSSEY2 SUBROUTINES.nc
M98 PLOAD (Turn on dross wiper, airknife and lights. Then, HOME)
(Initialization Complete)
G52 X0 Y0 Z0  (Calibration Offsets)
( ********************** MAIN G-CODE ***********************)

(DECLARE VARIABLES HERE
(***********************************************************)
REAL #ANGHYP
REAL #VERTCHANGE
REAL #PALLETWIDTH
(***********************************************************)
REAL #FLUX_HEIGHT
REAL #FLUX_TIME
REAL #FLUX_DRIP_TIME
REAL #FLUX_DRIP_ANGLE
REAL #FLUX_DIP_SPEED_IN
REAL #FLUX_DIP_SPEED_OUT
REAL #FLUX_DIP_DEPTH
(***********************************************************)
REAL #PREHEAT_HEIGHT
(***********************************************************)
REAL #SOLDER_HEIGHT
REAL #ANGLE_OVER_WAVE
REAL #SOLDER_POSITION
(***********************************************************)
STRING #WASH_TYPE
STRING #WASH_USED
REAL #WASH_HEIGHT
REAL #NUMBER_OF_WASH_SHAKES
REAL #WASH_TIME
REAL #WASH_DRIP_TIME
REAL #WASH_DRIP_ANGLE
REAL #WASH_SPEED_IN
REAL #WASH_SPEED_OUT
(***********************************************************)
STRING #DRY_TYPE
STRING #DRY_USED
REAL #DRY_HEIGHT
REAL #NUMBER_OF_DRY_SHAKES
REAL #DRY_TIME
(***********************************************************)

(********************** OPERATOR ENTER PARAMETERS HERE ***********************)

(***********************************************************)
#FLUX_HEIGHT= -97.0		 (SET THE BOTTOM OF THE LEAD TO JUST TOUCH THE SURFACE OF THE FLUX
#FLUX_TIME= 0.5            (TIME IN FLUX)
#FLUX_DRIP_TIME= 3     (TIME TO DRIP OFF FLUX)
#FLUX_DRIP_ANGLE= 40    (ANGLE TO DRIP OFF FLUX)
#FLUX_DIP_SPEED_IN= 2000
#FLUX_DIP_SPEED_OUT= 6000
#FLUX_DIP_DEPTH= 1        (HOW DEEP TO GO INTO THE FLUX)

(***********************************************************)
#PREHEAT_HEIGHT= -65 + #PART_THICKNESS

(***********************************************************)
#PALLETWIDTH= 145 (PALLET WIDTH IS NEGATIVE TO ACCOUNT FOR TRAVEL DIRECTION)
#SOLDER_HEIGHT= -68 + #PART_THICKNESS (@PUMP = 550 RPM)
#ANGLE_OVER_WAVE= 0
#SOLDER_POSITION= 1209
(***********************************************************)
#WASH_USED= "NO"                (ENTER "YES" OR "NO")
#WASH_TYPE= "WASHSHAKE"         (ENTER "WASH" OR "WASHSHAKE")
#WASH_HEIGHT= -98.0		(SET TO THE DEPTH YOU WANT TO SUBMERGE THE PART IN THE WASH)
#NUMBER_OF_WASH_SHAKES= 50      (IF SHAKE WASH SELECTED)
#WASH_TIME= 10                 (IF STATIONARY WASH SELECTED)
#WASH_DRIP_TIME= 4
#WASH_DRIP_ANGLE= 20
#WASH_SPEED_IN= 4000
#WASH_SPEED_OUT= 6000

(***********************************************************)
#DRY_USED= "NO"                 (ENTER "YES" OR "NO"
#DRY_TYPE= "DRY"           	(ENTER "DRY" OR "DRYSHAKE")
#DRY_HEIGHT= -10		(SET THE HEIGHT THAT GIVES THE BEST COVERAGE FOR THE AIR KNIFE
#NUMBER_OF_DRY_SHAKES= 5
#DRY_TIME= 2
(***********************************************************)

(*********************** END OF OPERATOR DATA INPUT ***************************)

M98 PPARTLOAD

IF #FLUX_USED= TRUE THEN
M98 PFLUX		(MOVE TOOL HEAD TO FLUX POSITION AND DIP)
ENDIF

IF #PREHEAT_USED= TRUE THEN
M98 PPREHEAT		(MOVE TO PREHEAT POSITION AND PREHEAT
ENDIF

M98 PPUMPSTART                 (START SOLDER PUMP)
M98 PSOLDERDIP		 	(MOVE TOOL HEAD TO SOLDER POT POSITION AND DIP)

IF #WASH_USED= "YES" THEN
M98 PPARTWASH			(MOVE TO WASH STATION AND WASH)
ENDIF

IF #DRY_USED= "YES" THEN
M98 PPARTDRY			(TURN ON AIR KNIFE FOR DRY ASSIST)
ENDIF

M98 PPARTUNLOAD			(MOVE TO UNLOAD POSITION)
G56
M98 PUNLOAD
M30 (END PROGRAM AND RESET)
