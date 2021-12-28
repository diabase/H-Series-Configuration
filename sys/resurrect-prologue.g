; resurrect-prologue.g
; This file should be run after an emergency stop or low-voltage event.
; Written by Diabase Engineering
; Last Updated: July 22, 2021

M291 P"Emergency stop disengaged. Please wait five seconds for re-initialization." S0 T5
G4 S5
M98 P"config.g"
M291 P"Homing required. Ready to begin homing?" R"Recovery from Emergency Stop" S3 ; Display blocking message with OK/Cancel.
G28 ; Home all
