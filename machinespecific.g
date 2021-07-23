; machinespecific.g
; Configuration parameters specific to this individual H-Series machine.
; Produced by Diabase H-Series Configurizer
; Written by Diabase Engineering
; Last Updated: July 22, 2021

M118 S"Begin machinespecific.g" L2

if {exists(global.MachineName)}
    set global.MachineName = "H5005"

if global.MachineName == "H5001"

if global.MachineName == "H5002"
    set global.ZMin = -20
    M906 I90
    M203 U6500

if global.MachineName == "H5003"
    set global.UMin = -9.9

if global.MachineName == "H5004"
    set global.UMin = -9.9
    if !{exists(global.UMotTempPin)}
        global UMotTempPin = "temp3"
    else
        set global.UMotTempPin = "temp3"

if global.MachineName == "H5005"
    set global.UMin = -8.8
    M203 U6500

if global.MachineName == "H5006"

set global.MachineSpecificLastRun = state.upTime

M118 S"End machinespecific.g" L2
