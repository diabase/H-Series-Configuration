M84 E0:1:2:3 ; Idle all extruder motors

M453 ; Switch to CNC mode

G91 ; Set to Relative Positioning
G1 Z40 F6000 H3 ; Attempt to move Z +40mm at 6000 mm/min, but halt when endstop triggered and set axis limit current position, overriding value set by M208 in config.g
; G60 S0 ; Save current position to slot 0

M98 P"unlock_turret.g" ; Call unlock_turret.g
G90 ; Set to Absolute Positioning

G1 U0 F9900 ; Rotate turret (U) to 0mm at 9900 mm/min
G4 P20 ; Dwell for 20 ms

M98 P"lock_turret.g" ; Call lock_turret.g

M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe
