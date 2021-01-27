; called to home the Y axis
M574 Y1 S1 P"ystop"

; Deselect the current tool (if any) and enter FFF mode
T-1 P0
M451

; Lift Z relative to current position
G91
M574 Z2 H1 P"zstop"
G1 H1 Z5 F6000
M574 Z1 H2 P"zstop"

; Home Y
G1 H1 Y-235 F1800
G1 H2 Y5 F6000
G1 H1 Y-235 F360
G1 H2 Z-5 F6000
G90
