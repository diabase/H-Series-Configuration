G90 ; Set to Absolute Positioning
M400 ; Wait for current moves to finish
; G1 W21 F15000 ; Move W to 21 at 15000 mm/min
M42 P0 S1
M400 ; Wait for current moves to finish
M42 P1 S1 ; Close pliers
G4 P125 ; Dwell for 125 ms
; G28 W ; Home W
M42 P0 S0.75
M42 P1 S0.5 ; Reduce pliers solenoid current to 50%
G4 P175 ; Dwell for 175 ms
M42 P1 S0 ; Open Pliers
M400 ; Wait for current moves to finish
