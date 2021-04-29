G1 R1 Z2 F3000	; move to 2mm above resume point
G1 R1 Z0	; lower nozzle to resume point
M83		; relative extruder moves
G1 E10 F6000	; undo the retraction