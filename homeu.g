; called to home the U axis

; Deselect the current tool (if any) and enter FFF mode
T-1
M451

; Unlock the turret and disable stall detection

M98 P"unlock_turret.g"

M400

; Home U
G91
G1 H1 U-380 F1000
G1 H2 U2
G1 H1 U-20 F900
G90

; Go to the Z probe offset and select the corresponding tool
G1 U0

; Lock the turret again
M98 P"lock_turret.g"

G92 U0
T10 P0
M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe

;