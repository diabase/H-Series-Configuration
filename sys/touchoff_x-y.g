; touchoff_x-y.g
; Called to use the touch off plate to find the XY origin of the currently selected tool
; Written by Diabase Engineering
; Last Updated: May 02, 2022

M118 S{"Begin touchoff_x-y.g"} L3

var xAxisIndex = -1
while iterations < #move.axes
    if move.axes[iterations].letter == "X"
        set var.xAxisIndex = iterations
        break

var yAxisIndex = -1
while iterations < #move.axes
    if move.axes[iterations].letter == "Y"
        set var.yAxisIndex = iterations
        break

var startXOffset = tools[state.currentTool].offsets[var.xAxisIndex]
var startYOffset = tools[state.currentTool].offsets[var.yAxisIndex]

M118 S{"touchoff_x-y.g: Beginning X,Y offsets for T" ^ state.currentTool ^ " are " ^ var.startXOffset ^ "," ^ var.startYOffset} L3

M291 P"Bed will now move. Is tool inside cup?" R"Crash Check" S3

G10 P{state.currentTool} X0 Y0

M561                                                                                                                    ; Cancel any bed-plane fitting

M574 X1 Y1 S2                                                                                                           ; configured to use Touchoff plate (Probe P1 below)

; var local.probeTipRadius = 3 ; in mm

M400
G60 S1                                                                                                                  ; Save start position to slot 1

