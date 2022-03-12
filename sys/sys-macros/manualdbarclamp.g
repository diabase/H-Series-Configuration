; manualdbarclamp.g
; Manually Clamp Drawbar
;
; Possible Drawbar Clamping States:
;     | dbar    | spindleIndex  || Drawbar Cylinder | Drawbar Cylinder          || Functional
;     | Value   | Value         || Clamp Side       | Release Side              || Result
;     ------------------------------------------------------------------------------------------------
;     | 0       |  0            || High Pressure    | Throttled Vent            || Drawbar Fully Clamped
;     | 0       |  1            || High Pressure    | High Pressure             || Drawbar Held at Starting Position
;     | 1       |  0            || Vented           | Low with Throttled Vent   || Currently Indexing
;     | 1       |  1            || Vented           | High Pressure             || Drawbar Fully Released
;
; Written by Diabase Engineering
; Last Updated: March 11, 2022

M118 S{"Info: Begin manualdbarclamp.g"} L2

if {global.machineModel} == "H5B"
    M42 P{global.dbarOutNum} S0             ; Toggle Drawbar Clamp Pressure High
    M42 P{global.spindleIndexOutNum} S0     ; Toggle Drawbar Release Pressure Throttled Vent

M118 S{"Info: End manualdbarclamp.g"} L2
