; zoffsetbasictc.g
; Called to measure the z offset for the basic tool changer tools without rotating the turret between tools
; M98 P"0:/sys/sys-macros/internal/zoffsetbasictc.g"
; Written by Diabase Engineering
; Last Updated: April 26, 2022

M118 S{"Debug: Begin zoffsetbasictc.g"} L3

if {global.machineModel} == "H5B"
    M291 P"This will automatically touch off the probe and tools 11, 13, and 15 using the tool changer touch off plate. Ready?" R"checkalltoolpairs.g" S3

    T{global.zProbeToolNum}                                                                                         ; Select Probe
    M98 P"0:/sys/sys-macros/tctouchoff.g" I0

    T11
    M98 P"0:/sys/sys-macros/tctouchoff.g" I0

    T13
    M98 P"0:/sys/sys-macros/tctouchoff.g" I0

    T15
    M98 P"0:/sys/sys-macros/tctouchoff.g" I0

    T{global.zProbeToolNum}                                                                                         ; Select Probe

M118 S{"Debug: End zoffsetbasictc.g"} L3
