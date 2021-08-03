; rotaryprint.g
; Called to switch machine into rotary printing mode
; Written by Diabase Engineering
; Last Updated: August 3, 2021

M118 S"Info: Begin rotaryprint.g" L2

; Drive settings
M584 Y2.0:2.1 R1                                            ; Set driver mapping
M584 A{global.YDrive} R0                                    ; Set driver mapping
M208 Y{global.AMin} A{global.YMin} S1                       ; Set axis minima
M208 Y{global.AMax} A{global.YMax} S0                       ; Set axis maxima
M350 Y16 A16 I1                                             ; Configure microstepping with interpolation
M92  A320 Y53.33                                            ; Set steps per mm
M566 A600 Y1000                                             ; Set maximum instantaneous speed changes (mm/min)
M203 X{global.XMaxSpeedRotary} Y20000 A10000                ; Set maximum speeds (mm/min)
M201 Y1400 A900                                             ; Set accelerations (mm/s^2)
M906 Y2000 A2000 I30                                        ; Set motor currents (mA) and motor idle factor percent
M84  S5                                                     ; Set idle timeout

; Endstops
M574 Y1 P"nil"                                              ; Clear existing Y endstop pin
M574 A1 P"nil"                                              ; Clear existing A endstop pin
G4   P100                                                   ; Wait 100ms
M574 A1 S1 P{global.YSwitchPin}                             ; Set new pin for A endstop
M574 Y1 S1 P{global.ASwitchPin}                             ; Set new pin for Y endstop

; Swap Y- and A-axis offsets
while iterations < #tools                                   ; For each tool...
    while tools[iterations] != null                         ; ... that is defined
        var YOffset = {tools[(iterations)].offsets[1]}      ; Save Y-axis offset in a temporary variable
        G10 P{iterations} Y{tools[(iterations)].offsets[6]} ; Populate the Y-axis offset with the value from the A-axis offset
        G10 P{iterations} A{var.YOffset}                    ; Populate the A-axis offset with the value from the Y-axis offset

; Swap Y- and A-axis positions
var YPosition = {move.axes[1].machinePosition}              ; Save Y-axis position in a temporary variable
G92 Y{move.axes[6].machinePosition}                         ; Define the current position of the A axis as the current position of the Y axis
G92 A{var.YPosition}                                        ; Define the current position of the Y axis as the current position of the A axis

M118 S"Info: End rotaryprint.g" L2
