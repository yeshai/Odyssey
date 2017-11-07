(********************** OPERATOR ENTER PARAMETERS HERE ***********************)

#FLUX_HEIGHT= -96.0		          (SET SO PINS/PADS TOUCH FLUX-SURFACE)
#FLUX_DWELL= 0.5
#FLUX_DRIP_DWELL= 2
#FLUX_DRIP_ANGLE= 35
#FLUX_DIP_SPEED_IN= 2000
#FLUX_DIP_SPEED_OUT= 6000
#FLUX_DIP_DEPTH= 1

(*****************************************************************************)
#PREHEAT_USED= "YES" 	        (ENTER "YES" OR "NO")
(#PREHEAT POSITION = 620 - SET IN SUBROUTINE)
#PREHEAT_HEIGHT= -70
#PREHEAT_DWELL= 40
(*****************************************************************************)

#SOLDER_POT_CHOICE= "LEADDRAG"  (LEAD 63/37 POT)
#SOLDER_POSITION_PB= 1623       (LEAD SOLDER POT X-POSITION)
#SOLDER_HEIGHT_PB= -62.9        (LEAD SOLDER POT NOZZLE HEIGHT, Z-POSITION)
#SPEED_ACROSS_WAVE_PB= 600      (SPEED ACROSS LEAD SOLDER WAVE)
#ANGLE_OVER_WAVE_PB= 0          (ANGLE OVER LEAD SOLDER WAVE)

#SOLDER_POSITION_PBF= 1909.4    (LEAD-FREE SOLDER POT X-POSITION)
#SOLDER_HEIGHT_PBF= -67         (LEAD-FREE SOLDER POT NOZZLE HEIGHT, Z-POSITION)
#SPEED_ACROSS_WAVE_PBF= 1000    (SPEED ACROSS LEAD-FREE SOLDER WAVE)
#ANGLE_OVER_WAVE_PBF= 0         (ANGLE OVER LEAD-FREE SOLDER WAVE)
#PALLETWIDTH= 150              	(LOWER PALLETWIDTH ALLOWS FOR HIGHER DRAG ANGLE)
(************************* END OF OPERATOR DATA INPUT ************************)

M98 PPARTLOAD
G01 X100 Z-5 F4000              (MOVE TOOL HEAD INTO LOAD POSITION)

IF #FLUX_USED= "YES" THEN
M98 P#FLUX_POT_CHOICE		        (MOVE TO FLUX POSITION)
ENDIF

M98 PPARTPREHEAT		            (MOVE TO PREHEAT POSITION AND TURN ON SOLDER PUMP)

M98 PLEADDRAG		 	              (MOVE TO SOLDER POT AND DIP)

M98 PPARTUNLOAD			            (MOVE TO PART UNLOAD POSITION, X=100)

G56                             (SET PROGRAM ZERO AND FIXTURE OFFSETS)
M98 PUNLOAD                     (MOVE TO X-POSITION = 1.1)
M30.1                           (END PROGRAM, RESE AND RESTART)
