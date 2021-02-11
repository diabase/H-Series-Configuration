; Universal tfree macro

M453 ; Switch to CNC mode
M574 Z2 S1 P"zstop" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
M5 ; Turn off all spindles
