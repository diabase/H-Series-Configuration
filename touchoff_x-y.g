; touchoff_x-y.g
; Called to use the touch off plate to find the XY origin of the currently selected tool
; Written by Diabase Engineering
; Last Updated: July 20, 2021

M291 P"Bed will now move. Is tool  inside cup?" R"Crash Check" S3

G10 P{state.currentTool} X0 Y0

M561

M574 X1 Y1 S2 ; configured to use Touchoff plate (Probe P1 below)


; var local.probeTipRadius = 3 ; in mm

M400
G60 S1                                     ; Save start position to slot 1

if {{tools[{state.currentTool}].spindle != -1} && {#tools[{state.currentTool}].extruders == 0}}       ; If this tool is a spindle
    M291 P"Spindle will now rotate counter-clockwise. Is it safe to begin?" R"Spindle Back Check" S3
    M98 P"spindle_back.g"

; Probe in X direction ("coarse")
G38.2 X{move.axes[0].userPosition + 8} P1 ; Adjust the + n amount to the travel limit (expected hole diameter is an upper bound)
M400
G60 S2                                     ; Save +X position to slot 2
G0 X0 R1 F300                              ; Return X to start position (disengage the probe) (slot 1)
G38.2 X{move.axes[0].userPosition - 8} P1 ; Ajust the - n amount to the travel limit
G53 G0 X{move.axes[0].machinePosition + ((state.restorePoints[2].coords[0] - move.axes[0].machinePosition) / 2.0)} ; Move to pretty good X-value of hole center

; Probe in Y direction ("fine")
G38.2 Y{move.axes[1].userPosition + 8} P1 ; Adjust the + n amount to the travel limit
M400
G60 S3                                     ; Save +Y position to slot 3
G0 Y0 R1 F300                              ; Return Y to start position (disengage the probe) (slot 1)
G38.2 Y{move.axes[1].userPosition - 8} P1 ; Adjust the - n amount to the travel limit
; M400
; var global.yHoleDiameter = {state.restorePoint[3].coords[1] - move.axes[1].userPosition + (2.0 * local.probeTipRadius)}
G53 G0 Y{move.axes[1].machinePosition + ((state.restorePoints[3].coords[1] - move.axes[1].machinePosition) / 2.0)} F300; Move to very good Y-value of hole center

M400
G60 S1                                     ; Save "pretty good X" and "very good Y" position to slot 1
M558 K1 F100
; Probe in X direction ("fine")
G38.2 X{move.axes[0].userPosition + 6} P1 ; Adjust the + n amount to the travel limit
M400
G60 S4                                     ; Save +X position to slot 4
G0 X0 R1 F300                              ; Return X to pretty good center position (disengage the probe) (slot 1)
G38.2 X{move.axes[0].userPosition - 6} P1 ; Ajust the - n amount to the travel limit
; M400
; var global.xHoleDiameter = {state.restorePoint[4] - move.axes[0].userPosition + (2.0 * local.probeTipRadius)}
; var global.averageHoleDiameter = {(global.xHoleDiameter + global.yHoleDiameter) / 2.0}
; var global.diameterDifference = {global.xHoleDiameter - global.yHoleDiameter}
G53 G0 X{move.axes[0].machinePosition + ((state.restorePoints[4].coords[0] - move.axes[0].machinePosition) / 2.0)} F300; Move to very good X-value of hole center
M558 K1 F200

if {{tools[{state.currentTool}].spindle != -1} && {#tools[{state.currentTool}].extruders == 0}}       ; If this tool is a spindle
    M5  ; Turn spindle off

M574 X1 S1 P{global.XSwitchPin}
M574 Y1 S1 P{global.YSwitchPin}
