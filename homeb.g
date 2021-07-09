M98 P"homed.g"
T0 P0       ;remove any B tool offset
G91 
G1 B-500 H1 F8000
G1 B2 F8000
G1 B-5 H1 F200
G92 B-213.8
G90
G1 B0 F8000
T{state.previousTool} P0    ;restore tool offsets from before homing