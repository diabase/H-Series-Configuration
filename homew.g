; homew.g
; Called to home only the W axis
; Written by Diabase Engineering
; Last Updated: February 23, 2021

M400 ; Wait for all moves to finish
M913 W50 ; Set W-axis motor current to 50%
G91 ; Relative Positioning
G1 W-40 F6000 H2 ; Move W -40mm at 6000 mm/min, ignoring endstop while moving
G92 W0 ; Set W-axis position as 0mm
M400 ; Wait for all moves to finish
M913 W100 ; Set W-axis motor current to 100%
