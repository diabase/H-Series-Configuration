; Disable E motor and select first E motor for multiplexing

M84 E0
M42 P100 S1
M42 P101 S1
M42 P102 S0

; Switch to FFF mode
M451

; Select tool and save the current position
T4 P0
G91
G1 Z15 F6000
G60 S1

; Move up and get the bed out of the way

G90
G1 Y85 F30000

; Move nozzle to cleaning station
M98 P"unlock_turret.g"
G1 U146 F9900


; Heat up the nozzle and extrude some filament
M116 P4 S10
M42 P20 S1
M83
G1 E18 F6000
M42 P20 S0.75
G1 E10 F300
M400
M42 P20 S0
G1 E-10 F6000
G4 P20

; Move nozzle so that it faces the pliers

G1 U157 F9900
G4 P20


; Turn on vacuum
M106 P7 S1

; Perform cleaning cycle
M98 P"clean.g"

;Leave blades closed
M42 P22 S1
G4 P20
M42 P22 S0.4

; Move the nozzle so that if faces the bed
G1 U246 F9900
G4 P20
M98 P"lock_turret.g"


; Perform post-cleaning of the pliers
M98 P"postclean.g"

;Turn off vacuum
M106 P7 S0

; Go back to the saved coordinates
G1 R1 Y0 F30000
G1 R1 Z0 F6000