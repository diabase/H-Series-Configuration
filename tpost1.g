M42 P100 S0
M42 P101 S1
M42 P102 S1
M42 P103 S1

; Go back to the saved position
G1 R2 X0 Y0 F6000
G1 R2 Z0

; Switch to CNC mode
M453
M42 P100 S0
