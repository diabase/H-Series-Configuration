; called to home the X axis

; Deselect the current tool (if any) and enter FFF mode
T-1
M451
M913 X50
; Lift Z relative to current position
G91
M574 Z2 S1
G1 S1 Z5 F6000
M574 Z1 S2

; Home X
G1 S1 X-400 F1800
G1 S2 X5 F6000
G1 S1 X-400 F360
G1 S2 Z-5 F6000
G90

M913 x100