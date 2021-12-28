; manualdbarclamp.g
; Manually Clamp Drawbar
; Written by Diabase Engineering
; Last Updated: December 02, 2021

M118 S{"Info: Begin manualdbarclamp.g"} L2

if {global.machineModel} == "H5B"
    M42 P{global.dbarOutNum} S0                 ; Turn Drawbar Release Pressure Off (Clamp Pressure On)

M118 S{"Info: End manualdbarclamp.g"} L2
