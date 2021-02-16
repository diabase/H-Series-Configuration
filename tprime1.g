; Disable E motor and select first E motor for multiplexing
; MOT 1 - LLL
; MOT 2 (5) - LLH
; MOT 3 (4) - HHL
; MOT 4 (3) - LHL
; MOT 5 (2) - HLL
M84 E0
M42 P100 S0
M42 P101 S0
M42 P102 S0

; Switch to FFF mode
M451

; Select tool and save the current position
T1 P0


; Move up and get the bed out of the way
G91
G1 Z15 F6000
G60 S1

G90
G1 Y85 F30000

; Move nozzle to cleaning station
M98 P"unlock_turret.g"
G1 U289.3 F9900
;G4 P20



; Heat up the nozzle and extrude some filament
M116 P1 S10
M42 P0 S1
M83
G1 E50 F6000
M42 P0 S0.75
G1 E8 F250
M400
M42 P0 S0
G1 E-9.9 F6000
G4 P20

; Move nozzle so that it faces the pliers

G1 U300.7 F9900
;G4 P20

; Turn on vacuum
 M106 P8 S1

; Perform cleaning cycle
M98 P"clean.g"

;Leave blades closed
M42 P1 S1
G4 P20
M42 P1 S0.4

; Move the nozzle so that if faces the bed
G1 U30 F9900
G4 P20
M98 P"lock_turret.g"

; Perform post-cleaning of the pliers
M98 P"postclean.g"

; Turn off vacuum
M106 P8 S0

; Go back to the saved coordinates
G1 R1 Y0 F30000
G1 R1 Z0 F6000