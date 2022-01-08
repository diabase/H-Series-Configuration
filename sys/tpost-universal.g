; tpost-universal.g
; Called when a tool is selected
; Written by Diabase Engineering
; state.previousTool is the just-freed tool 
; state.currentTool is the upcoming tool
; state.nextTool is the upcoming tool
; Last Updated: January 07, 2022

M118 S{"Debug: Begin tpost-universal.g"} L3

if {tools[{state.nextTool}].spindle == -1}                                                                                                      ; If this tool has no spindles...
    if {#tools[{state.nextTool}].extruders == 0}                                                                                                ; ... or extruders, we assume it's a probe
        M453                                                                                                                                    ; Switch to CNC mode
        M401 P0                                                                                                                                 ; Deploy Probe
        M574 Z1 S2                                                                                                                              ; Set Z endstop position to low end and configure as Z probe

    elif {#tools[{state.nextTool}].extruders > 0}                                                                                               ; ... but has extruders, we assume it's an extruder
        M451                                                                                                                                    ; Switch to FFF Mode
        while iterations < #tools[{state.nextTool}].heaters                                                                                     ; Loop over all heaters for this tool ...
            if heat.heaters[{tools[{state.nextTool}].heaters[iterations]}].state == "fault"                                                    ; ... and if any of them are in a fault state...
                if {state.status} == "processing"                                                                                               ; ... and we're in the middle of a job...
                    M25                                                                                                                         ; ... pause the job.
                M291 P{tools[{state.nextTool}].name ^ " has experienced a heater fault. Resolve before continuing."} R"Heater Fault" S1 T-1    ; Display alert message

else                                                                                                                                            ; If this tool has spindles...
    if {#tools[{state.nextTool}].extruders == 0}                                                                                                ; ... but no extruders, we assume it's a spindle.
        M453                                                                                                                                    ; Switch to CNC mode
        if heat.heaters[{global.bedHeaterNum}] != null                                                                                          ; If we have defined a bed heater...
            if {heat.heaters[{global.bedHeaterNum}].state != "fault"}                                                                           ; ... it's not currently in a fault state...
                if {heat.heaters[{global.bedHeaterNum}].current != -273.15}                                                                     ; ... and it's not physically disconnected
                    M140 H{global.bedHeaterNum} S-273.15                                                                                        ; ... turn it off to protect power supply.

if state.previousTool != -1                                                                                                                     ; If we changed to this tool from another tool...
    G90                                                                                                                                         ; Set to Absolute Positioning
    M118 S{"Debug: tpost-universal.g: Moving to X and Y coordinates stored in restore point 2"} L3
    G1 R2 X0 Y0 F6000                                                                                                                           ; Return to X and Y coordinates stored in restore point 2 at a speed of 6000 mm/min
    if state.restorePoints[2].coords[2] + 2 <= {move.axes[2].max + global.maxOffset}
        M118 S{"Debug: tpost-universal.g: Moving to 2mm above Z coordinate stored in restore point 2"} L3
        G1 R2 Z2                                                                                                                                ; Return to 2mm above Z coordinate stored in restore point 2
    else
        var currentZWCSOffset = move.axes[2].workplaceOffsets[{move.workplaceNumber}]
        M118 S{"Debug: tpost-universal.g: Moving to Z= ZMax + global.maxOffset - currentZWCSOffset"} L3
        G1 Z{move.axes[2].max + global.maxOffset - var.currentZWCSOffset} F10000                                                                ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min

M582 T{global.airPressureLowTrigger}                                                                                                            ; Check incoming air pressure

M118 S{"Debug: End tpost-universal.g"} L3