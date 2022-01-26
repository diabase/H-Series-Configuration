; zoffsetalltc.g
; Called to measure the z offset for all tool changer tools without rotating the turret between tools
; Written by Diabase Engineering
; Last Updated: January 26, 2022

M118 S{"Debug: Begin zoffsetalltc.g"} L3

if {global.machineModel} == "H5B"
    M291 P"This will automatically touch off the probe and then all tool changer tools using the tool changer touch off plate. Ready?" R"checkalltoolpairs.g" S3
    T{global.zProbeToolNum}                                                                                         ; Select Probe
    M98 P"0:/sys/sys-macros/tctouchoff.g" I0
    M98 P"unlock_turret.g"                                                                                          ; Call unlock_turret.g
    G53 G1 U{-tools[11].offsets[3]+180}
    M400
    M98 P"lock_turret.g"                                                                                            ; Lock turret
    set global.dontRotate = 1

    while iterations < 14
        T{11+iterations}
        M98 P"0:/sys/sys-macros/tctouchoff.g" I0

    set global.dontRotate = 0
    
M118 S{"Debug: End zoffsetalltc.g"} L3

