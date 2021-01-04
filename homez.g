; called to home the Z axis

; Deselect the current tool (if any) and enter FFF mode
T-1
M451

; Enable upper Z endstop and move away from the base plane
G91
M574 Z2 H1 P"zstop"

G1 H1 Z260 F6000

G1 H2 Z-2 F6000
G1 H1 Z5 F1000
