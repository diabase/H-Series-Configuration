M453 ; Switch to CNC mode

; Select tool and save the current position
T4 P0 ; Select tool 4 but don't run any tool change macro files
G91 ; Set to Relative Positioning
G1 Z40 F6000 H1 ; Move Z up 40 mm at 6000 mm/min. Terminate the move if endstop switch is triggered and set axis position to axis limit.
G60 S1 ; Save current position to slot 1

G90 ; Set to Absolute Positioning
G1 Y85 F30000 ; Move Y to 85 mm at 30000 mm/min

; Move nozzle to cleaning station
M98 P"unlock_turret.g" ; Call unlock_turret.g
G1 U146 F9900; Rotate turret (U) to 146 at 9900 mm/min (*** Inherits G91 relative positioning from unlock_turret.g? ***)
; G4 P20 ; Dwell for 20 ms
M451 ; FFF mode

M116 P4 S5 ; Wait until Tool 4 reaches +/-5C of its set value
G1 W23 F15000 ; Move W +23 at 15000 mm/min (*** Inherits G91 relative positioning from unlock_turret.g? ***)
; M42 P0 S1 ; Set GPIO pin 0 high
M83 ; Set Extruder to Relative Mode
G1 E15 F6000 ; Extrude 15 mm at 6000 mm/min
; M42 P0 S0.75 ; Set GPIO pin 0 to 75%
G1 E8 F200 ; Extrude 8 mm at 200 mm/min
M400 ; Wait for current moves to finish
; M42 P0 S0 ; Set GPIO pin 0 to low
G1 W20 F6000 ; Move W +20 at 6000 mm/min (*** Inherits G91 relative positioning from unlock_turret.g? ***)
G1 E-16 F6000 ; Retract 16 mm at 6000 mm/min
G4 P20 ; Dwell for 20 ms

; Move nozzle so that it faces the pliers
G1 U156.7 F9900 ; Rotate turret (U) to 156.7 at 9900 mm/min (*** Inherits G91 relative positioning from unlock_turret.g? ***)
G4 P20 ; Dwell for 20 ms

; M106 P8 S1 ; Turn on vacuum

; M106 P7 S1 ; Set Fan 7 to 100%
M98 P"clean.g" ; Call clean.g

M42 P1 S1 ; Close pliers
G4 P20 ; Dwell for 20 ms
M42 P1 S0.4 ; Reduce pliers solenoid current to 40%

; Move the nozzle so that if faces the bed
G1 U246 F9900 ; Rotate turret (U) to 246 at 9900 mm/min (*** Inherits G91 relative positioning from unlock_turret.g? ***)
G4 P20 ; Dwell for 20 ms
M98 P"lock_turret.g" ; Call lock_turret.g

; Perform post-cleaning of the pliers
M98 P"postclean.g" ; Call postclean.g

; M106 P8 S0 ; Turn off vacuum

G1 R1 Y0 F30000 ; Return to Y coordinate saved in restore point 1 at 30000 mm/min
G1 R1 Z0 F6000 ; Return to Z coordinate saved in restore point 1 at 6000 mm/min