; touchoff_Z.g
; Called to use the touch off plate to find the Z origin of the currently selected tool
; Written by Diabase Engineering
; Last Updated: May 02, 2022

M118 S{"Begin touchoff_Z.g"} L3

var zAxisIndex = -1
while iterations < #move.axes
    if move.axes[iterations].letter == "Z"
        set var.zAxisIndex = iterations
        break

var startZOffset = tools[state.currentTool].offsets[var.zAxisIndex]

M118 S{"touchoff_Z.g: Beginning Z offset for T" ^ state.currentTool ^ " is " ^ var.startZOffset} L3

M561                                                                                                                    ; Cancel any bed-plane fitting

M291 P"Turret will now move. Is a tool above the touch-off pin?" R"Crash Check" S3
G10 P{state.currentTool} Z0

if sensors.probes[1].value[0] == 1000
    M291 P{"Error: Touch off plate already triggered. Check touch off plate and try again."} R"TO Plate Already Triggered" S2
    abort

G38.2 Z{move.axes[var.zAxisIndex].userPosition - 8} P1

M118 S{"touchoff_Z.g: Ending Z position for T" ^ state.currentTool ^ " is " ^ move.axes[var.zAxisIndex].userPosition} L3

M118 S{"End touchoff_Z.g"} L3
