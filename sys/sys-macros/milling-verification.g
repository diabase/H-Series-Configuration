; milling-verification.g
; Used to verify stock position for first milling job
; Written by Diabase Engineering
; Last Updated: April 21, 2022

M118 S{"Begin milling-verification.g"} L1

var fixedJawXOffset = 0
var fixedJawYOffset = 36
var fixedJawZOffset = 3.27

; Find Axis Indicies
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
var zAxisIndex = -1
while iterations < #move.axes
    if move.axes[iterations].letter == "Z"
        set var.zAxisIndex = iterations
        break

; Confirm with User and Home All
M291 P"This job will assist you in confirming the stock position for the milling verification job." R"milling-verification.g" S2
M291 P"Are you ready to home all axes?" R"Home All" S3
M98 P"homeall.g"

; Manually Confirm Rough Vise Position
M291 P"Tool 24 will now be retrieved from the tool changer." R"T24" S3
T24
G56
M291 P"The tip of the filament will now move to the back left corner of the vise jaw." R"T24" S3
G1 X{var.fixedJawXOffset} Y{var.fixedJawYOffset} Z{var.fixedJawZOffset} F10000

M400
M291 P"When pulled straight, is the tip of the filament within 5mm of the corner of the vise jaw?" R"Filament at Corner?" S3

; Probing
M291 P"The machine will now probe the vise corner. Please keep clear of the build enclosure." R"Probe vise?" S3

; Probe Z
G1 Z{var.fixedJawZOffset + 50} F10000
T{global.zProbeToolNum}
G1 X{var.fixedJawXOffset + 10} Y{var.fixedJawYOffset - 10} F10000
G1 Z{var.fixedJawZOffset + 10} F10000

M400
; M291 P"Is the probe tip over the vise?" R"Crash Check" S3
; M291 P"Ready to probe straight down?" R"Crash Check" S3
if sensors.probes[0].value[0] == 1000
    M291 P{"Error: Probe already triggered. Check probe and try again."} R"Probe Already Triggered" S2
    abort
G38.2 Z{move.axes[var.zAxisIndex].userPosition - 20}
if result != 0
    M291 P"There was an error while probing. Check probe and try again." R"Probing Error" S3
    abort

M400
var zVariance = {move.axes[var.zAxisIndex].userPosition - var.fixedJawZOffset}
M118 S{"Probed z-axis variance in milling-verification.g is " ^ var.zVariance} L1
if {abs(var.zVariance)} > 0.1
    M291 P"The measured z-axis variance ("^var.zVariance^") is greater than expected. Stop and contact Diabase Support." R"Z Variance Error" S3
    abort

; Probe X
G1 Z{var.fixedJawZOffset + 20} F10000
G1 X{var.fixedJawXOffset - 10} F10000
G1 Z{var.fixedJawZOffset - 5} F10000

M400
; M291 P"Is the probe tip left of the vise?" R"Crash Check" S3
; M291 P"Ready to probe to the right?" R"Crash Check" S3
if sensors.probes[0].value[0] == 1000
    M291 P{"Error: Probe already triggered. Check probe and try again."} R"Probe Already Triggered" S2
    abort
G38.2 X{move.axes[var.xAxisIndex].userPosition + 20}
if result != 0
    M291 P"There was an error while probing. Check probe and try again." R"Probing Error" S3
    abort

M400
var xVariance = {{move.axes[var.xAxisIndex].userPosition+1} - var.fixedJawXOffset}
M118 S{"Probed x-axis variance in milling-verification.g is " ^ var.xVariance} L1
if {abs(var.xVariance)} > 0.1
    M291 P"The measured x-axis variance ("^var.xVariance^") is greater than expected. Stop and contact Diabase Support." R"X Variance Error" S3
    abort

; Probe Y
G1 X{var.fixedJawXOffset - 5} F10000
G1 Y{var.fixedJawYOffset + 6} F10000
G1 X{var.fixedJawXOffset + 10} F10000

M400
; M291 P"Is the probe tip behind the vise?" R"Crash Check" S3
; M291 P"Ready to probe toward the front?" R"Crash Check" S3
if sensors.probes[0].value[0] == 1000
    M291 P{"Error: Probe already triggered. Check probe and try again."} R"Probe Already Triggered" S2
    abort
G38.2 Y{move.axes[var.yAxisIndex].userPosition - 8}
if result != 0
    M291 P"There was an error while probing. Check probe and try again." R"Probing Error" S3
    abort

M400
var yVariance = {{move.axes[var.yAxisIndex].userPosition - 1} - var.fixedJawYOffset}
M118 S{"Probed y-axis variance in milling-verification.g is " ^ var.yVariance} L1
if {abs(var.yVariance)} > 0.1
    M291 P"The measured y-axis variance ("^var.yVariance^") is greater than expected. Stop and contact Diabase Support." R"Y Variance Error" S3
    abort

G1 Y{var.fixedJawYOffset + 6} F10000
G1 Z{var.fixedJawZOffset + 100} F10000
G1 X0 Y0 F10000

M400
M291 P"The vise is positioned correctly! You're ready to begin the milling job." R"Success!" S3

M118 S{"End milling-verification.g"} L1
