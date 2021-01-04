; called to home all axes

; Deselect the current tool (if any)
T-1

; Enable upper Z endstop and move away from the base plane
M574 Z2 S1
G91
G1 S1 Z60 F4000

; Unlock the turret and disable stall detection for it
M98 P"unlock_turret.g"
M915 U R0

; Home X Y Z U
G1 S1 X-400 Y-180 Z220 U-380
G1 S2 X2 Y2 Z-2 U2 F6000
G1 S1 X-20 Y-20 Z20 U-20 F3000

; Move to the Z probe offset and lock the turret again
G90
G1 U0 F9900
M98 P"lock_turret.g"
M400
M18 U
G91
G1 V-0.5
G90
G92 U0


; Go to X=0 Y=0
G1 X0 Y0 F12000
G60 S1

; Put all the tools into standby mode and leave the Z probe tool activated
T1 P0
T2 P0
T3 P0
T4 P0
T5 P0
T10 P0