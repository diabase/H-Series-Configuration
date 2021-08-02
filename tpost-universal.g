; tpost-universal.g
; Called when a tool is selected
; Written by Diabase Engineering
; Last Updated: July 25, 2021

M118 S{"Info: Begin tpost-universal.g"} L2

if {tools[{state.nextTool}].spindle == -1}                                                                                          ; If this tool has no spindles...
    if {#tools[{state.nextTool}].extruders == 0}                                                                                    ; ... or extruders, we assume it's a probe
        M453                                                                                                                        ; Switch to CNC mode
        M401 P0                                                                                                                     ; Deploy Probe
        M574 Z1 S2                                                                                                                  ; Set Z endstop position to low end and configure as Z probe

    elif {#tools[{state.nextTool}].extruders > 0}                                                                                   ; ... but has extruders, we assume it's an extruder
        M451                                                                                                                        ; Switch to FFF Mode

else                                                                                                                                ; If this tool has spindles...
    if {#tools[{state.nextTool}].extruders == 0}                                                                                    ; ... but no extruders, we assume it's a spindle.
        M453                                                                                                                        ; Switch to CNC mode
        if heat.heaters[{global.BedHeaterNum}] != null                                                                              ; If we have defined a bed heater...
            if {heat.heaters[{global.BedHeaterNum}].state != "fault"}                                                               ; ... it's not currently in a fault state...
                if {heat.heaters[{global.BedHeaterNum}].current != -273.15}                                                         ; ... and it's not physically disconnected
                    M140 H{global.BedHeaterNum} S-273.15                                                                            ; ... turn it off to protect power supply.

if state.previousTool != -1                                                                                                         ; If we changed to this tool from another tool...
    G90                                                                                                                             ; Set to Absolute Positioning
    G1 R2 X0 Y0 F6000                                                                                                               ; Return to X and Y coordinates stored in restore point 2 at a speed of 6000 mm/min
    if state.restorePoints[2].coords[2] + 2 <= {move.axes[2].max + global.MaxOffset}
        G1 R2 Z2                                                                                                                    ; Return to 2mm above Z coordinate stored in restore point 2
    else
        G1 Z{move.axes[2].max + global.MaxOffset} F10000                                                                            ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min

M118 S{"Info: End tpost-universal.g"} L2
