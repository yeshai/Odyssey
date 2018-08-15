( ********************** TYPICAL SETTINGS ***********************)
( ********************** AUTOFLUX = False ***********************)
( ********************** IR PREHEAT = False *********************)
( ********************** PREHEAT TIME [s] = 60 ******************)
( ********************** SOLDER SPEED [mm/s] = 500 **************)
( ********************** SOLDER PUMP [RPM] = 550 ****************)
(***********************************************************)
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
(STRING #PREHEAT_USED
REAL #PREHEAT_HEIGHT
(REAL #PREHEAT_TIME)
REAL #PH_DISTANCE
REAL #PH_LOCATATION
(***********************************************************)
REAL #SOLDER_HEIGHT
REAL #ANGLE_OVER_WAVE
REAL #SOLDER_POSITION
REAL #EXIT_Z
REAL #EXIT_X
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
(#FLUX_USED= "NO" 	       (ENTER "YES" OR "NO")
#FLUX_HEIGHT= -97.0		 (SET THE BOTTOM OF THE LEAD TO JUST TOUCH THE SURFACE OF THE FLUX
#FLUX_TIME= 0.5            (TIME IN FLUX)
#FLUX_DRIP_TIME= 3     (TIME TO DRIP OFF FLUX)
#FLUX_DRIP_ANGLE= 40    (ANGLE TO DRIP OFF FLUX)
#FLUX_DIP_SPEED_IN= 2000
#FLUX_DIP_SPEED_OUT= 6000
#FLUX_DIP_DEPTH= 1        (HOW DEEP TO GO INTO THE FLUX)

(***********************************************************)
(#PREHEAT_USED= "NO" 	        (ENTER "YES" OR "NO"
#PREHEAT_HEIGHT= -60
(#PREHEAT_TIME= 30)

(***********************************************************)
#PALLETWIDTH= 2 + #PART_THICKNESS
#SOLDER_HEIGHT= -122
#ANGLE_OVER_WAVE= 14
#SOLDER_POSITION= 1184 + #PALLETWIDTH
#PH_DISTANCE  = 7.5  + #PALLETWIDTH (PREHEAT DISTANCE)
#PH_LOCATATION = #SOLDER_POSITION + #PH_DISTANCE
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

(M98 PSOLDERDIP		UPDATE AS FUNCTION! 	)

G01 A0 F1080
G01 X#PH_LOCATATION Z-5 F20000
G01 A#ANGLE_OVER_WAVE F1080                (ROTATE HEAD TO PROCESS ANGLE)
G01 Z#SOLDER_HEIGHT F4000      (MOVE TO Z HEIGHT FOR PROCESS)
G04 P#PREHEAT_TIME          (PAUSE TIME)

(M98 PANGLECALCOPERATOR_  !!UPDATE AS FUNCTION  CALCULATE ANGLE OF EXTRACTION)

#ANGHYP= #PH_DISTANCE/COS[#ANGLE_OVER_WAVE]
#VERTCHANGE= #ANGHYP*SIN[#ANGLE_OVER_WAVE]
#EXIT_Z = 45
#EXIT_X = -0.25*#EXIT_Z 

G91 (INCREMENTAL MODE)
G01 X-#PH_DISTANCE (MOVE IN)
(G04 P0.5 (WAIT IN WAVE)
G01 X#EXIT_X Z#EXIT_Z F#SPEED_ACROSS_WAVE

(G01 X-#PH_DISTANCE Z#VERTCHANGE F#SPEED_ACROSS_WAVE (REMOVED FOR UPDATE)
(G01 Z20 F#SPEED_ACROSS_WAVE (MOVE UP 20mm) (REMOVED FOR UPDATE)

G90 (ABSOLUTE MODE)
G01 A92 F50000(FLIP)
G04 P10
G01 Z-10 F10000
G01 A0 F1080
M17 M35           (TURN OFF PUMP1 AND NITROGEN1)


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
