; zoffsetalltc.g
; Called to measure the z offset for all tool changer tools
; Written by Diabase Engineering
; Last Updated: January 06, 2022

M118 S{"Debug: Begin zoffsetalltc.g"} L3

if {global.machineModel} == "H5B"
    M291 P"This will automatically touch off the probe and then all tool changer tools using the tool changer touch off plate. Ready?" R"checkalltoolpairs.g" S3
    T10
    M98 P"0:/sys/sys-macros/tctouchoff.g" I0

    while iterations < 14
        T{11+iterations}
        M98 P"0:/sys/sys-macros/tctouchoff.g" I0

M118 S{"Debug: End zoffsetalltc.g"} L3

