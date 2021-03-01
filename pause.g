M83			; relative extruder moves
G1 E-10 F6000		; retract 10mm
G91			; relative moves
G1 Z5 F3000		; raise nozzle 5mm
G90			; absolute moves
G1 X200 Y85 F6000	; move head out of the way of the print
M3 P0 S0
M3 P1 S0