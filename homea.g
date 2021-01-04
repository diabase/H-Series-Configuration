G91 ; relative positioning
G1 A-380 F2000 S1 ; rotate ccw until hitting the endstop
G1 A10 F1000 S2 ; go back cw by a few degrees
G1 A-20 F500 S1 ; rotate ccw once more until hitting the endstop, this time going slower
G90 ; absolute positioning
G92 A0 ; set new position