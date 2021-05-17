; Universal tpost macro

;ORIGINALLY FROM TPRE:

M453 ; Switch to CNC mode

; Only perform machine moves if we need to change the turret position
if move.axes[3].machinePosition != -tools[{state.nextTool}].offsets[3] ;SHOULD STILL WORK AS NEXTTOOL=CURRENTTOOL
    ; echo "The turret is currently at "^move.axes[3].machinePosition^". Tool "^state.nextTool^" is located at "^-tools[{state.nextTool}].offsets[3]^"."
    G91 ; Relative Positioning

    if move.axes[2].machinePosition + 40 <= move.axes[2].max ; If we have enough room for a normal tool change Z-hop, do it. NEED TO CHECK MACHINE POSITIONS IN POST VS PRE
        G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
    elif move.axes[2].machinePosition + 40 > move.axes[2].max ; If we don't have enough room, move as high as we can.
        M574 Z2 S1 P"!io4.in" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
        M400 ; Wait for all moves to finish
        ;M913 Z50; Reduce Z-axis motor current to 50%
        G1 Z40 F6000 H3 ; Attempt to move Z +40mm at 6000 mm/min, but halt if endstop triggered and set axis limit current position, overriding value set by previous M208 or G1 H3 special move
        M400 ; Wait for all moves to finish
        M913 Z100 ; Restore Z-axis motor current to 100%

    M98 P"unlock_turret.g" ; Call unlock_turret.g
    G90 ; Absolute Positioning

    ; echo "Rotating turret to "^{-tools[{state.nextTool}].offsets[3]}
    G1 U{-tools[{state.nextTool}].offsets[3]} F16000 ; Rotate turret to new tool
    G4 P20 ; Dwell for 20 ms

    M98 P"lock_turret.g" ; Call lock_turret.g

;ORIGINAL TPOST:

if tools[{state.nextTool}].spindle>-1       ; If this tool is a spindle...
    M453 ; Switch to CNC mode
    if heat.heaters[0] != null ; If we have defined a bed heater...
        if heat.heaters[0].state != "fault" ; ...and it's not in a fault state...
            M140 H0 S-273.15 ; ...turn it off to protect power supply.

elif #tools[{state.nextTool}].extruders > 0 ; If this tool is an extruder
    M451 ; Switch to FFF Mode

else                                        ;defaults to probe
    M453 ; Switch to CNC mode
    M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe    

if state.previousTool != -1 ; If we changed to this tool from another tool...
    G90 ; Set to Absolute Positioning
    G1 R2 X0 Y0 F6000 ; Return to X and Y coordinates stored in restore point 2 at a speed of 6000 mm/min
    if state.restorePoints[2].coords[2] + 2 <= {move.axes[2].max - global.TClength}
        G1 R2 Z2 ; Return to 2mm above Z coordinate stored in restore point 2
    else
        G1 Z{move.axes[2].max - global.TClength} F10000 ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min
