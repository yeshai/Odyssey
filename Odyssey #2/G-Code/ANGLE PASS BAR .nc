( ********************** TYPICAL SETTINGS ***********************)
( *************** TEST BAR IN BETWEEN SPACERS *******************)
( ***************** PART THICKNESS [MM] = 2.0  ******************)
( ********************** AUTOFLUX = True  ***********************)
( ********************** FLUX SETTING = 55 **********************)
( ********************** IR PREHEAT = True **********************)
( ********************** PREHEAT TEMP = 400 *********************)
( ********************** PREHEAT TIME [s] = 30 ******************)
( ********************** SOLDER SPEED [mm/s] = 300 **************)
( ********************** SOLDER PUMP [RPM] = 600 ****************)
(****************************************************************)
#R:\Manufacturing\Robotic Solder\Odyssey Programs\Odyssey #2\SUBROUTINES\ODYSSEY2 SUBROUTINES.nc
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

(***********************************************************)

(********************** OPERATOR ENTER PARAMETERS HERE ***********************)

(***********************************************************)
#FLUX_HEIGHT= -76 + #PART_THICKNESS	(LEAD TO JUST TOUCH FLUX)
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
#ANGLE_OVER_WAVE= -45
(#SOLDER_POSITION= 1209 (CHANGED TO REFERENCE PT.) )
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

(****************  SOLDER DIP  ******************)
G01 A0 F1080
G30 P6 (GO TO SOLDER REFERENCE PT.)

G01 A#ANGLE_OVER_WAVE F1080                (ROTATE HEAD TO PROCESS ANGLE)
G01 Z#SOLDER_HEIGHT F4000      (MOVE TO Z HEIGHT FOR PROCESS)
G91 (SWITCH TO RELATIVE COORDINATES)
G01 X20 F#SPEED_ACROSS_WAVE
G90 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z-5 F4000           (RETURN TO PROCESS POSITION)
G01 A0 F1080
M17 
M35           (TURN OFF PUMP1 AND NITROGEN1) 
(***********************************************************)

M98 PPARTUNLOAD	(MOVE TO UNLOAD POSITION)
G56
M98 PUNLOAD
M30 (END PROGRAM AND RESET)
