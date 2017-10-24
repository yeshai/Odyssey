#R:\Manufacturing\Robotic Solder\Odyssey Programs\Odyssey #1\SUBROUTINES\ODYSSEY1 SUBROUTINES.nc
M98 PLOAD (Turn on dross wiper, airknife and lights. Then, HOME)
(Initialization Complete )
G52 X0 Y0 Z0  (Calibration Offsets)
(*********************** DECLARE VARIABLES*********************)
REAL #ANGHYP
REAL #VERTCHANGE
REAL #PALLETWIDTH
REAL #PREHEAT_HEIGHT
REAL #PREHEAT_TIME
REAL #PH_DISTANCE
REAL #PH_LOCATATION
REAL #SOLDER_HEIGHT
REAL #ANGLE_OVER_WAVE
REAL #SOLDER_POSITION
REAL #PART_THICKNESS
REAL #SPEED_ACROSS_WAVE
(********************** MAIN G-CODE ***********************)
#PREHEAT_TIME = 45
#SPEED_ACROSS_WAVE = 350
#PART_THICKNESS = 1
#PALLETWIDTH= 2 + #PART_THICKNESS
#SOLDER_HEIGHT= -110
#ANGLE_OVER_WAVE= 14
#SOLDER_POSITION= 1867 + #PALLETWIDTH
#PH_DISTANCE  = 7.5  + #PALLETWIDTH (PREHEAT DISTANCE)
#PH_LOCATATION = #SOLDER_POSITION + #PH_DISTANCE
(********************** RECIPE ***********************)

M98 PPARTLOAD      (MOVE TO LOAD POSITION)
G01 Z-5 F10000     (RETURN TO PROCESS POSITION)

M98 PPUMP2START    (START SAC305 PUMP)

G01 A0 F1080
G01 X#PH_LOCATATION Z-5 F20000
G01 A#ANGLE_OVER_WAVE F1080                (ROTATE HEAD TO PROCESS ANGLE)
G01 Z#SOLDER_HEIGHT F4000      (MOVE TO Z HEIGHT FOR PROCESS)
G04 P#PREHEAT_TIME          (PAUSE TIME)

#ANGHYP= #PH_DISTANCE/COS[#ANGLE_OVER_WAVE]
#VERTCHANGE= #ANGHYP*SIN[#ANGLE_OVER_WAVE]
G91
G01 X-#PH_DISTANCE Z#VERTCHANGE F#SPEED_ACROSS_WAVE


G90
G01 Z-5 F1000
G01 A90 F20000
G04 P10
G01 A0 F1080

M98 PSOLDERPUMPSTOP


M98 PPARTUNLOAD

G56
M98 PUNLOAD
M30.1
