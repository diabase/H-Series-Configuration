; manualdbarrelease.g
; Manually Release Drawbar
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

M118 S{"Info: Begin manualdbarrelease.g"} L2

if {global.machineModel} == "H5B"
    ; M42 P{global.spindleIndexOutNum} S1                                                                         ; Toggle Drawbar Release Pressure Low
    ; G4 P1000                                                                                                    ; Dwell for 1000ms - Remove or reduce after testing
    M42 P{global.dbarOutNum} S1                                                                                 ; Toggle Drawbar Clamping Pressure to Vent and Release Pressure to Low with Throttled Vent

    ;if sensors.gpIn[{global.spindleIndexSense1InNum}].value == 0                                                ; spindleIndexSense1 value == 0 means we're still attempting to index, == 1 means we are indexed
    M291 P"Rotate spindle until index pin is in the correct location. Press OK when aligned." R"Warning" S3     ; Display a blocking warning with no timeout.

    ; while sensors.gpIn[{global.spindleIndexSense1InNum}].value == 0                                            ; spindleIndexSense1 value == 0 means we're still attempting to index, == 1 means we are indexed
    ;     echo "Manually rotate until the pin drops in the slot"
    ;     G4 S2                                                                                                 ; Wait 2 seconds
    ;     if sensors.gpIn[{global.spindleIndexSense1InNum}].value == 1
    ;        break

    M42 P{global.spindleIndexOutNum} S1                                                                         ; Toggle Drawbar Release Pressure High

M118 S{"Info: End manualdbarrelease.g"} L2
