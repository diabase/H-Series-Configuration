; zoffsetbasictc-norotate.g
; Called to measure the z offset for the basic tool changer tools without rotating the turret between tools
; M98 P"0:/sys/sys-macros/internal/zoffsetbasictc-norotate.g"
; Written by Diabase Engineering
; Last Updated: April 26, 2022

M118 S{"Debug: Begin zoffsetbasictc-norotate.g"} L3

if {global.machineModel} == "H5B"
    M291 P"This will automatically touch off the probe and tools 11, 13, and 15 using the tool changer touch off plate. Ready?" R"checkalltoolpairs.g" S3
    T{global.zProbeToolNum}                                                                                         ; Select Probe
    M98 P"0:/sys/sys-macros/tctouchoff.g" I0
    M98 P"unlock_turret.g"                                                                                          ; Call unlock_turret.g
    G53 G1 U{-tools[11].offsets[3]+180} F10000
    M400
    M98 P"lock_turret.g"                                                                                            ; Lock turret
    set global.dontRotate = 1

    T11
    M98 P"0:/sys/sys-macros/tctouchoff.g" I0
    T13
    M98 P"0:/sys/sys-macros/tctouchoff.g" I0
    T15
    M98 P"0:/sys/sys-macros/tctouchoff.g" I0

    set global.dontRotate = 0
    M98 P"unlock_turret.g"                                                                                          ; Call unlock_turret.g
    G53 G1 U{-tools[state.currentTool].offsets[3]} Z{move.axes[2].max} F10000                                        ; Rotate turret to active position for new tool and move up to ZMax
    M400
    M98 P"lock_turret.g"                                                                                            ; Lock turret

    T{global.zProbeToolNum}                                                                                         ; Select Probe
    
M118 S{"Debug: End zoffsetbasictc-norotate.g"} L3
