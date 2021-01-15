; Disable E motor and select first E motor for multiplexing

M84 E0:1:2:3
M42 P2 S0
M42 P3 S1
M42 P4 S0

; Switch to CNC mode
M453

; Select tool and save the current position
T3 P0
G91
G1 Z40 F6000 H1
G60 S1

; Move up and get the bed out of the way

G90
G1 Y85 F30000

; Move nozzle to cleaning station
M98 P"unlock_turret.g"
G1 U74.5 F9900

M451 ; FFF mode
; Heat up the nozzle and extrude some filament
M116 P3 S5
G1 W27 F15000
M83
G1 E20 F6000

G1 E8 F200
M400
G1 W20 F15000
G1 E-12 F6000
G4 P20

; Move nozzle so that it faces the pliers
G1 U84.2 F9900

; Turn on vacuum
M106 P7 S1

; Perform cleaning cycle
M98 P"clean.g"

;Leave blades closed
M42 P1 S1
G4 P20
M42 P1 S0.4

; Move the nozzle so that if faces the bed
G1 U174 F9900
G4 P20
M98 P"lock_turret.g"

; Perform post-cleaning of the pliers
M98 P"postclean.g"

;turn off vacuum
M106 P7 S0

; Go back to the saved coordinates
G1 R1 Y0 F30000
G1 R1 Z0 F6000
