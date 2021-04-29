; Disable E motor and select first E motor for multiplexing
; MOT 1 - LLL
; MOT 2 (5) - LLH
; MOT 3 (4) - HHL
; MOT 4 (3) - LHL
; MOT 5 (2) - HLL
M84 E0
M42 P100 S0
M42 P101 S0
M42 P102 S1

; Switch to FFF mode
M451

; Select tool and save the current position
T5 P0
G91
G1 Z40 F6000
G60 S1


; Move up and get the bed out of the way

G90
G1 Y85 F30000

; Move nozzle to cleaning station
M98 P"unlock_turret.g"
G1 U217.1 F9900
G4 P20

; Heat up the nozzle and extrude some filament
M116 P5 S15
M42 P20 S1
M83
G1 E15 F6000
M42 P20 S0.75
G1 E15 F600 ; Gerjan 29/05/2019  changed from E6 to E15 and F6000 to F600
M400
G4 P3000 ;  Gerjan 29/05/2019 pause for 3 seconds to let the filament blob cool
M42 P20 S0
G1 E-15 F6000 ; Gerjan 29/05/2019  changed from E-9.9 to E-15
G4 P20


; Move nozzle so that it faces the pliers
G1 U228.4 F9900

; Turn on vacuum
M106 P7 S1

; Perform cleaning cycle
M98 P"clean.g"
M98 P"clean.g"  ; Gerjan 29/05/2019 double cleaning

;keep blades closed
M42 P22 S1
G4 P20
M42 P22 S0.4

; Move the nozzle so that if faces the bed
G1 U318.3 F9900
G4 P20
M98 P"lock_turret.g"

; Perform post-cleaning of the pliers
M98 P"postclean.g"

;Turn off vacuum
M106 P7 S0

; Go back to the saved coordinates
G1 R1 Y0 F30000
G1 R1 Z0 F6000