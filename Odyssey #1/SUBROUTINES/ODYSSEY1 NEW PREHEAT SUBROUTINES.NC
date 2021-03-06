(**********************************************************)
OPARTPREHEATROTARY
G01 A0 F2880
G01 Z-5 F2000 (MOVE TO PREHEAT STATION)
IF #NUMBER_HEADS=8 THEN
G01 X#PRE_HEAT_OFFSET F20000
ELSE
G01 X#PRE_HEAT_OFFSET-127 F20000 (127 IS THE DISTANCE BETWEEN THE TWO ROWS OF NOZZLES)
ENDIF

IF #SOLDER_TYPE= "LEADDRAG" THEN
M98 PPUMP1START
M34
G04 P3.0
ELSE
M98 PPUMP2START
G04 P3.0
M41
ENDIF

IF #PRE_HEAT_USED= "YES" THEN
G01 Z#PRE_HEAT_HEIGHT F6000    (MOVE TO PREHEAT HEIGHT
M12 (BLOWER POWER ON)
M10 (PRE-HEATER POWER ON)
M00 P0 (WAITS AT PRE-HEATER UNTIL THE IR SENSOR REACHES SET POINT)
M11 (PRE-HEATER POWER OFF)
M13 (BLOWER POWER OFF)
G01 Z-5 F6000 (RETURN TO PROCESS POSITION)
ENDIF

M99

(**********************************************************)

OLOAD
G30 P2	 (NEAR HOME)
G27	       (SEEK HOME)
G01 X100 Y0 F20000
M99

(**********************************************************)

OPARTLOAD
G58
G01 A0 F1080
G01 X100  Z-5 F20000              (MOVE TO LOAD STATION, Z UP)
M00 P0     (wait for cycle start)
M99 (END FUNCTION)

(**********************************************************)

OLEADDRAG 
G01 A0 F1080				
G01 X#SOLDER_POSITION_PB Z-5 F20000
G01 A#ANGLE_OVER_WAVE_PB F1080              	(ROTATE HEAD TO PROCESS ANGLE
G01 Z#SOLDER_HEIGHT_PB F4000		 	(MOVE TO Z HEIGHT FOR PROCESS
G04 P0.5				 	(DWELL
M98 PANGLECALCOPERATOR_PB			(CALCULATE ANGLE OF EXTRACTION	
G01 Z-5 F4000 				 	(RETURN TO PROCESS POSITION
G01 A0 F1080
M17 M35					 	(TURN OFF PUMP1 AND NITROGEN1)			
M99

(**********************************************************)

OLEADFREEDRAG 
G01 A0 F1080				
G01 X#SOLDER_POSITION_PBF Z-2 F20000
G01 A#ANGLE_OVER_WAVE_PBF F1080              	(ROTATE HEAD TO PROCESS ANGLE
G01 Z#SOLDER_HEIGHT_PBF F4000		 	(MOVE TO Z HEIGHT FOR PROCESS
G04 P0.5				 	(DWELL
M98 PANGLECALCOPERATOR_PBF			(CALCULATE ANGLE OF EXTRACTION	
G01 Z-2 F4000 				 	(RETURN TO PROCESS POSITION
G01 A0 F1080
M19 M42 					(TURN OFF PUMP2 AND NITROGEN2)			
M99

(**********************************************************)

OFLUX1
G01 X838 Z-5 F20000             	(MOVE TO FLUX STATION)(original 845)
G01 Z#FLUX_HEIGHT+5 F4000
G01 Z#FLUX_HEIGHT-#FLUX_DIP_DEPTH F#FLUX_DIP_SPEED_IN            (APPLY FLUX
G04 P#FLUX_DWELL                        (FLUX DWELL
G01 Z#FLUX_HEIGHT+5 F#FLUX_DIP_SPEED_OUT
G01 Z-5 A0 F4000                        (RETURN TO PROCESS POSITION
G01 X785 Z-5 F#FLUX_DIP_SPEED_OUT A#FLUX_DRIP_ANGLE F1080	(DRIP ANGLE
G04 P#FLUX_DRIP_DWELL			(DRIP TIME
G01 Z-5   A0                            (RETURN TO PROCESS POSITION
M99

(**********************************************************)

OFLUX2
G01 X1033 Z-5 F20000            (MOVE TO FLUX STATION)(original 1040)
G01 Z#FLUX_HEIGHT+5 F4000
G01 Z#FLUX_HEIGHT-#FLUX_DIP_DEPTH F#FLUX_DIP_SPEED_IN            (APPLY FLUX
G04 P#FLUX_DWELL                        (FLUX DWELL
G01 Z#FLUX_HEIGHT+5 F#FLUX_DIP_SPEED_OUT
G01 Z-5 A0 F4000                        (RETURN TO PROCESS POSITION
G01 X980 Z-5 F#FLUX_DIP_SPEED_OUT A#FLUX_DRIP_ANGLE F1080	(DRIP ANGLE
G04 P#FLUX_DRIP_DWELL			(DRIP TIME
G01 Z-5   A0                            (RETURN TO PROCESS POSITION
M99

(***********************************************************)

OPUMP1START
G210 P1
M16 M34 S#PUMP1RPM       		(Pump ON, N2 ON)
M99

(***********************************************************)

OPUMP2START
G210 P2
M18 M41 S#PUMP2RPM
M99

(**********************************************************)

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

(**********************************************************)

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

(***********************************************************)

ODRYON
M22 M24                        			(TURN ON AIR KNIFE, PREHEAT)
M99

(***********************************************************)

ODRYOFF
M23 M25                        			(TURN OFF AIR KNIFE, PREHEAT)
M99

(**********************************************************)

OPARTUNLOAD
G58
G01 A0 F1080
G01 X100 Z-5 F20000              	(MOVE TO UNLOAD STATION, Z UP)
M99

(**********************************************************)

OUNLOAD
G04 x1.1
M99

(**********************************************************)

OANGLECALCOPERATOR_PB

#ANGHYP= #PALLETWIDTH/COS[#ANGLE_OVER_WAVE_PB]
#VERTCHANGE= #ANGHYP*SIN[#ANGLE_OVER_WAVE_PB]

G91
G01 X#PALLETWIDTH Z#VERTCHANGE F#SPEED_ACROSS_WAVE_PB
G90
M99

(***********************************************************)

OANGLECALCOPERATOR_PBF

#ANGHYP= #PALLETWIDTH/COS[#ANGLE_OVER_WAVE_PBF]
#VERTCHANGE= #ANGHYP*SIN[#ANGLE_OVER_WAVE_PBF]

G91
G01 X#PALLETWIDTH Z#VERTCHANGE F#SPEED_ACROSS_WAVE_PBF
G90
M99

(***********************************************************)