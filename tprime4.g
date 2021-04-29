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
G1 Z40 F6000
G60 S1


; Move up and get the bed out of the way

G90
G1 Y85 F30000

; Move nozzle to cleaning station
M98 P"unlock_turret.g"
G1 U145.1 F9900


; Heat up the nozzle and extrude some filament
M116 P4 S15
M42 P20 S1
M83
G1 E15 F6000 ;Gerjan 29/01/20 put it back to E15 Martijn (E5) 16-12-19 changed to fix error where extruder stops printing
M42 P20 S0.75
G1 E14 F600 ; Gerjan 31/01/2020 changed for flex was rigid E10, 29/05/2019 changed from E6 to E15 and F300 to F600
M400
G4 P3000 ;  Gerjan 29/05/2019 pause for 3 seconds to let the filament blob cool
M42 P20 S0
G1 E-17 F6000 ;Gerjan 31/01/2020 changed for flex was rigid according to diabase tutorial (E-15) Martijn (E-5) 16-12-19 changed to fix error where extruder stops printing. Gerjan 12/12/2019 changed for rigid, 29/05/2019  changed from E-9.7 to E-15
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