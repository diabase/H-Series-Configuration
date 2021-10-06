; tprime3.g
; Called to prime and clean tool 3
; Written by Diabase Engineering
; Last Updated: August 6, 2021

M118 S{"Debug: Begin tprime3.g"} L3

if state.currentTool != 3
    if state.currentTool == -1
        G60 S0 ; Save current position in the slot reserved for user-stored positions
        G92 U{-tools[3].offsets[3]}
    else
        G92 U{tools[{state.currentTool}].offsets[3]-tools[3].offsets[3]} ; We don't want to move the turret before the first priming rotation, so we falsely set the current turret position to the expected position for Tool 3 which causes tpre-universal.g to skip the Z-hop and turret rotation.

    T3 ; Select Tool

    if state.previousTool == -1
        G92 U{state.restorePoints[0].coords[3]} ; Return the logical U-axis position to the actual position stored above.
    else
        G92 U{-(tools[{state.previousTool}].offsets[3]-tools[3].offsets[3])} ; Return the logical U-axis position to the actual position

M98 P"tprime-universal.g" ; Call tprime-universal.g

M118 S{"Debug: End tprime3.g"} L3
