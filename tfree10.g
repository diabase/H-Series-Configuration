M574 Z2 H1 P"zstop"
if state.machineMode="CNC"
    M3 P0 S0 ; Turn off Spindle 1
    M3 P1 S0 ; Turn off Spindle 2
    M3 P2 S0 ; Turn off Spindle 3
    M451 Switch to FFF Mode

G91 ; Relative Moves
G1 X{-tools[10].offsets[0]} Y{-tools[10].offsets[1]} Z{-tools[10].offsets[2]} ; Double tool offset in preparation for its removal
