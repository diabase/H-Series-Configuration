; unrotary.g
; Called to return machine to normal mode from rotary printing mode
; Written by Diabase Engineering
; Last Updated: August 3, 2021

M118 S"Info: Begin unrotary.g" L2

; Drive settings
M584 A2.0:2.1 R1                                            ; Set driver mapping
M584 Y{global.YDrive} R0                                    ; Set driver mapping
M208 A{global.AMin} Y{global.YMin} S1                       ; Set axis minima
M208 A{global.AMax} Y{global.YMax} S0                       ; Set axis maxima
M350 Y16 A16 I1                                             ; Configure microstepping with interpolation
M92  Y320 A53.33                                            ; Set steps per mm
M566 Y300 A1000                                             ; Set maximum instantaneous speed changes (mm/min)
M203 X{global.XMaxSpeed} Y10000 A20000                      ; Set maximum speeds (mm/min)
M201 Y600 A600                                              ; Set accelerations (mm/s^2)
M906 Y2100 A1800 I30                                        ; Set motor currents (mA) and motor idle factor percent
M84  S5                                                     ; Set idle timeout

; Endstops
M574 Y1 P"nil"                                              ; Clear existing Y endstop pin
M574 A1 P"nil"                                              ; Clear existing A endstop pin
G4   P100                                                   ; Wait 100ms
M574 Y1 S1 P{global.YSwitchPin}                             ; Set new pin for A endstop
M574 A1 S1 P{global.ASwitchPin}                             ; Set new pin for Y endstop

; Swap Y- and A-axis offsets
while iterations < #tools                                   ; For each tool...
    if tools[iterations] != null                            ; ... that is defined
        var YOffset = {tools[(iterations)].offsets[1]}      ; Save Y-axis offset in a temporary variable
        G10 P{iterations} Y{tools[(iterations)].offsets[6]} ; Populate the Y-axis offset with the value from the A-axis offset
        G10 P{iterations} A{var.YOffset}                    ; Populate the A-axis offset with the value from the Y-axis offset

; Swap Y- and A-axis positions
var YPosition = {move.axes[1].machinePosition}              ; Save Y-axis position in a temporary variable
G92 Y{move.axes[6].machinePosition}                         ; Define the current position of the A axis as the current position of the Y axis
G92 A{var.YPosition}                                        ; Define the current position of the Y axis as the current position of the A axis

M118 S"Info: End unrotary.g" L2
