; Disable all (?) E motors and enable E motor for this tool
; MOT 1 (Tool 1) - LLL
; MOT 2 (Tool 5) - LLH
; MOT 3 (Tool 4) - HHL
; MOT 4 (Tool 3) - LHL
; MOT 5 (Tool 2) - HLL
M84 E0 ; Stop idle hold on all(?) E motors
M42 P2 S1 ; Set GPIO pin 2 high
M42 P3 S0 ; Set GPIO pin 3 low
M42 P4 S0 ; Set GPIO pin 4 low

M451 ; Switch to FFF mode

; Select tool and save the current position
T2 P0 ; Select tool 2 but don't run any tool change macro files
G91 ; Set to Relative Positioning
G1 Z15 ; Move Z up 15 mm
G60 S1 ; Save current position to slot 1

G90 ; Set to Absolute Positioning
G1 Y85 F30000 ; Move Y to 85 mm at 30000 mm/min

; Move nozzle to cleaning station
M98 P"unlock_turret.g" ; Call unlock_turret.g
G1 U1 F9900; Rotate turret (U) to 1 at 9900 mm/min (*** Inherits G91 relative positioning from unlock_turret.g? ***)
; G4 P20 ; Dwell for 20 ms
; M451 ; FFF mode

M116 P2 S10 ; Wait until Tool 2 reaches +/-10C of its set value
; G1 W23 F15000 ; Move W +23 at 15000 mm/min (*** Inherits G91 relative positioning from unlock_turret.g? ***)
M42 P0 S1 ; Set GPIO pin 0 high
M83 ; Set Extruder to Relative Mode
G1 E18 F6000 ; Extrude 18 mm at 6000 mm/min
M42 P0 S0.75 ; Set GPIO pin 0 to 75%
G1 E6 F300 ; Extrude 6 mm at 300 mm/min
M400 ; Wait for current moves to finish
M42 P0 S0 ; Set GPIO pin 0 to low
; G1 W20 F6000 ; Move W +20 at 6000 mm/min (*** Inherits G91 relative positioning from unlock_turret.g? ***)
G1 E-9.9 F6000 ; Retract 9.9 mm at 6000 mm/min
G4 P20 ; Dwell for 20 ms

; Move nozzle so that it faces the pliers
G1 U12.6 F9900 ; Rotate turret (U) to 12.6 at 9900 mm/min (*** Inherits G91 relative positioning from unlock_turret.g? ***)
; G4 P20 ; Dwell for 20 ms

; M106 P8 S1 ; Turn on vacuum

M106 P7 S1 ; Set Fan 7 to 100%
M98 P"clean.g" ; Call clean.g

M42 P1 S1 ; Close pliers
G4 P20 ; Dwell for 20 ms
M42 P1 S0.4 ; Reduce pliers solenoid current to 40%

; Move the nozzle so that if faces the bed
G1 U102 F9900 ; Rotate turret (U) to 102 at 9900 mm/min (*** Inherits G91 relative positioning from unlock_turret.g? ***)
G4 P20 ; Dwell for 20 ms
M98 P"lock_turret.g" ; Call lock_turret.g

; Perform post-cleaning of the pliers
M98 P"postclean.g" ; Call postclean.g

; M106 P8 S0 ; Turn off vacuum

G1 R1 Y0 F30000 ; Return to Y coordinate saved in restore point 1 at 30000 mm/min
G1 R1 Z0 F6000 ; Return to Z coordinate saved in restore point 1 at 6000 mm/min
