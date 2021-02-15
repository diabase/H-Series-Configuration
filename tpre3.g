M84 E0:1:2:3 ; Idle all extruder motors
M42 P2 S0 ; Set GPIO pin 2 low
M42 P3 S1 ; Set GPIO pin 3 high
M42 P4 S0 ; Set GPIO pin 4 low

M453 ; Switch to CNC mode

G91 ; Set to Relative Positioning
G1 Z40 F6000 H1 ; Move Z up by 40 mm at 6000mm/min. Terminate the move if endstop switch is triggered and set axis position to axis limit.

M98 P"unlock_turret.g" ; Call unlock_turret.g
G90 ; Set to Absolute Positioning

G1 U174   F16000 ; Rotate turret (U) to 174   at 16000 mm/min
G4 P20 ; Dwell for 20 ms

M98 P"lock_turret.g" ; Call lock_turret.g