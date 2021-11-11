; machinespecific.g
; Configuration parameters specific to this individual H-Series machine.
; Produced by Diabase H-Series Configurizer
; Written by Diabase Engineering
; Last Updated: August 6, 2021

M118 S{"Info: Begin machinespecific.g"} L2

if {exists(global.machineName)}
    set global.machineName = "H5005"

if global.machineName == "H5001"

if global.machineName == "H5002"
    set global.zMin = -20
    M906 A2000 I90

if global.machineName == "H5003"
    set global.uMin = -9.9

if global.machineName == "H5004"
    set global.uMin = -9.9

if global.machineName == "H5005"
    set global.uMin = -8.8

if global.machineName == "H5006"

set global.machineSpecificLastRun = state.upTime

M118 S{"Info: End machinespecific.g"} L2
