#C:\MaestroLite Data\MICROSS SUB UTILITIES ROTARY.nc
(M98 PPUMPSTART
(M98 PLOAD
(Initialization Complete )
G52 X0 Y0 Z0  (Calibration Offsets)
 
 
( ********************** MAIN G-CODE *********************** 
 
M98 PPARTLOADROTARY
G01 Z-75 F2000
(G01 X10 F200                           (MOVE GRIPPER INTO LOAD POSITION)                          (Z DOWN FOR PART PICKUP)
(G01 Y10.2 F100                           (CLOSE GRIPPER JAWS AND SECURE PARTS)
G01 Z-25 F6000                           (RETURN TO PROCESS POSITION)

M98 PPARTFLUX1

M98 PQFPDIPRIGHT
M98 PQFPDIPRIGHT
M98 PQFPDIPRIGHT
M98 PQFPDIPRIGHT
                        (RETURN TO PROCESS POSITION

M98 PPARTPREHEATROTARY
G01 Z-50 F6000
G04 P10                               (PREHEAT DWELL
G01 Z-25       F6000                          (RETURN TO PROCESS POSITION


M98 PPARTAPPLYALLOYDSPLEAD

M98 PQFPDIPRIGHT
M98 PQFPDIPRIGHT
M98 PQFPDIPRIGHT
M98 PQFPDIPRIGHT

M98 PPARTWASH
G01 Z-50 F6000
G92 B0
G91 
G01 B2880 F10000
G90                          (WASH PART                          

M98 PDRYON
M98 PPARTDRY
M98 PDRYOFF

M98 PPARTUNLOAD
G01 Z-50 F6000
(G01 Y1 F500
G01 Z-25 F6000 

G56
M98 PUNLOAD
M30.1
