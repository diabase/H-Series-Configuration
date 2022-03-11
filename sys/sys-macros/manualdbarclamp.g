; manualdbarclamp.g
; Manually Clamp Drawbar
; Written by Diabase Engineering
; Last Updated: March 10, 2022

M118 S{"Info: Begin manualdbarclamp.g"} L2

if {global.machineModel} == "H5B"
    M42 P{global.dbarOutNum} S0             ; Turn Drawbar Release Pressure Off (Clamp Pressure On)
    M42 P{global.spindleIndexOutNum} S0     ; Toggle Drawbar Release Pressure to Primary Solenoid Control (global.dbarOutNum == 0 -> Vent, globaldbarOutNum == 1 -> High) 

M118 S{"Info: End manualdbarclamp.g"} L2
