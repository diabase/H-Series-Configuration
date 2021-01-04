; Enable upper Z endstop and move away from the base plane
M574 Z2 S1
G91
G1 S1 Z15 F4000

; Unlock the turret
M98 P"unlock_turret.g"

; Move to the Z probe offset and lock the turret again
G90
G1 U0 F9900
M98 P"lock_turret.g"
G92 U0

; Select the Z probe and disable the Z axis once so that we can move outside the limits again
T10 P0
M574 Z1 S2
M84 Z
G90

; Go to first bed probe point and coarse home Z
M558 F1200
G30 X0 Z0

; Fine home Z
M558 F150
G30

; Measure Z axis length
M574 Z2 S1
M208 Z240
G91
G1 S3 Z240 F6000
G90

; Save axis length to config-override.g
M500