; rotatetotc.g
; Rotate turret to tool changer position
; Written by Diabase Engineering
; Last Updated: December 07, 2021

M118 S{"Info: Begin rotatetotc.g"} L2

if {global.machineModel} == "H5B"
    M400                            ; Wait for current moves to finish
    G90                             ; Absolute positioning
    M98 P"unlock_turret.g"          ; Unlock turret
    G1 U180 F6000                   ; Point active tool at tool changer
    M98 P"lock_turret.g"            ; Lock turret

M118 S{"Info: End rotatetotc.g"} L2
