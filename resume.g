; resume.g
; Called when a paused job is resumed
; Written by Diabase Engineering
; Last Updated: December 13, 2021

M118 S{"Debug: Begin resume.g"} L3

if {global.machineModel} == "H5B"
        if sensors.gpIn[{global.airPressureInNum}] == 0
            M291 P"Warning: Incoming air pressure low. Resolve before continuing." R"Warning" S3            ; Display a blocking warning with no timeout.
            abort

T{state.restorePoints[1].toolNumber} ; Select the tool that was active when the job was paused.

if state.machineMode == "FFF" ; If we're in FFF mode...
    if heat.heaters[{global.bedHeaterNum}] != null ; ...and we have defined a bed heater...
        if heat.heaters[{global.bedHeaterNum}].state != "fault"
            if heat.heaters[{global.bedHeaterNum}].current != -273.15 ; ...and it's not in a fault state...
                M144 S1 ; Set bed heater to active.

if {state.currentTool} != -1 ; If we have a tool selected...
    if {tools[{state.currentTool}].spindle != -1}           ; ... and it has spindles
        if {#tools[{state.currentTool}].extruders == 0}        ; ... but no extruders
            M3 P{tools[{state.currentTool}].spindle}        ; ...start spindle

if state.machineMode == "FFF" ; If we're in FFF mode...
    if heat.heaters[{global.bedHeaterNum}] != null ; ...and we have defined a bed heater...
        if heat.heaters[{global.bedHeaterNum}].state == "active" ; ...and it's active...
            M116 H{global.bedHeaterNum} S5 ; Wait until bed heater reaches +/-5C of target temperature

if state.machineMode == "FFF"
    if {state.currentTool} == 1
        M98 P"tprime1.g" ; Call tprime1.g
    elif {state.currentTool} == 2
        M98 P"tprime2.g" ; Call tprime2.g
    elif {state.currentTool} == 3
        M98 P"tprime3.g" ; Call tprime3.g
    elif {state.currentTool} == 4
        M98 P"tprime4.g" ; Call tprime4.g
    elif {state.currentTool} == 5
        M98 P"tprime5.g" ; Call tprime5.g
    M83 ; Set extruder to relative mode
    G1 E{tools[{state.currentTool}].retraction.length} F{tools[{state.currentTool}].retraction.speed*60} ; Anti-Ooze Makeup - Extrude Filament at After Prime Retraction Amount and Feedrate
    G4 P20 ; Dwell for 20 ms


G1 R1 Y0 F3000 ; Return to Y position stored in slot 1 at 3000 mm/min
G1 R1 Z0 F3000 ; Return to Z position stored in slot 1 at 3000 mm/min

M400 ; Wait for current moves to finish

M118 S{"Debug: End resume.g"} L3
