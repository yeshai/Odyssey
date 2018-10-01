OPUMPSTART
INTEGER #PUMPBASERPM
#PUMPBASERPM=665


M26 M10 S#PUMPBASERPM (Pump ON, N2 ON)
M99

OPUMPSTOP
M27 M11      (Pump OFF, N2 OFF)
M99

OPUMPPURGE
S690
G04 X3
M98 PPUMPSTART
M99

OFLUXSTARTUP
G56(Enable Zero Offset)
G01 Z0 F4000  (Z DOWN)
M28(FLUX SLIDE UP)
M12(BOTTLE PRESSURE ON)
M14(ATOMIZER ON)
M99

OFLUXSHUTDOWN
M29(FLUX SLIDE DOWN)
M15(ATOMIZER OFF)
M13 (BOTTLE PRESSURE OFF)
G56(Enable Zero Offset)
G01 Z1 F4000  (Z DOWN)
M99

OJETFLUXSTARTUP
G56(Enable Zero Offset)
G01 Z0 F4000  (Z DOWN)
M28(FLUX SLIDE UP)
M12(BOTTLE PRESSURE ON)
M99

OJETFLUXSHUTDOWN
M29(FLUX SLIDE DOWN)
M15(ATOMIZER OFF)
M13(BOTTLE PRESSURE OFF)
G56(Enable Zero Offset)
G01 Z0 F4000  (Z DOWN)
M99

OLOAD
M98 PLIGHT_ALL_OFF
M98 PLIGHT_GREEN_FLASH
M98 PFLUXSHUTDOWN
G30 P2	 (NEAR HOME)
G27	       (SEEK HOME)
(G01 X100 Y75
(M101 I9 (WAIT FOR N2 Heat Present)
(M00 P0   (wait for cycle start
(M00 "READY FOR PROCESS")
(M101 I5 (WAIT FOR CONVEYOR BOARD READY)
M98 PLIGHT_ALL_OFF
M98 PLIGHT_GREEN_ON
M99

OUNLOAD
M98 PLIGHT_ALL_OFF
M98 PLIGHT_GREEN_FLASH
M32 (BOARD DONE ON)
G04 x1.1
M33 (BOARD DONE OFF)
M98 PLIGHT_ALL_OFF
M99

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
M33
M35
M99

OLIGHT_RED_ON
M18
M99

OLIGHT_YELLOW_ON
M20
M99

OLIGHT_GREEN_ON
M22
M99

OLIGHT_RED_FLASH
M18
M22
M99

OLIGHT_YELLOW_FLASH
M18
M20
M99

OLIGHT_GREEN_FLASH
M20
M22
M99

OLIGHT_CYCLE
M18
M20
M22
M99

OLIGHT_ALL_OFF
M19
M21
M23
M99
