#C:\MaestroLite Data\MICROSS SUB UTILITIES ROTARY.nc
M98 PPUMP1START
(M98 PLOAD
(Initialization Complete )
G52 X0 Y0 Z0  (Calibration Offsets)
 

( ********************** MAIN G-CODE *********************** 
 
M98 PPARTLOADROTARY
G01 X140 F8000
G01 Z-90 F2000
M28                           (TURN VACUUM PICKUP ON)
G01 Z-5 F6000                 (RETURN TO PROCESS POSITION)
M33

M98 PPARTFLUX1

M98 PQFPDIPRIGHTOFFSET
G01 Z-68.13
M98 PQFPDIPRIGHT
G01 Z-68.13
M98 PQFPDIPRIGHT
G01 Z-68.13
M98 PQFPDIPRIGHT
G01 Z-68.13
M98 PQFPDIPRIGHT

M98PQFPDIPLEFTOFFSET
M98 PQFPDIPLEFT
                        

M98 PPARTPREHEATROTARY
G01 Z-50 F6000
G04 P10                               (PREHEAT DWELL
G01 Z-5       F6000                          (RETURN TO PROCESS POSITION


M98 PPARTAPPLYALLOYDSPLEAD

G01 Z-67.1
M98 PQFPDIPRIGHT
G01 Z-67.1
M98 PQFPDIPRIGHT
G01 Z-67.1
M98 PQFPDIPRIGHT
G01 Z-67.1
M98 PQFPDIPRIGHT
M17 M35


M98 PPARTWASH
M98 PQFPDIPRIGHTOFFSET
G01 Z-72 F6000
G92 B0
G91
G01 B2880 F10000
G90
G01 Z-5 F4000                          (WASH PART

M98 PDRYON
M98 PPARTDRY
M98 PDRYOFF

M98 PPARTUNLOAD
G01 X140
G01 Z-91 F6000
M29
G04 P1.0
G91
G01 X-5
G90
G01 Z-5 F6000 

G56
M98 PUNLOAD
M30.1

