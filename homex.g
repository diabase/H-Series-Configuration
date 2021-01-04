G91 ; relative positioning
M574 Z2 S1 ; enable upper Z endstop
G1 S1 Z5 F6000 ; lift Z relative to current position
M574 Z1 S2 ; switch back to Z probe
G1 S1 X-400 F1800 ; move quickly to X axis endstop and stop there (first pass)
G1 S2 X5 F6000 ; go back a few mm
G1 S1 X-400 F360 ; move slowly to X axis endstop once more (second pass)
G1 S2 Z-5 F6000 ; lower Z again
G90 ; absolute positioning
