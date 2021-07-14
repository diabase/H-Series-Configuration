; Universal tpre macro
; Called whenever a tool is selected
; Written by Diabase Engineering
; Last Updated: July 14, 2021

M453 ; Switch to CNC mode
if {global.MachineModel} == "H4"
    M84 E0:1:2:3 ; Idle all extruder motors

; Only perform machine moves if we need to change the turret position
if move.axes[3].machinePosition != -tools[{state.nextTool}].offsets[3]
    ; echo "The turret is currently at "^move.axes[3].machinePosition^". Tool "^state.nextTool^" is located at "^-tools[{state.nextTool}].offsets[3]^"."
    G91 ; Relative Positioning

    if move.axes[2].machinePosition + 40 <= move.axes[2].max ; If we have enough room for a normal tool change Z-hop, do it.
        G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
    elif move.axes[2].machinePosition + 40 > move.axes[2].max ; If we don't have enough room, move as high as we can.
        M574 Z2 S1 P{global.ZSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in machinespecific.g
        M400 ; Wait for all moves to finish
        ;M913 Z50; Reduce Z-axis motor current to 50%
        G1 Z40 F6000 H3 ; Attempt to move Z +40mm at 6000 mm/min, but halt if endstop triggered and set axis limit current position, overriding value set by previous M208 or G1 H3 special move
        M400 ; Wait for all moves to finish
        M913 Z100 ; Restore Z-axis motor current to 100%

    M98 P"unlock_turret.g" ; Call unlock_turret.g
    G90 ; Absolute Positioning

    ; echo "Rotating turret to "^{-tools[{state.nextTool}].offsets[3]}
    G1 U{-tools[{state.nextTool}].offsets[3]} F8900 ; Rotate turret to new tool
    G4 P20 ; Dwell for 20 ms

    M98 P"lock_turret.g" ; Call lock_turret.g
