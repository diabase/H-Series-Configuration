; tprime2.g
; Called to prime and clean tool 2
; Written by Diabase Engineering
; Last Updated: October 29, 2021

M118 S{"Debug: Begin tprime2.g"} L3

if state.currentTool != 2
    if state.currentTool == -1
        G60 S0 ; Save current position in the slot reserved for user-stored positions
        G92 U{-tools[2].offsets[3]}
    else
        G92 U{tools[{state.currentTool}].offsets[3]-tools[2].offsets[3]} ; We don't want to move the turret before the first priming rotation, so we falsely set the current turret position to the expected position for Tool 2 which causes tpre-universal.g to skip the Z-hop and turret rotation.

    T2 ; Select Tool

    if state.previousTool == -1
        G92 U{state.restorePoints[0].coords[3]} ; Return the logical U-axis position to the actual position stored above.
    else
        G92 U{-(tools[{state.previousTool}].offsets[3]-tools[2].offsets[3])} ; Return the logical U-axis position to the actual position

set global.currentAdditionalRetraction = global.t2AdditionalRetraction

M98 P"tprime-universal.g" ; Call tprime-universal.g

M118 S{"Debug: End tprime2.g"} L3