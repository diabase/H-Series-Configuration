if state.machineMode="FFF"
    G91 ; Relative Moves
    if move.axes[2].machinePosition - tools[2].offsets[2] <= move.axes[2].max
        G1 Z{-tools[2].offsets[2]} ; Apply (for a second time) the Z-axis tool offset for Tool 2 in preparation for a downward move to the starting position when the offset is removed.
    elif move.axes[2].machinePosition - tools[2].offsets[2] > move.axes[2].max
        M574 Z2 S1 P"zstop" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
        G1 H3 Z{-tools[2].offsets[2]} ; Apply (for a second time) the Z-axis tool offset for Tool 2 in preparation for a downward move to the starting position when the offset is removed.
if state.machineMode="CNC"
    M3 P0 S0 ; Set Spindle 0 RPM to 0
    M3 P1 S0 ; Set Spindle 1 RPM to 0
    M3 P2 S0 ; Set Spindle 2 RPM to 0
