M84 E0 ; Stop idle hold on all(?) E motors

M451 ; Switch to FFF mode

G91 ; Set to Relative Positioning
G1 Z40 F6000 H1 ; Move Z up by 40 mm at 6000mm/min. Terminate the move if endstop switch is triggered and set axis position to axis limit.
G90 ; Set to Absolute Positioning
M98 P"unlock_turret.g" ; Call unlock_turret.g

G1 U0 F9900 ; Rotate turret (U) to 0mm at 9900 mm/min
G4 P20 ; Dwell for 20 ms

M98 P"lock_turret.g" ; Call lock_turret.g

;G92 U0 ; Assign current U position to 0
M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe

G1 R2 X0 Y0 F6000 ; Return to X and Y coordinates stored in restore point 2 at a speed of 6000 mm/min
G1 R2 Z0 ; Return to Z coordinate stored in restore point 2
