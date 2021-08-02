; tcalibrate.g
; Called to locate the center of a cavity using the probe.
; Written by Diabase Engineering
; Last Updated: August 1, 2021

M118 S{"Info: Begin tcalibrate.g"} L2

if {exists(global.diameterProbeHole)}
    if {exists(global.DiameterProbeHole)}
        set global.DiameterProbeHole = global.diameterProbeHole

if state.currentTool != 10
    abort "The probe must be the active tool to perform this action. Please activate the probe and try again."

M291 P"Bed will now move. Is Probe inside cavity?" R"Crash Check" S3

M561 ; Identity transform

M574 X1 Y1 S2; Use the probe as X and Y end stops.


; var local.probeTipRadius = 3 ; in mm

M400
G60 S1                                     ; Save start position to slot 1


; Probe in X direction ("coarse")
M558 K0 F150
G38.2 X{move.axes[0].userPosition + global.DiameterProbeHole/2} P0 ; Adjust the + n amount to the travel limit (expected hole diameter is an upper bound)
M400
G60 S2                                     ; Save +X position to slot 2
G0 X0 R1 F300                              ; Return X to start position (disengage the probe) (slot 1)
G38.2 X{move.axes[0].userPosition - global.DiameterProbeHole/2} P0 ; Ajust the - n amount to the travel limit
G53 G0 X{move.axes[0].machinePosition + ((state.restorePoints[2].coords[0] - move.axes[0].machinePosition) / 2.0)} ; Move to pretty good X-value of hole center

; Probe in Y direction ("fine")
G38.2 Y{move.axes[1].userPosition + global.DiameterProbeHole/2} P0 ; Adjust the + n amount to the travel limit
M400
G60 S3                                     ; Save +Y position to slot 3
G0 Y0 R1 F300                              ; Return Y to start position (disengage the probe) (slot 1)
G38.2 Y{move.axes[1].userPosition - global.DiameterProbeHole/2} P0 ; Adjust the - n amount to the travel limit
; M400
; var global.yHoleDiameter = {state.restorePoint[3].coords[1] - move.axes[1].userPosition + (2.0 * local.probeTipRadius)}
G53 G0 Y{move.axes[1].machinePosition + ((state.restorePoints[3].coords[1] - move.axes[1].machinePosition) / 2.0)} F300; Move to very good Y-value of hole center

M400
G60 S1                                     ; Save "pretty good X" and "very good Y" position to slot 1
M558 K0 F100
; Probe in X direction ("fine")
G38.2 X{move.axes[0].userPosition + global.DiameterProbeHole/2} P0 ; Adjust the + n amount to the travel limit
M400
G60 S4                                     ; Save +X position to slot 4
G0 X0 R1 F300                              ; Return X to pretty good center position (disengage the probe) (slot 1)
G38.2 X{move.axes[0].userPosition - global.DiameterProbeHole/2} P0 ; Ajust the - n amount to the travel limit
; M400
; var global.xHoleDiameter = {state.restorePoint[4] - move.axes[0].userPosition + (2.0 * local.probeTipRadius)}
; var global.averageHoleDiameter = {(global.xHoleDiameter + global.yHoleDiameter) / 2.0}
; var global.diameterDifference = {global.xHoleDiameter - global.yHoleDiameter}
G53 G0 X{move.axes[0].machinePosition + ((state.restorePoints[4].coords[0] - move.axes[0].machinePosition) / 2.0)} F300; Move to very good X-value of hole center
M558 K0 F150

M118 S{"Info: End tcalibrate.g"} L2
