; Called to home only the W axis

M913 W50 ; Set W-axis motor current to 50%
G91 ; Relative Positioning
G1 W-40 H2 ; Move W -40, ignoring endstop while moving
G92 W0 ; Set W-axis position as 0mm
M913 W100 ; Set W-axis motor current to 100%
