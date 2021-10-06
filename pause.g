; pause.g
; Called when a job is paused.
; Written by Diabase Engineering
; Last Updated: August 6, 2021

M118 S{"Debug: Begin pause.g"} L3

G60 S1                                                              ; Save current tool information

if state.machineMode="FFF"
    M83                                                             ; Set extruder to relative mode
    G1 E-10 F6000                                                   ; Retract 10mm of filament at 6000 mm/min
    G90                                                             ; Set to Absolute Positioning
    G1 Z{move.axes[2].max + global.MaxOffset} F10000                ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min
    M400                                                            ; Wait for current moves to finish

if state.machineMode="CNC"
    M5                                                              ; Stop the spindle of the current tool (if any) or stop all spindles if the current tool has no spindles or no tool is selected

; Put all the tools into standby mode and re-select the last used tool
T1 P0
T2 P0
T3 P0
T4 P0
T5 P0
T10 P0
T{state.restorePoints[1].toolNumber} P0

if heat.heaters[{global.BedHeaterNum}] != null                      ; If we have defined a bed heater...
    if {heat.heaters[{global.BedHeaterNum}].current != -273.15}     ; ... and it's connected... 
        if {heat.heaters[{global.BedHeaterNum}].state != "fault"}   ; ... and it's not in a fault state...
            M144 S0                                                 ; Set bed to standby

M118 S{"Debug: End pause.g"} L3
