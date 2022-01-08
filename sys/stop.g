; stop.g
; If the axes are homed and if a print is being cancelled (M25), cancel.g is called when M0 is sent. 
; If M0 is sent at any other time, stop.g is called.
; Written by Diabase Engineering
; Last Updated: January 07, 2022

M118 S{"Debug: Begin stop.g"} L3

G60 S0                                                              ; Save current tool information

G54                                                                 ; Assert normal WCS
G90                                                                 ; Set to Absolute Positioning
G1 Z{move.axes[2].max + global.maxOffset} F10000                    ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min
M400                                                                ; Wait for current moves to finish

if state.machineMode="CNC"
    M5                                                              ; Stop the spindle of the current tool (if any) or stop all spindles if the current tool has no spindles or no tool is selected

; Turn off all extruder heaters
while iterations < #tools                                           ; Loop through all tools...
    if tools[iterations] != null                                    ; if it's defined...
        if tools[iterations].heaters != null                        ; and has heaters...
            M568 P{iterations} R0 S0 A0                             ; set the active and standby temperatures to 0C and turn them off.

if heat.heaters[{global.bedHeaterNum}] != null                      ; If we have defined a bed heater...
    if {heat.heaters[{global.bedHeaterNum}].current != -273.15}     ; ... and it's connected... 
        if {heat.heaters[{global.bedHeaterNum}].state != "fault"}   ; ... and it's not in a fault state...
            M144 S0                                                 ; Set bed to standby

M220 S100                                                           ; Reset speed factor override to 100%
while iterations < #move.extruders                                  ; Loop over all extruders and ...
    M221 S100 D{iterations}                                         ; ... reset extrude factor override to 100%

M118 S{"Debug: End stop.g"} L3
