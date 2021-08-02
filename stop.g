; stop.g
; If the axes are homed and if a print is being cancelled (M25), cancel.g is called when M0 is sent. 
; If M0 is sent at any other time, stop.g is called.
; Written by Diabase Engineering
; Last Updated: August 2, 2021

M118 S{"Info: Begin stop.g"} L2

G60 S0                                                              ; Save current tool information

G90                                                                 ; Set to Absolute Positioning
G1 Z{move.axes[2].max + global.MaxOffset} F10000                    ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min
M400                                                                ; Wait for current moves to finish

if state.machineMode="CNC"
    M5                                                              ; Stop the spindle of the current tool (if any) or stop all spindles if the current tool has no spindles or no tool is selected

; Turn off all extruder heaters
G10 P1 R0 S0                                                        ; Set Tool 1 active and standby temperatures to 0C
G10 P2 R0 S0                                                        ; Set Tool 2 active and standby temperatures to 0C
G10 P3 R0 S0                                                        ; Set Tool 3 active and standby temperatures to 0C
G10 P4 R0 S0                                                        ; Set Tool 4 active and standby temperatures to 0C
G10 P5 R0 S0                                                        ; Set Tool 5 active and standby temperatures to 0C

; Put all the tools into standby mode and re-select the last used tool
T1 P0
T2 P0
T3 P0
T4 P0
T5 P0
T10 P0
T{state.restorePoints[0].toolNumber} P0

if heat.heaters[{global.BedHeaterNum}] != null                      ; If we have defined a bed heater...
    if {heat.heaters[{global.BedHeaterNum}].current != -273.15}     ; ... and it's connected... 
        if {heat.heaters[{global.BedHeaterNum}].state != "fault"}   ; ... and it's not in a fault state...
            M144 S0                                                 ; Set bed to standby

M118 S{"Info: End stop.g"} L2
