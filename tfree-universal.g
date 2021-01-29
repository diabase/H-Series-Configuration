; Universal tfree macro

M453 ; Switch to CNC mode
M574 Z2 S1 P"zstop" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
M3 P0 S0 ; Set Spindle 0 RPM to 0
M3 P1 S0 ; Set Spindle 1 RPM to 0
M3 P2 S0 ; Set Spindle 2 RPM to 0
