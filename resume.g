G1 R1 Y0 F3000 ; return to Y position
G1 R1 Z0 F3000	; lower nozzle to resume point
M83		; relative extruder moves
G1 E10 F6000	; undo the retraction