if {tools[state.currentTool].spindle != -1}                                                                           ; If this tool has spindles... 
    if {#tools[state.currentTool].extruders == 0}                                                                     ; ... but no extruders, we assume it's a spindle.
        if {spindles[tools[state.currentTool].spindle].state != "reverse"}                                            ; If it's not already turning in reverse...
            M291 P"Spindle will now rotate counter-clockwise. Is it safe to begin?" R"Spindle Back Check" S3            ; ... alert the user ...
            M98 P"spindle_back.g"                                                                                       ; ... and turn the spindle in reverse.

; Probe in X direction ("coarse")
if sensors.probes[1].value[0] == 1000
    M291 P{"Error: Touch off plate already triggered. Check touch off plate and try again."} R"TO Plate Already Triggered" S2
    if {tools[state.currentTool].spindle != -1}                                                                           ; If this tool has spindles... 
        if {#tools[state.currentTool].extruders == 0}                                                                     ; ... but no extruders, we assume it's a spindle.
            M5                                                                                                              ; Turn spindle off
    abort
G38.2 X{move.axes[var.xAxisIndex].userPosition + 8} P1                                                                               ; Adjust the + n amount to the travel limit (expected hole diameter is an upper bound)
M400
G60 S2                                                                                                                  ; Save +X position to slot 2
G0 X0 R1 F300                                                                                                           ; Return X to start position (disengage the probe) (slot 1)
M400
if sensors.probes[1].value[0] == 1000
    M291 P{"Error: Touch off plate already triggered. Check touch off plate and try again."} R"TO Plate Already Triggered" S2
    if {tools[state.currentTool].spindle != -1}                                                                           ; If this tool has spindles... 
        if {#tools[state.currentTool].extruders == 0}                                                                     ; ... but no extruders, we assume it's a spindle.
            M5                                                                                                              ; Turn spindle off
    abort
G38.2 X{move.axes[var.xAxisIndex].userPosition - 8} P1                                                                               ; Adjust the - n amount to the travel limit
G53 G0 X{move.axes[var.xAxisIndex].machinePosition + ((state.restorePoints[2].coords[var.xAxisIndex] - move.axes[var.xAxisIndex].machinePosition) / 2.0)}      ; Move to pretty good X-value of hole center

; Probe in Y direction ("fine")
M400
if sensors.probes[1].value[0] == 1000
    M291 P{"Error: Touch off plate already triggered. Check touch off plate and try again."} R"TO Plate Already Triggered" S2
    if {tools[state.currentTool].spindle != -1}                                                                           ; If this tool has spindles... 
        if {#tools[state.currentTool].extruders == 0}                                                                     ; ... but no extruders, we assume it's a spindle.
            M5                                                                                                              ; Turn spindle off
    abort
G38.2 Y{move.axes[var.yAxisIndex].userPosition + 8} P1                                                                               ; Adjust the + n amount to the travel limit
M400
G60 S3                                                                                                                  ; Save +Y position to slot 3
G0 Y0 R1 F300                                                                                                           ; Return Y to start position (disengage the probe) (slot 1)
M400
if sensors.probes[1].value[0] == 1000
    M291 P{"Error: Touch off plate already triggered. Check touch off plate and try again."} R"TO Plate Already Triggered" S2
    if {tools[state.currentTool].spindle != -1}                                                                           ; If this tool has spindles... 
        if {#tools[state.currentTool].extruders == 0}                                                                     ; ... but no extruders, we assume it's a spindle.
            M5                                                                                                              ; Turn spindle off
    abort
G38.2 Y{move.axes[var.yAxisIndex].userPosition - 8} P1                                                                               ; Adjust the - n amount to the travel limit
; M400
; var global.yHoleDiameter = {state.restorePoint[3].coords[var.yAxisIndex] - move.axes[var.yAxisIndex].userPosition + (2.0 * local.probeTipRadius)}
G53 G0 Y{move.axes[var.yAxisIndex].machinePosition + ((state.restorePoints[3].coords[var.yAxisIndex] - move.axes[var.yAxisIndex].machinePosition) / 2.0)} F300 ; Move to very good Y-value of hole center

M400
G60 S1                                                                                                                  ; Save "pretty good X" and "very good Y" position to slot 1
M558 K1 F100
; Probe in X direction ("fine")
M400
if sensors.probes[1].value[0] == 1000
    M291 P{"Error: Touch off plate already triggered. Check touch off plate and try again."} R"TO Plate Already Triggered" S2
    if {tools[state.currentTool].spindle != -1}                                                                           ; If this tool has spindles... 
        if {#tools[state.currentTool].extruders == 0}                                                                     ; ... but no extruders, we assume it's a spindle.
            M5                                                                                                              ; Turn spindle off
    abort
G38.2 X{move.axes[var.xAxisIndex].userPosition + 6} P1                                                                               ; Adjust the + n amount to the travel limit
M400
G60 S4                                                                                                                  ; Save +X position to slot 4
G0 X0 R1 F300                                                                                                           ; Return X to pretty good center position (disengage the probe) (slot 1)
M400
if sensors.probes[1].value[0] == 1000
    M291 P{"Error: Touch off plate already triggered. Check touch off plate and try again."} R"TO Plate Already Triggered" S2
    if {tools[state.currentTool].spindle != -1}                                                                           ; If this tool has spindles... 
        if {#tools[state.currentTool].extruders == 0}                                                                     ; ... but no extruders, we assume it's a spindle.
            M5                                                                                                              ; Turn spindle off
    abort
G38.2 X{move.axes[var.xAxisIndex].userPosition - 6} P1                                                                               ; Adjust the - n amount to the travel limit
; M400
; var global.xHoleDiameter = {state.restorePoint[4] - move.axes[var.xAxisIndex].userPosition + (2.0 * local.probeTipRadius)}
; var global.averageHoleDiameter = {(global.xHoleDiameter + global.yHoleDiameter) / 2.0}
; var global.diameterDifference = {global.xHoleDiameter - global.yHoleDiameter}
G53 G0 X{move.axes[var.xAxisIndex].machinePosition + ((state.restorePoints[4].coords[var.xAxisIndex] - move.axes[var.xAxisIndex].machinePosition) / 2.0)} F300 ; Move to very good X-value of hole center
M558 K1 F200

if {tools[state.currentTool].spindle != -1}                                                                           ; If this tool has spindles... 
    if {#tools[state.currentTool].extruders == 0}                                                                     ; ... but no extruders, we assume it's a spindle.
        M5                                                                                                              ; Turn spindle off

M574 X1 S1 P{global.xSwitchPin}
M574 Y1 S1 P{global.ySwitchPin}

M118 S{"touchoff_x-y.g: Ending X,Y position for T" ^ state.currentTool ^ " is " ^ move.axes[var.xAxisIndex].userPosition ^ "," ^ move.axes[var.yAxisIndex].userPosition} L3

M118 S{"End touchoff_x-y.g"} L3
