; machinespecific.g
; Configuration parameters specific to this individual H-Series machine.
; Produced by Diabase H-Series Configurizer
; Written by Diabase Engineering
; Last Updated: March 21, 2022

M118 S{"Info: Begin machinespecific.g"} L2

if {exists(global.machineName)}
    set global.machineName = "H5014"

set global.machineModel = "H5B"
set global.uMin = -4.5                          ; On March 5, 2022, AR reverted this value to -4.5 to support this machine's probe being loaded in tool position 10
set global.bMin = -214.5                        ; Set by AR on 3/15/2022
set global.tCOvertravelPutTool = 34.5           ; Set by AR on 3/12/2022
set global.zProbeToolNum = 10                   ; On March 14, 2022, RT set this value to 10

set global.toolType1 = "Extruder"               ; Set by RT on 3/17/2022
set global.e1TempPin = "4.temp0"                ; Set by RT on 3/17/2022
set global.eHeat1Pin = "4.out0"                 ; Set by RT on 3/17/2022
set global.e1Drive = 4.0                      ; Set by RT on 3/17/2022
set global.fA1Drive = 4.1                     ; Set by RT on 3/17/2022

set global.toolType3 = "Extruder"               ; Set by RT on 3/17/2022
set global.e3TempPin = "1.temp0"                ; Set by RT on 3/17/2022
set global.eHeat3Pin = "1.out0"                 ; Set by RT on 3/17/2022
set global.e3Drive = 1.0                      ; Set by RT on 3/17/2022
set global.fA3Drive = 3.0                     ; Set by RT on 3/17/2022

set global.machineSpecificLastRun = state.upTime

M118 S{"Info: End machinespecific.g"} L2
