
; M451 ; Switch to FFF mode (Uncomment if and only if this tool is an extruder.)
M453 ; Switch to CNC mode (Uncomment if and only if this tool is a spindle.)

G91 ; Set to Relative Positioning
G1 Z40 F6000 H1 ; Move Z up by 40 mm at 6000mm/min. Terminate the move if endstop switch is triggered and set axis position to axis limit.
G90 ; Set to Absolute Positioning
M98 P"unlock_turret.g" ; Call unlock_turret.g

G1 U102 F16000 ; Rotate turret (U) to 102 at 16000 mm/min
G4 P20 ; Dwell for 20 ms

M98 P"lock_turret.g" ; Call lock_turret.g

G1 R2 X0 Y0 F6000 ; Return to X and Y coordinates stored in restore point 2 at a speed of 6000 mm/min
G1 R2 Z0 ; Return to Z coordinate stored in restore point 2

M140 S0 ; Ensure bed heater is off to protect power supply. (Uncomment if and only if this tool is a spindle using the 48V power supply.)
