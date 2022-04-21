; testb-const.g
; Testing speed parameters for the B-axis
; Written by Diabase Engineering
; Last Updated: January 06, 2022

M118 S{"Debug: Begin testb-const.g"} L3

var axisIndex = -1

while iterations < #move.axes
    if move.axes[iterations].letter == "B"
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
    M291 P{"Max speed is "^{var.speed}^", accel is "^{var.accel}^", and jerk is "^{var.jerk}^". Ready for a test move?"} R"B-Axis Parameters" S3
    M42 P{global.tCToolReleaseOutNum} S0    ; Ensure the tool changer release piston is retracted
    T-1 P0                                  ; Deselect the current tool, but don't run any of the tool changing files
    G90                                     ; Absolute positioning
    G1 B-200 F{var.speed}                   ; Move to B-200 at maximum speed
    G1 B200                                 ; Move to B200 at maximum speed
    G1 B-200 F{var.speed}                   ; Move to B-200 at maximum speed
    G1 B200                                 ; Move to B200 at maximum speed
    G1 B-200 F{var.speed}                   ; Move to B-200 at maximum speed
    G1 B200                                 ; Move to B200 at maximum speed
    G1 B0 F{var.speed}                      ; Move to B0 at maximum speed

M118 S{"Debug: End testb-const"} L3
