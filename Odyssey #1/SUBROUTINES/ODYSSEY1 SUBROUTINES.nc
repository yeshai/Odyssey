(***********************************************************)
OLOAD
M98 PLIGHT_ALL_OFF (TURN LIGHTS OFF)
M21               (DROSS WIPER UP)
M23               (AIR KNIFE DOWN)
G30 P2            (NEAR HOME)
G27                 (SEEK HOME)
G01 X15 Z-5 F2000
G58
G01 A0 F2880
M00 P0              (wait for cycle start)
M98 PLIGHT_ALL_OFF
M98 PLIGHT_GREEN_ON
M99
(***********************************************************)
OPARTLOAD
G58
G01 A0 F1080
G01 X100  Z-5 F20000              (MOVE TO LOAD STATION, Z UP)
M99
(***********************************************************)
OFLUXPUMPSTART
M29                               (START FLUX PUMP)
M99
(***********************************************************)
OFLUX
G01 X838 Z-5 F20000               (MOVE TO FLUX STATION)
G01 Z#FLUX_HEIGHT+5 F4000
G01 Z#FLUX_HEIGHT-#FLUX_DIP_DEPTH F#FLUX_DIP_SPEED_IN            (APPLY FLUX
G04 P#FLUX_DWELL                        (FLUX DWELL
G01 Z#FLUX_HEIGHT+5 F#FLUX_DIP_SPEED_OUT
G01 Z-5 A0 F4000                        (RETURN TO PROCESS POSITION
G01 X785 Z-5 F#FLUX_DIP_SPEED_OUT A#FLUX_DRIP_ANGLE F1080 (DRIP ANGLE
G04 P#FLUX_DRIP_DWELL     (DRIP TIME
G01 X785 Z-5 F#FLUX_DIP_SPEED_OUT A[-1*#FLUX_DRIP_ANGLE] F1080 (-DRIP ANGLE
G04 P#FLUX_DRIP_DWELL     (DRIP TIME
G01 Z-5   A0                            (RETURN TO PROCESS POSITION
M99
(***********************************************************)
OFLUXPUMPSTOP
M30                               (STOP FLUX PUMP)
M99
(***********************************************************)
OPREHEAT
G01 X#PREHEAT_POSITION Z-5 F20000               (MOVE TO PREHEAT STATION)
G01 Z#PREHEAT_HEIGHT F4000
G04 P#PREHEAT_DWELL                      (PREHEAT DWELL
G01 Z-5                                  (RETURN TO PROCESS POSITION
M99
(***********************************************************)
OPUMP1START
G210 P1
M16 M34 S#PUMP1RPM       		(Pump ON, N2 ON)
M99
(***********************************************************
OPUMP2START
G210 P2
M18 M41 S#PUMP2RPM
M99
(***********************************************************
OSOLDERPUMPSTOP
M17 M19 						(Pump 1 Pump 2 OFF)
M35 m42                       	 (N2 1 2 OFF)
M99
(***********************************************************
OPARTUNLOAD
G58
G01 A0 F1080
G01 X100 Z-5 F20000              	(MOVE TO UNLOAD STATION, Z UP)
M99

(***********************************************************

OLEAD
G01 X1365 Z-5 F20000 			(MOVE TO DIP STATION)
M20
G04 P1 					(DROSS WIPER DOWN)
G01 X1600 Z-5 F2000			(WIPE DROSS LEFT TO RIGHT)
M21 					(DROSS WIPER UP)
G01 X1651 Z-5 				(CENTER TOOL OVER NOZZLE)
G01 Z#SOLDER_HEIGHT+5 F4000
G01 Z#SOLDER_HEIGHT-#SOLDER_DIP_DEPTH F#SOLDER_DIP_SPEED_IN
G04 P#SOLDER_DWELL
G01 Z#SOLDER_HEIGHT+5 F#SOLDER_DIP_SPEED_OUT
G01 Z-5 F4000
M17 M35					 (TURN OFF PUMP1 AND NITROGEN1)
M99

(***********************************************************

OLEADDRAG
G01 A0 F1080
(SOLDER_POSITION = 1620
#CENTER = #CENTER - #SOLDER_HEIGHT (RECALCUATE BASED ON DISTANCE)
#XCHANGE = #CENTER*SIN[#ANGLE_OVER_WAVE]
#ZCHANGE = #CENTER - #CENTER*COS[#ANGLE_OVER_WAVE]
#SOLDER_POSITION = #SOLDER_POSITION - #XCHANGE
#SOLDER_HEIGHT = #SOLDER_HEIGHT - #ZCHANGE
G01 X#SOLDER_POSITION Z-5 F20000
G01 A#ANGLE_OVER_WAVE F1080              	(ROTATE HEAD TO PROCESS ANGLE)
G01 Z#SOLDER_HEIGHT F4000		 	(MOVE TO Z HEIGHT FOR PROCESS
G04 P0.5				 	(DWELL
M98 PANGLECALCOPERATOR			(CALCULATE ANGLE OF EXTRACTION
G01 Z-5 F4000 				 	(RETURN TO PROCESS POSITION
G01 A0 F1080
M17 M35					 	(TURN OFF PUMP1 AND NITROGEN1)
M99

(***********************************************************

OLEADSIDE
G01 A0 F1080
G01 X#SOLDER_POSITION Z-5 F20000
G01 Z#SOLDER_HEIGHT F4000		 	(MOVE TO Z HEIGHT FOR PROCES
G91 (SWITCH TO RELAVTIVE COORDINATES)
G01 X5  F#SPEED_ACROSS_WAVE
G04 P2.0 (WAIT IN SOLDER)
G01 A-10  F600
G01 A10 X-8 F#SPEED_ACROSS_WAVE
G04 P1.5 (WAIT AFTER DIP)
G90 (SWITCH TO ABSOLUTE COORDINATES)
G01 Z-5 F4000 				 	(RETURN TO PROCESS POSITION
G01 A0 F1080
M17 M35					 	(TURN OFF PUMP1 AND NITROGEN1)
M99

(***********************************************************

OLEADFREEDRAG
G01 A0 F1080
(SOLDER_POSITION = 1850
G01 X#SOLDER_POSITION Z-2 F20000
G01 A#ANGLE_OVER_WAVE F1080              	(ROTATE HEAD TO PROCESS ANGLE
G01 Z#SOLDER_HEIGHT F4000		 	(MOVE TO Z HEIGHT FOR PROCESS
G04 P0.5				 	(DWELL
M98 PANGLECALCOPERATOR_PBF			(CALCULATE ANGLE OF EXTRACTION
G01 Z-2 F4000 				 	(RETURN TO PROCESS POSITION
G01 A0 F1080
M19 M42 					(TURN OFF PUMP2 AND NITROGEN2)
M99

(***********************************************************

OLEADFREE
G01 X1750 Z-5 F20000             		(MOVE TO DIP STATION)
M20                            			(DROSS WIPER DOWN)
G04 P1
G01 X1969 Z-5   F2000               		(WIPE DROSS LEFT TO RIGHT)
M21                            			(DROSS WIPER UP)
G01 X2029 Z-5                 			(CENTER TOOL OVER NOZZLE)
G01 Z#SOLDER_HEIGHT+5 F4000
G01 Z#SOLDER_HEIGHT-#SOLDER_DIP_DEPTH F#SOLDER_DIP_SPEED_IN
G04 P#SOLDER_DWELL
G01 Z#SOLDER_HEIGHT+5 F#SOLDER_DIP_SPEED_OUT
G01 Z-5 F4000
M19 M42 					(TURN OFF PUMP2 AND NITROGEN2)
M99

(***********************************************************

OPARTWASH
G01 X415 Z-5 F20000 							(original 422)
G01 Z#WASH_HEIGHT F#WASH_SPEED_IN            	(WASH PART
IF #WASH_TYPE= "WASHSHAKE" THEN
M98 PWASHSHAKE L#NUMBER_OF_WASH_SHAKES
ELSE
G04 P#WASH_DWELL
ENDIF
G01 Z-5 A0 F#WASH_SPEED_OUT                  	(RETURN TO PROCESS POSITION
G01 Z-5 A#WASH_DRIP_ANGLE F1080			(DRIP ANGLE
G04 P#WASH_DRIP_DWELL				(DRIP TIME
G01 Z-5 A0 F4000                        	(RETURN TO PROCESS POSITION
M99

(***********************************************************

OWASHON
M26                            			(TURN ON WASH SOLENOID)
M99

OWASHOFF
M27                            			(TURN OFF WASH SOLENOID)
M99

(***********************************************************

OWASHSHAKE
G01 X420 F8000
G01 X424
M99

(***********************************************************

ODRYSHAKE
G01 Z#DRY_HEIGHT+10 F800
G01 Z#DRY_HEIGHT-10 F800
M99

(***********************************************************

OPARTDRY
G01 X625 Z-5 F20000
M98 PDRYON				 	(MOVE TO DRY STATION AND DRY
G01 Z#DRY_HEIGHT F4000
IF #DRY_TYPE= "DRYSHAKE" THEN
M98 PDRYSHAKE L#NUMBER_OF_DRY_SHAKES
ELSE
G04 P#DRY_DWELL
ENDIF
G01 Z-5 F4000
G01 Z-5
M98 PDRYOFF
M99

(***********************************************************

ODRYON
M22 M24                        			(TURN ON AIR KNIFE, PREHEAT)
M99

(***********************************************************

ODRYOFF
M23 M25                        			(TURN OFF AIR KNIFE, PREHEAT)
M99

(***********************************************************

OUNLOAD
M98 PLIGHT_ALL_OFF
G04 x1.1
M98 PLIGHT_ALL_OFF
M99

(***********************************************************

OALLOFF
M11
M13
M15
M17
M19
M21
M23
M25
M27
M29
M99

(***********************************************************

OLIGHT_RED_ON
M10
M99

(***********************************************************

OLIGHT_GREEN_ON
M14
M99

(***********************************************************

OLIGHT_ALL_OFF
M11
M15
M99

(***********************************************************

OANGLECALCOPERATOR

#ANGHYP= #PALLETWIDTH/COS[#ANGLE_OVER_WAVE]
#VERTCHANGE= #ANGHYP*SIN[#ANGLE_OVER_WAVE]

G91
G01 X#PALLETWIDTH Z#VERTCHANGE F#SPEED_ACROSS_WAVE
G90
M99

(***********************************************************

OANGLECALCOPERATOR_PBF

#ANGHYP= #PALLETWIDTH/COS[#ANGLE_OVER_WAVE]
#VERTCHANGE= #ANGHYP*SIN[#ANGLE_OVER_WAVE]

G91
G01 X#PALLETWIDTH Z#VERTCHANGE F#SPEED_ACROSS_WAVE
G90
M99

(***********************************************************


