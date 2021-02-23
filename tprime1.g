; tprime1.g
; Called to prime and clean tool 1
if state.currentTool != 1
if state.currentTool == -1
    G60 S0 ; Save current position in the slot reserved for user-stored positions
    G92 U{-tools[1].offsets[3]}
else
    G92 U{tools[{state.currentTool}].offsets[3]-tools[1].offsets[3]} ; We don't want to move the turret before the first priming rotation, so we falsely set the current turret position to the expected position for Tool 1 which causes tpre-universal.g to skip the Z-hop and turret rotation.

T1 ; Select Tool

if state.previousTool == -1
    G92 U{state.restorePoints[0].coords[3]} ; Return the logical U-axis position to the actual position stored above.
else
    G92 U{-(tools[{state.previousTool}].offsets[3]-tools[1].offsets[3])} ; Return the logical U-axis position to the actual position

M98 P"tprime-universal.g" ; Call tprime-universal.g
