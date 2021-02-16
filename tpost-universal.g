; Universal tpost macro

if #tools[{state.nextTool}].name == 5 ; If this tool is a probe...
    M453 ; Switch to CNC mode
    M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe

elif #tools[{state.nextTool}].name == 7 ; If this tool is called "No Tool"...
    M451 ; Switch to FFF Mode

elif #tools[{state.nextTool}].name == 8 ; If this tool is an extruder
    M451 ; Switch to FFF Mode

elif #tools[{state.nextTool}].name == 9 ; If this tool is a spindle...
    M453 ; Switch to CNC mode
    if heat.heaters[0] != null ; If we have defined a bed heater...
        if heat.heaters[0].state != "fault" ; ...and it's not in a fault state...
            M140 H0 S-273.15 ; ...turn it off to protect power supply.

if state.previousTool != -1 ; If we changed to this tool from another tool...
    G90 ; Set to Absolute Positioning
    G1 R2 X0 Y0 F6000 ; Return to X and Y coordinates stored in restore point 2 at a speed of 6000 mm/min
    if state.restorePoints[2].coords[2] + 2 <= {move.axes[2].max + min(tools[2].offsets[2], tools[3].offsets[2], tools[4].offsets[2], tools[5].offsets[2])}
        G1 R2 Z2 ; Return to 2mm above Z coordinate stored in restore point 2
    else
        G1 Z{move.axes[2].max + min(tools[2].offsets[2], tools[3].offsets[2], tools[4].offsets[2], tools[5].offsets[2])} F10000 ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min
