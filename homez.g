; called to home the Z axis

; Deselect the current tool (if any) and enter FFF mode
T-1
M451

; Enable upper Z endstop and move away from the base plane
G91
M574 Z2 H1 P"zstop"
G1 H1 Z15 F4000

; Move the turret to the Z probe index
M98 P"unlock_turret.g"
G90
G1 U0 F9900
M98 P"lock_turret.g"
G92 U0

; Select the Z probe and disable the Z axis once so that we can move outside the limits again
T10 P0
M574 Z1 H2 P"zstop"
M84 Z
G90

; Go to first bed probe point and coarse home Z
M558 F1200
G30 X0 Y0

; Fine home Z
M558 F150
G30

; Measure Z axis length
M574 Z2 H1 P"zstop"
M208 Z220 S0
G91
G1 H3 Z230 F6000
G90

; Save axis length to config-override.g
M500

;Move z down
G91
G1 Z-20
G90