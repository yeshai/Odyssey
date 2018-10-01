#C:\MaestroLite Data\SUB UTILITIES.nc
M98 PPUMPSTART
M98 PLOAD
(Initialization Complete )
G52 X0 Y0 Z0  (Calibration Offsets)
 
 
( ********************** MAIN G-CODE *********************** 
 
M98 PPARTLOAD
G01 X15 F4000                           (MOVE GRIPPER INTO LOAD POSITION)
G01 Z150 F4000                          (Z DOWN FOR PART PICKUP)
G01 Y10 F3000                           (CLOSE GRIPPER JAWS AND SECURE PARTS)
G01 Z50 F4000                           (RETURN TO PROCESS POSITION)

M98 PPARTFLUX
G01 Z150 F4000                          (APPLY FLUX)
G04 P2                                  (FLUX DWELL)
G01 Z50                                 (RETURN TO PROCESS POSITION)

M98 PPREHEATON
M98 PPARTPREHEAT
G01 Z100 F4000                          (MOVE TO PREHEAT POSITION)
G04 P10                                 (PREHEAT DWELL)
G01 Z50                                 (RETURN TO PROCESS POSITION)
M98 PPREHEATOFF

M98 PPARTREMOVEALLOY
G01 Z150 F4000                          (STRIP EXISTING ALLOY)
G04 P5                                  (SOLDER DWELL) 
G01 Z50 F6000                           (RETURN TO PROCESS POSITION)

M98 PPARTFLUX
G01 Z150 F4000                          (APPLY FLUX)
G04 P2                                  (FLUX DWELL)
G01 Z50                                 (RETURN TO PROCESS POSITION)

M98 PPARTAPPLYALLOY
G01 Z150 F4000                          (APPLY NEW ALLOY)
G04 P5                                  (SOLDER DWELL)
G01 Z50 F6000                           (RETURN TO PROCESS POSITION)

M98 PWASHON
M98 PPARTWASH
G01 Z150 F4000                          (WASH PART)
M98 PWASHSHAKE L10  
G01 Z50 F4000                           (RETURN TO PROCESS POSITION)
M98 PWASHOFF                           

M98 PDRYON
M98 PPARTDRY
G01 Z100 F4000
G04 P5
G01 Z50
M98 PDRYOFF

M98 PPARTUNLOAD
G01 Z100 F4000
G01 Y0 F3000
G01 Z50 F4000 

G56
M98 PUNLOAD
M30.1
 
