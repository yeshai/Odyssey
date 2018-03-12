(***********************************************************)
OLOAD
M98 PLIGHT_ALL_OFF (TURN LIGHTS OFF)
M21                 (DROSS WIPER UP)
M23                 (AIR KNIFE DOWN)
(G58                (SET PROGRAM 0, FIXTURE OFFSET)
(G30 P3            (SEEK FIXTURE 0, REFERENCE POINT)
G30 P2              (NEAR HOME)
G27                 (SEEK HOME)
G01 A0 F2880
M98 PLIGHT_GREEN_ON (TURN GREEN LIGHT ON)
M99
(***********************************************************)
OFLUX
(M37 (FLUX PUMP ON)
G01 X808 Z-5 F20000               (MOVE TO FLUX STATION @ X=808)
G01 Z#FLUX_HEIGHT+5 F4000
G01 Z#FLUX_HEIGHT-#FLUX_DIP_DEPTH F#FLUX_DIP_SPEED_IN            (APPLY FLUX)
G04 P#FLUX_TIME                        (FLUX TIME
G01 Z#FLUX_HEIGHT+5 F#FLUX_DIP_SPEED_OUT
G01 Z-5 A0 F4000                        (RETURN TO PROCESS POSITION)
G01 X785 Z-5 F#FLUX_DIP_SPEED_OUT A#FLUX_DRIP_ANGLE F1080 (DRIP ANGLE)
G04 P#FLUX_DRIP_TIME     (DRIP TIME
G01 Z-5   A0                            (RETURN TO PROCESS POSITION)
(M38  (FLUX PUMP OFF) 
M99
(***********************************************************)
OPREHEAT
G01 X570 Z-5 F20000               (MOVE TO PREHEAT STATION @ X=570)
G01 Z#PREHEAT_HEIGHT F4000    (LOWER HEAD)
G04 P#PREHEAT_TIME                   (WAIT AT PREHEAT)
G01 Z-5                                  (RETURN TO PROCESS POSITION)
M99
(***********************************************************)
OPREHEAT2
G01 X520 Z-5 F20000               (MOVE TO PREHEAT STATION @ X=570)
G01 Z#PREHEAT_HEIGHT F4000    (LOWER HEAD)
G04 P#PREHEAT_TIME                   (WAIT AT PREHEAT)
G01 Z-5                                  (RETURN TO PROCESS POSITION)
M99
(***********************************************************)
OPUMPSTART
G210 P1
M16 M34 S#PUMP1RPM          (Pump ON, N2 ON)
(M16 M34 S100         (Pump ON, N2 ON)
M99
(***********************************************************)
OSOLDERDIP
G01 A0 F1080
G30 P6 (GO TO SOLDER REFERENCE PT.)
(G01 X#SOLDER_POSITION Z-5 F20000 (UPDATED TO REFERENCE PT.))
G01 A#ANGLE_OVER_WAVE F1080                (ROTATE HEAD TO PROCESS ANGLE)
G01 Z#SOLDER_HEIGHT F4000      (MOVE TO Z HEIGHT FOR PROCESS)
IF #PREHEAT_USED= FALSE THEN  (IF IR PREHEAT USED DON'T PREHEAT OFF WAVE)
G04 P#PREHEAT_TIME          (PAUSE TIME)
ENDIF
M98 PANGLECALCOPERATOR_     (CALCULATE ANGLE OF EXTRACTION)
G01 Z-5 F4000           (RETURN TO PROCESS POSITION)
G01 A0 F1080
M17 M35           (TURN OFF PUMP1 AND NITROGEN1)
M99
(***********************************************************)
OSOLDERDIP2
G01 A0 F1080
G01 X1200 F20000

G01 A#ANGLE_OVER_WAVE F1080                (ROTATE HEAD TO PROCESS ANGLE)
G01 Z#SOLDER_HEIGHT F4000      (MOVE TO Z HEIGHT FOR PROCESS)
G91
G01 X5  F#SPEED_ACROSS_WAVE
G04 P2.0 (WAIT IN SOLDER)
G01 X-8 F#SPEED_ACROSS_WAVE
G04 P1.0 (WAIT AFTER DIP)
G90
G01 Z-5 F4000           (RETURN TO PROCESS POSITION)
G01 A0 F1080
M17 M35           (TURN OFF PUMP1 AND NITROGEN1)
M99
(***********************************************************)
OPARTWASH
G01 Z-5 F4000
G01 X385 F10000
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
OANGLECALCOPERATOR_
#ANGHYP= #PALLETWIDTH/COS[#ANGLE_OVER_WAVE]
#VERTCHANGE= #ANGHYP*SIN[#ANGLE_OVER_WAVE]
G91
G01 X#PALLETWIDTH Z#VERTCHANGE F#SPEED_ACROSS_WAVE
G90
M99
(******************  VACCUUM ROUTINES  *********************)
OPARTLOADROTARY
G59
M43
G04 P2.0
M32     (TURN VACUUM PUMP ON)
G04 P1.0
M44
G01 A0 F5000
(G01 X5 Z-5 F10000  (normally not skipped
G92 B0
(M00 "ENSURE DROSS WIPER AND AIRKNIFE SLIDE ARE CLOSED"
M99
(***********************************************************)
OPARTPREHEATROTARY
G01 A0 F2880
G01 Z-5 F2000 (MOVE TO PREHEAT STATION)
G01 X585 F10000         (default 585 FRONT NOZZLES 520)
M99
(***********************************************************)
OROTARYDSPWAVERIGHTLEAD
G01 A0 F2880
G01 X1570 Z-5 F10000 (MOVE TO STRIPPING STATION)
(G01 Z-50 F2500       (z-65
M99
(***********************************************************)
OROTARYPARTUNLOAD
G59
G01 A0 F1080   (ROTATE HEAD TO UNLOAD POSITION)
G01 X230 Z-5 F10000  (MOVE TO UNLOAD STATION, Z UP)
M99
