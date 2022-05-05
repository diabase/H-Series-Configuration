; measure_vise_position.g
; Used to populate values for verify_vise_position.g
; Written by Diabase Engineering
; Last Updated: May 05, 2022

M118 S{"Begin measure_vise_position.g"} L1

var fixedJawXOffset = 0
var fixedJawYOffset = 36
var fixedJawZOffset = 3.27
var maxJawVariance = 0.1
var stockXOffset = -1.299
var stockYOffset = 2.150
var stockZOffset = 16.982
var maxStockVariance = 0.5

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

; Disable movement compensation
if move.compensation.type == "mesh"
    M118 S{"measure_vise_position.g: Move compensation type is mesh"} L1
    M118 S{"measure_vise_position.g: Disabling movement compensation"} L1
    G29 S2

; Confirm with User and Home All
M291 P{"This job will assist you in finding values for measure_vise_position.g"} R"measure_vise_position.g" S2
M291 P{"Did you probe and set the G56 the origin?"} R"G56 Calibrated?" S3
M291 P{"Are the dovetail bed, vise, and 2nd op stock in place?"} R"2nd Op Stock" S3
M291 P{"Are you ready for the machine to move?"} R"Crash Check" S3
M98 P"homeall.g"

; Manually Confirm Rough Vise Position
T24
G56
G1 X{var.fixedJawXOffset} Y{var.fixedJawYOffset} Z{var.fixedJawZOffset} F10000

M400
M291 P{"When pulled straight, is the tip of the filament within 5mm of the corner of the vise jaw?"} R"Filament at Corner?" S3

; Probe Vise
M291 P{"The machine will now probe the vise corner. Please keep clear of the build enclosure."} R"Probe vise?" S3

; Probe Vise Z
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
    M291 P{"There was an error while probing. Check probe and try again."} R"Probing Error" S3
    abort

M400
var zVariance = {move.axes[var.zAxisIndex].userPosition - var.fixedJawZOffset}
M118 S{"measure_vise_position.g: Probed z-axis vise variance is " ^ var.zVariance} L1
M118 S{"measure_vise_position.g: Expected vise Z offset of "^{" ^ var.fixedJawZOffset ^" and measured "^ {var.zVariance + var.fixedJawZOffset} L1
if {abs(var.zVariance)} > var.maxJawVariance
    M291 P{"Warning: Z-axis vise variance ("^var.zVariance^") is greater than "^ var.maxJawVariance} R"Z Variance Error" S3

; Probe Vise X
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
    M291 P{"There was an error while probing. Check probe and try again."} R"Probing Error" S3
    abort

M400
var xVariance = {{move.axes[var.xAxisIndex].userPosition+1} - var.fixedJawXOffset}
M118 S{"measure_vise_position.g: Probed x-axis vise variance is " ^ var.xVariance} L1
M118 S{"measure_vise_position.g: Expected a vise X offset of "^{" ^ var.fixedJawXOffset ^" and measured "^ {var.xVariance + var.fixedJawXOffset} L1
if {abs(var.xVariance)} > var.maxJawVariance
    M291 P{"Warning: X-axis vise variance ("^var.xVariance^") is greater than "^ var.maxJawVariance} R"X Variance Error" S3

; Probe Vise Y
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
    M291 P{"There was an error while probing. Check probe and try again."} R"Probing Error" S3
    abort

M400
var yVariance = {{move.axes[var.yAxisIndex].userPosition - 1} - var.fixedJawYOffset}
M118 S{"measure_vise_position.g: Probed y-axis vise variance is " ^ var.yVariance} L1
M118 S{"measure_vise_position.g: Expected a vise Y offset of "^{" ^ var.fixedJawYOffset ^" and measured "^ {var.yVariance + var.fixedJawYOffset} L1
if {abs(var.yVariance)} > var.maxJawVariance
    M291 P{"Warning: Y-axis vise variance ("^var.yVariance^") is greater than "^ var.maxJawVariance} R"Y Variance Error" S3
    abort

G1 Y{var.fixedJawYOffset + 6} F10000
G1 Z{var.fixedJawZOffset + 50} F10000

; Probe Stock

; Probe Stock Z
G1 X2 Y-2 F10000
G1 Z{var.stockZOffset + 10} F10000
M400
if sensors.probes[0].value[0] == 1000
    M291 P{"Error: Probe already triggered. Check probe and try again."} R"Probe Already Triggered" S2
    abort
G38.2 Z{move.axes[var.zAxisIndex].userPosition - 20}
if result != 0
    M291 P{"There was an error while probing. Check probe and try again."} R"Probing Error" S3
    abort

M400
set var.zVariance = {move.axes[var.zAxisIndex].userPosition - var.stockZOffset}
M118 S{"measure_vise_position.g: Probed z-axis stock variance is " ^ var.zVariance} L1
M118 S{"measure_vise_position.g: Expected a stock Z offset of "^{" ^ var.stockZOffset ^" and measured "^ {var.zVariance + var.stockZOffset} L1
if {abs(var.zVariance)} > var.maxStockVariance
    M291 P{"Warning: Z-axis stock variance ("^var.zVariance^") is greater than "^ var.maxStockVariance} R"Z Variance Error" S3

; Probe Stock X
G1 Z{var.stockZOffset + 20} F10000
G1 X{var.stockXOffset - 10} F10000
G1 Z{var.stockZOffset - 2} F10000

M400
if sensors.probes[0].value[0] == 1000
    M291 P{"Error: Probe already triggered. Check probe and try again."} R"Probe Already Triggered" S2
    abort
G38.2 X{move.axes[var.xAxisIndex].userPosition + 10}
if result != 0
    M291 P{"There was an error while probing. Check probe and try again."} R"Probing Error" S3
    abort

M400
set var.xVariance = {{move.axes[var.xAxisIndex].userPosition+1} - var.stockXOffset}
M118 S{"measure_vise_position.g: Probed x-axis stock variance is " ^ var.xVariance} L1
M118 S{"measure_vise_position.g: Expected a stock X offset of "^{" ^ var.stockXOffset ^" and measured "^ {var.xVariance + var.stockXOffset} L1
if {abs(var.xVariance)} > var.maxStockVariance
    M291 P{"Warning: X-axis stock variance ("^var.xVariance^") is greater than "^ var.maxStockVariance} R"X Variance Error" S3

; Probe Stock Y
G1 X{var.stockXOffset - 5} F10000
G1 Y{var.stockYOffset + 5} F10000
G1 X2 F10000

M400
if sensors.probes[0].value[0] == 1000
    M291 P{"Error: Probe already triggered. Check probe and try again."} R"Probe Already Triggered" S2
    abort
G38.2 Y{move.axes[var.yAxisIndex].userPosition - 10}
if result != 0
    M291 P{"There was an error while probing. Check probe and try again."} R"Probing Error" S3
    abort

M400
set var.yVariance = {{move.axes[var.yAxisIndex].userPosition - 1} - var.stockYOffset}
M118 S{"measure_vise_position.g: Probed y-axis stock variance is " ^ var.yVariance} L1
M118 S{"measure_vise_position.g: Expected a stock Y offset of "^{" ^ var.stockYOffset ^" and measured "^ {var.yVariance + var.stockYOffset} L1
if {abs(var.yVariance)} > var.maxJawVariance
    M291 P{"Warning: Y-axis stock variance ("^var.yVariance^") is greater than "^ var.maxStockVariance} R"Y Variance Error" S3

G1 Z{var.stockZOffset + 100} F10000
G1 X0 Y0 F10000

M400

M118 S{"End milling-verification.g"} L1
