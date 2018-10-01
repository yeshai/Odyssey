#C:\MaestroLite Data\MICROSS SUB UTILITIES ODYSSEY.nc
(M98 PPUMP1START
(M98 PLOAD
(Initialization Complete )
G52 X0 Y0 Z0  (Calibration Offsets)
(*********************** SET VARIABLES*********************

REAL #ddz		(dip depth 
REAL #ddx
REAL #sd		(side dip
REAL #dt		(dwell time
REAL #a                 (angle 
REAL #h
REAL #p           (rise %
 
( ********************** MAIN G-CODE *********************** 


#ddz = 38
#sd  = 5.0
#dt  = .5
#a   = -14
#p   = 1
#ddx = #ddz*TAN[#a]

#h = #ddz/sin[90-#a]
#ddx = #h*cos[90+#a]

 
M98 PPARTLOAD                           (MOVE GRIPPER INTO LOAD POSITION)
G01 Z-5 F10000                          (Z DOWN FOR PART PICKUP)                           (CLOSE GRIPPER JAWS AND SECURE PARTS)
G01 Z-5 F10000                          (RETURN TO PROCESS POSITION)

(M98 PPARTFLUX1
(G01 Z-79.2 F10000                          (APPLY FLUX)
(G04 P2                                  (FLUX DWELL)
(G01 Z-5                                 (RETURN TO PROCESS POSITION)

                               (RETURN TO PROCESS POSITION)

M98 PPUMP1START

G01 X1550 Z-5
G01 X1670 
G01 X1589 Z-80 A-#a
G91
G01 Z-#ddz F900                          (APPLY NEW ALLOY)
G04 P90
G01 X-#sd F1000   
G04 P#dt
G01 X-[#p*#ddx] Z[#p*#ddz] F300

G90

                              (SOLDER DWELL)
M98 PSOLDERPUMPSTOP

G01 A90 F30000
G04 P10

G01 Z-5 F6000                           (RETURN TO PROCESS POSITION)

(M98 PWASHON
(M98 PPARTWASH
(G01 Z-5 F10000                          (WASH PART)
(M98 PWASHSHAKE L10  
(G01 Z-5 F10000                           (RETURN TO PROCESS POSITION)
(M98 PWASHOFF                           

(M98 PDRYON
(M98 PPARTDRY
(G01 Z-50 F10000
(G04 P5
(G01 Z-5
(M98 PDRYOFF

M98 PPARTUNLOAD 

G56
M98 PUNLOAD
M30.1
 
