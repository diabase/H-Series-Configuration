M83			; relative extruder moves
G1 E-10 F6000		; retract 10mm
G91			; relative moves
G1 Z5 F3000		; raise nozzle 5mm
G90			; absolute moves
G1 X160 Y80 Z200 F6000	; move head out of the way of the print
G10 P1 S0 R0
G10 P2 S0 R0
G10 P3 S0 R0
G10 P4 S0 R0
G10 P5 S0 R0