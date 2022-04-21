; testz-const.g
; Testing speed parameters for the Z-axis
; Written by Diabase Engineering
; Last Updated: February 08, 2022

M118 S{"Debug: Begin testz-const.g"} L3

var axisIndex = -1

while iterations < #move.axes
    if move.axes[iterations].letter == "Z"
        set var.axisIndex = iterations
        break

var startJerk = move.axes[var.axisIndex].jerk
var startAccel = move.axes[var.axisIndex].acceleration
var startSpeed = move.axes[var.axisIndex].speed

var jerk = move.axes[var.axisIndex].jerk
var accel = move.axes[var.axisIndex].acceleration
var speed = move.axes[var.axisIndex].speed

while true
    set var.jerk = move.axes[var.axisIndex].jerk
    set var.accel = move.axes[var.axisIndex].acceleration
    set var.startSpeed = move.axes[var.axisIndex].speed
    M291 P{"Max speed is "^{var.speed}^", accel is "^{var.accel}^", and jerk is "^{var.jerk}^". Ready for a test move?"} R"Z-Axis Parameters" S3
    M42 P{global.tCToolReleaseOutNum} S0                    ; Ensure the tool changer release piston is retracted
    T3                                                      ; Select Tool 3
    G90                                                     ; Absolute positioning
    G1 Z20 F{var.speed}                                     ; Move to Z20 at maximum speed
    G1 Z{move.axes[2].max + global.maxOffset} F{var.speed}  ; Move to ZMax (less max offset) at maximum speed
    G1 Z20 F{var.speed}                                     ; Move to Z20 at maximum speed
    G1 Z{move.axes[2].max + global.maxOffset} F{var.speed}  ; Move to ZMax (less max offset) at maximum speed
    G1 Z20 F{var.speed}                                     ; Move to Z20 at maximum speed
    G1 Z{move.axes[2].max + global.maxOffset} F{var.speed}  ; Move to ZMax (less max offset) at maximum speed

M118 S{"Debug: End testz-const"} L3
