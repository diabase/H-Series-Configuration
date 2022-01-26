; bed_rotary.g
; Called to probe a surface for rotary printing 
; Written by Diabase Engineering
; Last Updated: January 26, 2022

M118 S"Info: Begin bed_rotary.g" L2

M291 P"Edit bed_rotary.g AND USE ROTARY AXES TAB to define mesh area for rotary axis" R"First open" S3

var xAxisIndex = -1
while iterations < #move.axes
    if move.axes[iterations].letter == "X"
        set var.xAxisIndex = iterations
        break

var aAxisIndex = -1
while iterations < #move.axes
    if move.axes[iterations].letter == "A"
        set var.aAxisIndex = iterations
        break

T{global.zProbeToolNum}                                                                                                                         ; Select Probe
M561                                                                                                                                            ; Set Identity Transform (Clears any existing bed-plane fitting)

G1 X0 A-5 Z3 F8000                                                                                                                              ; Move to starting position
G30                                                                                                                                             ; Probe the bed at the current XY position. When the probe is triggered, set the Z coordinate to the probe trigger height.
M557 X{move.axes[var.xAxisIndex].min}:{move.axes[var.xAxisIndex].max} A{move.axes[var.aAxisIndex].min}:{move.axes[var.aAxisIndex].max} P3:20    ; Define a 3x20 probing grid bounded for X between -150 and 150 and A between -360 and 360
;M203 X{global.xMaxSpeed}                                                                                                                        ; Set maximum speeds (mm/min)
G29                                                                                                                                             ; Probe the bed using the grid defined by M557, save the height map in /sys/heightmap.csv, and activate bed compensation
;M203 X{global.xMaxSpeedRotary}                                                                                                                  ; Set maximum speeds (mm/min)

M118 S"Info: End bed_rotary.g" L2
