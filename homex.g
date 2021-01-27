; called to home the X axis
M574 X1 S1 P"xstop"


; Deselect the current tool (if any) and enter FFF mode
T-1 P0
M451
M913 X50
; Lift Z relative to current position
G91
M574 Z2 H1 P"zstop"
G1 H1 Z5 F6000
M574 Z1 H2

; Home X
G1 H1 X-400 F1800
G1 H2 X5 F6000
G1 H1 X-400 F360
G1 H2 Z-5 F6000
G90

M913 x100
