(***********************************************************)
OLOAD
M98 PLIGHT_ALL_OFF (TURN LIGHTS OFF)
M21                 (DROSS WIPER UP)
M23                 (AIR KNIFE DOWN)
G58                 (SET PROGRAM 0, FIXTURE OFFSET)
G30 P3            (SEEK FIXTURE 0, REFERENCE POINT)
G27                 (SEEK HOME)
G01 A0 F2880
M98 PLIGHT_GREEN_ON (TURN GREEN LIGHT ON)
M99
(***********************************************************)
OFLUX
G01 X808 Z-5 F20000               (MOVE TO FLUX STATION @ X=808)
G01 Z#FLUX_HEIGHT+5 F4000
G01 Z#FLUX_HEIGHT-#FLUX_DIP_DEPTH F#FLUX_DIP_SPEED_IN            (APPLY FLUX
G04 P#FLUX_DWELL                        (FLUX DWELL
G01 Z#FLUX_HEIGHT+5 F#FLUX_DIP_SPEED_OUT
G01 Z-5 A0 F4000                        (RETURN TO PROCESS POSITION
G01 X785 Z-5 F#FLUX_DIP_SPEED_OUT A#FLUX_DRIP_ANGLE F1080 (DRIP ANGLE
G04 P#FLUX_DRIP_DWELL     (DRIP TIME
G01 Z-5   A0                            (RETURN TO PROCESS POSITION
M99
(***********************************************************)
OPREHEAT
G01 X570 Z-5 F20000               (MOVE TO PREHEAT STATION @ X=570)
G01 Z#PREHEAT_HEIGHT F4000    (LOWER HEAD)
G04 P#PREHEAT_DWELL                   (WAIT AT PREHEAT)
G01 Z-5                                  (RETURN TO PROCESS POSITION)
M99
(***********************************************************)
OSOLDERDIP
G01 A0 F1080
G01 X#SOLDER_POSITION_PB Z-5 F20000
G01 A#ANGLE_OVER_WAVE_PB F1080                (ROTATE HEAD TO PROCESS ANGLE
G01 Z#SOLDER_HEIGHT_PB F4000      (MOVE TO Z HEIGHT FOR PROCESS
G04 P0.5          (DWELL
M98 PANGLECALCOPERATOR_PB     (CALCULATE ANGLE OF EXTRACTION
G01 Z-5 F4000           (RETURN TO PROCESS POSITION
G01 A0 F1080
M17 M35           (TURN OFF PUMP1 AND NITROGEN1)
M99
(***********************************************************)
OPARTWASH
G01 X377 Z-5 F20000
G01 Z#WASH_HEIGHT F#WASH_SPEED_IN             (WASH PART)
IF #WASH_TYPE= "WASHSHAKE" THEN
M98 PWASHSHAKE L#NUMBER_OF_WASH_SHAKES
ELSE
G04 P#WASH_DWELL
ENDIF
G01 Z-5 A0 F#WASH_SPEED_OUT                   (RETURN TO PROCESS POSITION
G01 Z-5 A#WASH_DRIP_ANGLE F1080     (DRIP ANGLE
G04 P#WASH_DRIP_DWELL       (DRIP TIME
G01 Z-5 A0 F4000                          (RETURN TO PROCESS POSITION
M99
(***********************************************************)
OWASHSHAKE
G01 X420 F8000
G01 X424
M99
(***********************************************************)
OPARTLOAD
G58
G01 A0 F1080
G01 X100  Z-5 F20000              (MOVE TO LOAD STATION, Z UP)
M99
(***********************************************************)
OPARTUNLOAD
G58
G01 A0 F1080
G01 X100 Z-5 F20000               (MOVE TO UNLOAD STATION, Z UP)
M99
(***********************************************************)
OUNLOAD
M98 PLIGHT_ALL_OFF
G04 x1.1
M98 PLIGHT_ALL_OFF
M99
(***********************************************************)
OLIGHT_ALL_OFF
M11
M15
M99
(***********************************************************)
OLIGHT_RED_ON
M10
M99
(***********************************************************)
OLIGHT_GREEN_ON
M14
M99
(***********************************************************)
OANGLECALCOPERATOR_PB
#ANGHYP= #PALLETWIDTH/COS[#ANGLE_OVER_WAVE_PB]
#VERTCHANGE= #ANGHYP*SIN[#ANGLE_OVER_WAVE_PB]
G91
G01 X#PALLETWIDTH Z#VERTCHANGE F#SPEED_ACROSS_WAVE_PB
G90
M99
(***********************************************************)
