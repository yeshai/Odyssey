#R:\Manufacturing\Robotic Solder\Odyssey Programs\Odyssey #1\SUBROUTINES\ODYSSEY1 SUBROUTINES.nc
M98 PLOAD (START LOAD ROUTING)
G52 X0 Y0 Z0  (SET CALIBRATION OFFSETS)

(****************************** DECLARE VARIABLES HERE ****************************)
REAL #ANGHYP
REAL #VERTCHANGE
REAL #PALLETWIDTH
(***********************************************************************************)
STRING #FLUX_USED
REAL #FLUX_HEIGHT
REAL #FLUX_DWELL
REAL #FLUX_DRIP_DWELL
REAL #FLUX_DRIP_ANGLE
REAL #FLUX_DIP_SPEED_IN
REAL #FLUX_DIP_SPEED_OUT
REAL #FLUX_DIP_DEPTH

(***********************************************************************************)
STRING #PREHEAT_USED
REAL #PREHEAT_POSITION
REAL #PREHEAT_HEIGHT
REAL #PREHEAT_DWELL

(***********************************************************************************)
STRING #SOLDER_POT_CHOICE
REAL #SOLDER_HEIGHT
REAL #SPEED_OVER_WAVE
REAL #ANGLE_OVER_WAVE
REAL #SOLDER_POSITION

(***********************************************************************************)
STRING #WASH_TYPE
STRING #WASH_USED
REAL #WASH_HEIGHT
REAL #NUMBER_OF_WASH_SHAKES
REAL #WASH_DWELL
REAL #WASH_DRIP_DWELL
REAL #WASH_DRIP_ANGLE
REAL #WASH_SPEED_IN
REAL #WASH_SPEED_OUT

(***********************************************************************************)
STRING #DRY_TYPE
STRING #DRY_USED
REAL #DRY_HEIGHT
REAL #NUMBER_OF_DRY_SHAKES
REAL #DRY_DWELL

(******************************** SET PARAMETER HERE *******************************)
#FLUX_USED= "YES" 	                (ENTER "YES" OR "NO")
#FLUX_HEIGHT= -96.0 		            (SET SO PINS/PADS TOUCH FLUX-SURFACE)
#FLUX_DWELL= 0.5
#FLUX_DRIP_DWELL= 2
#FLUX_DRIP_ANGLE= 35
#FLUX_DIP_SPEED_IN= 2000
#FLUX_DIP_SPEED_OUT= 6000
#FLUX_DIP_DEPTH= 1

(***********************************************************************************)
#PREHEAT_USED= "YES" 	              (ENTER "YES" OR "NO")
#PREHEAT_POSITION = 615
#PREHEAT_HEIGHT= -90
#PREHEAT_DWELL= 60

(***********************************************************************************)
#SOLDER_POT_CHOICE= "LEADFREEDRAG"  (LEAD-FREE SAC305 POT)
#SOLDER_HEIGHT = -81.5            (LEAD-FREE SOLDER POT NOZZLE HEIGHT, Z-POSITION)
#SPEED_OVER_WAVE= 275        (SPEED ACROSS LEAD-FREE SOLDER WAVE)
#SOLDER_POSITION = 1930         (BAR EDGE ~= WAVE START)
#ANGLE_OVER_WAVE = 0             (LEAD-FREE SOLDER POT X-POSITION)
#PALLETWIDTH= 150             	    (LOWER PALLETWIDTH ALLOWS FOR HIGHER DRAG ANGLE)

(***********************************************************************************)
#WASH_USED= "NO" (ENTER "YES" OR "NO"
#WASH_TYPE= "WASHSHAKE"             (ENTER "WASH" OR "WASHSHAKE")
#WASH_HEIGHT= -103.0		            (SET SO PINS/PADS TOUCH WASH-SURFACE)
#NUMBER_OF_WASH_SHAKES= 30          (IF SHAKE WASH SELECTED)
#WASH_DWELL= 10                     (IF STATIONARY WASH SELECTED)
#WASH_DRIP_DWELL= 4
#WASH_DRIP_ANGLE= 20
#WASH_SPEED_IN= 4000
#WASH_SPEED_OUT= 6000

(***********************************************************************************)
#DRY_USED= "NO"                     (ENTER "YES" OR "NO")
#DRY_TYPE= "DRY"           	        (ENTER "DRY" OR "DRYSHAKE")
#DRY_HEIGHT= -10		                (SET HEIGHT BEST COVERAGE)
#NUMBER_OF_DRY_SHAKES= 5
#DRY_DWELL= 2

(******************************* ROBOTIC OPPERATION ********************************)

M98 PPARTLOAD
G01 X100 Z-5 F4000            	    (MOVE TOOL HEAD INTO LOAD POSITION)

IF #FLUX_USED= "YES" THEN
M98 PFLUX	                          (MOVE TO FLUX POSITION)
ENDIF

IF #PREHEAT_USED= "YES" THEN
M98 PPREHEAT		                    (MOVE TO PREHEAT POSITION)
ENDIF

M98 PPUMP2START                     (TURN ON SOLDER PUMP)
M98 PLEADFREEDRAG		 	              (MOVE TO SOLDER POT AND DIP)

IF #WASH_USED= "YES" THEN
M98 PPARTWASH			                  (MOVE TO WASH STATION AND WASH)
ENDIF

IF #DRY_USED= "YES" THEN
M98 PPARTDRY			                  (TURN ON AIR KNIFE)
ENDIF

M98 PSOLDERPUMPSTOP                 (TURN OFF SOLDER PUMP)

M98 PPARTUNLOAD                     (MOVE TO PART UNLOAD POSITION, X=100)
G56                                 (SET PROGRAM ZERO AND FIXTURE OFFSETS)
M98 PUNLOAD                         (MOVE TO UNLOAD POSITION, X=1.1)
M30                                 (END PROGRAM, RESET)
