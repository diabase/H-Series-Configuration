; pause.g
; Called when a job is paused.
; Written by Diabase Engineering
; Last Updated: January 26, 2022

M118 S{"Debug: Begin pause.g"} L3

G60 S1                                                              ; Save current tool information

if state.machineMode="FFF"
    M83                                                             ; Set extruder to relative mode
    G1 E{-tools[{state.currentTool}].retraction.length} F{tools[{state.currentTool}].retraction.speed*60} ; Anti-Ooze Retraction - Retract Filament at After Prime Retraction Amount and Feedrate
    G90                                                             ; Set to Absolute Positioning
    G1 Z{move.axes[2].max + global.maxOffset} F10000                ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min
    M400                                                            ; Wait for current moves to finish

if state.machineMode="CNC"
    M5                                                              ; Stop the spindle of the current tool (if any) or stop all spindles if the current tool has no spindles or no tool is selected

; Put all the tools into standby mode and re-select the last used tool
while iterations < #tools
    if tools[iterations] != null
        T{iterations} P0
T{state.restorePoints[1].toolNumber} P0
if {state.currentTool == global.zProbeToolNum}                      ; If this tool is the probe...
    M401 P0                                                         ; ...deploy probe

if heat.heaters[{global.bedHeaterNum}] != null                      ; If we have defined a bed heater...
    if {heat.heaters[{global.bedHeaterNum}].current != -273.15}     ; ... and it's connected... 
        if {heat.heaters[{global.bedHeaterNum}].state != "fault"}   ; ... and it's not in a fault state...
            M144 S0                                                 ; Set bed to standby

M118 S{"Debug: End pause.g"} L3
