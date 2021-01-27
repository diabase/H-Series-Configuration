; called to home only the Z axis

M84 E0:1:2:3 ; Idle all extruder motors
T-1 P0 ; Deselect current tool
M451 ; Switch to FFF Mode

G91 ; Relative Positioning
M574 Z2 S1 P"zstop" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"

G1 H1 Z260 F6000 ; Attempt to move Z +260mm at 6000 mm/min, but halt when endstop triggered and set axis position to axis limit as defined with M208 in config.g
G1 H2 Z-2 F6000 ; Move Z -2mm at 6000 mm/min, ignoring endstop while moving
G1 H1 Z5 F1000 ; Attempt to move Z +5mm at 1000 mm/min, but halt when endstop triggered and set axis position to axis maximum as defined in config.g
