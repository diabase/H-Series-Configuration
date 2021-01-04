; called to home the U axis

; Deselect the current tool (if any)
T-1

; Unlock the turret and disable stall detection
M98 P"unlock_turret.g"
M915 U R0

; Home U
G91
G1 S1 U-380 F3000
G1 S2 U2
G1 S1 U-20 F1800
G90

; Go to the Z probe offset and select the corresponding tool
G1 U0

; Lock the turret again
M98 P"lock_turret.g"

