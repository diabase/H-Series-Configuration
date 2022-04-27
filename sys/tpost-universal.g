; tpost-universal.g
; Called when a tool is selected
; Written by Diabase Engineering
; state.previousTool is the just-freed tool 
; state.currentTool is the upcoming tool
; state.nextTool is the upcoming tool
; Last Updated: April 26, 2022

M118 S{"Begin tpost-universal.g"} L3

if global.tFreeComplete == 0
    M118 S{"tpost-universal.g: tfree didn't complete the last time. Aborting tpost-universal.g."} L1
    abort

if global.tPreComplete == 0
    M118 S{"tpost-universal.g: tpre didn't finish the last time. Aborting tpost-universal.g."} L1
    abort

if global.tPostComplete == 0
    M118 S{"tpost-universal.g: tpost didn't finish the last time. Resetting status flag and attempting it again."} L1
set global.tPostComplete = 0


if {tools[{state.nextTool}].spindle == -1}                                                                                                      ; If this tool has no spindles...
    if {#tools[{state.nextTool}].extruders == 0}                                                                                                    ; ... or extruders, we assume it's a probe
        M453                                                                                                                                            ; Switch to CNC mode
        M401 P0                                                                                                                                         ; Deploy Probe
        M574 Z1 S2                                                                                                                                      ; Set Z endstop position to low end and configure as Z probe

    elif {#tools[{state.nextTool}].extruders > 0}                                                                                                   ; ... but has extruders, we assume it's an extruder
        M451                                                                                                                                            ; Switch to FFF Mode
        while iterations < #tools[{state.nextTool}].heaters                                                                                             ; Loop over all heaters for this tool ...
            if heat.heaters[{tools[{state.nextTool}].heaters[iterations]}].state == "fault"                                                                 ; ... and if any of them are in a fault state...
                if {state.status} == "processing"                                                                                                               ; ... and we're in the middle of a job...
                    M25                                                                                                                                             ; ... pause the job.
                M291 P{tools[{state.nextTool}].name ^ " has experienced a heater fault. Resolve before continuing."} R"Heater Fault" S1 T-1                     ; Display alert message

else                                                                                                                                            ; If this tool has spindles...
    if {#tools[{state.nextTool}].extruders == 0}                                                                                                    ; ... but no extruders, we assume it's a spindle.
        M453                                                                                                                                            ; Switch to CNC mode
        if heat.heaters[{global.bedHeaterNum}] != null                                                                                                  ; If we have defined a bed heater...
            if {heat.heaters[{global.bedHeaterNum}].state != "fault"}                                                                                       ; ... it's not currently in a fault state...
                if {heat.heaters[{global.bedHeaterNum}].current != -273.15}                                                                                     ; ... and it's not physically disconnected
                    M140 H{global.bedHeaterNum} S-273.15                                                                                                            ; ... turn it off to protect power supply.

if state.previousTool != -1                                                                                                                     ; If we changed to this tool from another tool...
    G90                                                                                                                                             ; Set to Absolute Positioning
    M118 S{"tpost-universal.g: Moving to X and Y coordinates stored in restore point 2"} L3                                                         ; Log a message to the debug channel
    G1 R2 X0 Y0 F10000                                                                                                                              ; Return to X and Y coordinates stored in restore point 2 at a speed of 10000 mm/min
    M118 S{"tpost-universal.g: Finished move to X and Y coordinates stored in restore point 2"} L3                                                         ; Log a message to the debug channel

if {global.machineModel} == "H5B"
    M582 T{global.airPressureLowTrigger}                                                                                                            ; Check incoming air pressure

    ; Restore movement compensation active at beginning of tool change
    if global.moveCompStatus == 1
        M118 S{"tpost-universal.g: Re-enabling mesh compensation."} L3
        G29 S1 P{global.moveCompFile}
        set global.moveCompStatus = -1
    elif global.moveCompStatus == 0
        set global.moveCompStatus = -1

set global.tPostComplete = 1

M118 S{"End tpost-universal.g"} L3
