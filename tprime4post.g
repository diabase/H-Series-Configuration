G4 P20

; Move nozzle so that it faces the pliers

G1 U156.5 F9900
G4 P20

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
G1 U246.3 F9900
G4 P20
M98 P"lock_turret.g"

; Perform post-cleaning of the pliers
M98 P"postclean.g"

;Turn off vacuum
M106 P7 S0

; Go back to the saved coordinates
G1 R1 Y0 F30000
G1 R1 Z0 F6000