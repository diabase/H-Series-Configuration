; resurrect-prologue.g
; This file should be run after an emergency stop or low-voltage event.
; Written by Diabase Engineering
; Last Updated: April 12, 2022

M118 S{"Begin resurrect-prologue.g"} L1

M291 P"Emergency stop disengaged. Please wait five seconds for re-initialization." S0 T5
G4 S5
M98 P"config.g"

while iterations < #move.axes
    if move.axes[iterations].homed == false
        M291 P"Homing required. Ready to begin homing?" R"Recovery from Emergency Stop" S3 ; Display blocking message with OK/Cancel.
        G28 ; Home all
        break

M118 S{"End resurrect-prologue.g"} L1
