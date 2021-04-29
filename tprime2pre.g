; Disable E motor and select first E motor for multiplexing
; MOT 1 - LLL
; MOT 2 (5) - LLH
; MOT 3 (4) - HHL
; MOT 4 (3) - LHL
; MOT 5 (2) - HLL
M84 E0
M42 P100 S1
M42 P101 S0
M42 P102 S0

; Switch to FFF mode
;M451

; Select tool and save the current position
T2 P0
G91
G1 Z40
G60 S1


; Move up and get the bed out of the way
G90
G1 Y85 F30000

; Move nozzle to cleaning station
M98 P"unlock_turret.g"
G1 U1 F9900

; Heat up the nozzle and extrude some filament
M116 P2 S15
M42 P20 S1
M83