; resume.g
; Called when a paused job is resumed
; Written by Diabase Engineering
; Last Updated: July 22, 2021

M118 S{"Info: Begin resume.g"} L2

T{state.restorePoints[1].toolNumber} ; Select the tool that was active when the job was paused.

if state.machineMode == "FFF" ; If we're in FFF mode...
    if heat.heaters[{global.BedHeaterNum}] != null ; ...and we have defined a bed heater...
        if {heat.heaters[{global.BedHeaterNum}].state != "fault"  && heat.heaters[{global.BedHeaterNum}].current != -273.15} ; ...and it's not in a fault state...
            M144 S1 ; Set bed heater to active.

if {state.currentTool} != -1 ; If we have a tool selected...
    if {tools[{state.currentTool}].spindle != -1}           ; ... and it has spindles
        if {#tools[{state.currentTool}].extruders == 0}        ; ... but no extruders
            M3 P{tools[{state.currentTool}].spindle}        ; ...start spindle

if state.machineMode == "FFF" ; If we're in FFF mode...
    if heat.heaters[{global.BedHeaterNum}] != null ; ...and we have defined a bed heater...
        if heat.heaters[{global.BedHeaterNum}].state == "active" ; ...and it's active...
            M116 H0 S5 ; Wait until Heater 0 (bed) reaches +/-5C of target temperature

M116 P{state.currentTool} ; Wait until current tool reaches target temperature

G1 R1 Y0 F3000 ; Return to Y position stored in slot 1 at 3000 mm/min
G1 R1 Z0 F3000 ; Return to Z position stored in slot 1 at 3000 mm/min

if state.machineMode == "FFF"
    M83 ; Set extruder to relative mode
    G1 E10 F6000 ; Extrude the retracted 10mm of filament at 6000 mm/min

M400 ; Wait for current moves to finish

M118 S{"Info: End resume.g"} L2
