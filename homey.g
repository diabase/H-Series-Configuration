; called to home the X axis

; Deselect the current tool (if any) and enter FFF mode
T-1
M451

; Lift Z relative to current position
G91
M574 Z2 S1
G1 S1 Z5 F6000
M574 Z1 S2

; Home Y
G1 S1 Y-235 F1800
G1 S2 Y5 F6000
G1 S1 Y-235 F360
G1 S2 Z-5 F6000
G90
