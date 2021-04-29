M83			; relative extruder moves
;G1 E-10 F6000		; retract 10mm
G91			; relative moves
G1 Z50 S1 F3000		; raise nozzle 5mm
G90			; absolute moves
G1 Y80 F6000	; move head out of the way of the print
G10 P1 S0 R0
G10 P2 S0 R0
G10 P3 S0 R0
G10 P4 S0 R0
G10 P5 S0 R0

M140 S-273 ; Dimitris 8/4/2021, Turn off the bed: for leaving the printer unattended to finish a print..

M98 P"drycabinet.g" ;Gerjan 11/12/19 turn dry chamber back on
;M141 P1 H2 S0; turn dry chamber back on (set point = 0% RH) (Martijn on 22-06-19: added "H2") - Gerjan 11/12/19: commented it out
;M141 P1 S5; Gerjan 11/10/19 turn dry chamber back on

M106 P3 S0; Gerjan 11/10/19 Turn off layer fan
m106 P7 s0; disable air pressure valve