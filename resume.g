
M3 R1 P0        ; restore spindle RPM
M3 R1 P1        ; restore spindle RPM

G1 R1 Y0 F3000
G1 R1 Z0 F3000	; move to 2mm above resume point

;M83		; relative extruder moves
;G1 E10 F6000	; undo the retraction
