; indexspindle.g
; Use low pressure spindle release and the spindle driver to index the spindle
; Parameters:
;    H: Has Tool (H0 - No tool, H1 - Tool Loaded)
;    S: Spindle Number
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
; Last Updated: March 23, 2022

M118 S{"Begin indexspindle.g with parameters H" ^ {param.H} ^ " and S" ^ {param.S} } L3

if {global.machineModel} == "H5B"
    M42 P{global.dbarOutNum} S1                                                                                     ; Toggle Drawbar Clamping Pressure to Vent and Release Pressure to Low with Throttled Vent
    G4 P1000                                                                                                        ; Dwell 1000ms
    var blipSpindleSpeed = 600
    var blipDuration = 175

    if {param.H} == 0                                                                                                               ; We've been told there's no tool in the spindle, so use Spindex Sensor 1
        while sensors.gpIn[{global.spindleIndexSense1InNum}].value == 0                                                             ; spindleIndexSense1 value == 0 means we're still attempting to index, == 1 means we are indexed
            if iterations > 0
                if {{mod(iterations,10)} == 0}                                                                                       ; Every fifth attempt...
                    M42 P{global.dbarOutNum} S0                                                                                     ; Toggle Drawbar Clamping Pressure to High Pressure
                    G4 P500                                                                                                         ; Dwell 100ms
                    M118 S{"indexspindle.g: Additional blip with drawbar fully clamped on attempt "^iterations ^ " at " ^ var.blipSpindleSpeed ^"RPM"} L3
                    M3 S{var.blipSpindleSpeed} P{param.S}                                                                           ; Blip spindle
                    G4 P{var.blipDuration}                                                                                          ; Dwell for {var.blipDuration} ms
                    M5                                                                                                              ; Stop Spindle
                    G4 P200                                                                                                         ; Dwell 200ms
                    M42 P{global.dbarOutNum} S1                                                                                     ; Toggle Drawbar Clamping Pressure to Vent
                    G4 P500                                                                                                         ; Dwell 500ms
            if iterations < 40
                M118 S{"indexspindle.g: Spindle blip attempt "^iterations ^ " at " ^ var.blipSpindleSpeed ^"RPM"} L3
                M3 S{var.blipSpindleSpeed} P{param.S}
                G4 P{var.blipDuration}
                M5
                G4 P200
            else
                M291 P{"Warning: Spindle blipped " ^ iterations ^ " times without success."} R"Warning" S3                          ; Display a blocking warning with no timeout.

    if {param.H} == 1                                                                                                               ; We've been told there is a tool in the spindle, so use Spindex Sensor 2
        while sensors.gpIn[{global.spindleIndexSense2InNum}].value == 0                                                             ; spindleIndexSense2 value == 0 means we're still attempting to index, == 1 means we are indexed
            if iterations > 0
                if {{mod(iterations,5)} == 0}                                                                                       ; Every fifth attempt...
                    M42 P{global.dbarOutNum} S0                                                                                     ; Toggle Drawbar Clamping Pressure to High Pressure
                    G4 P500                                                                                                         ; Dwell 100ms
                    M118 S{"indexspindle.g: Additional blip with drawbar fully clamped on attempt "^iterations ^ " at " ^ var.blipSpindleSpeed ^"RPM"} L3
                    M3 S{var.blipSpindleSpeed} P{param.S}                                                                           ; Blip spindle
                    G4 P{var.blipDuration}                                                                                          ; Dwell for {var.blipDuration} ms
                    M5                                                                                                              ; Stop Spindle
                    G4 P200                                                                                                         ; Dwell 200ms
                    M42 P{global.dbarOutNum} S1                                                                                     ; Toggle Drawbar Clamping Pressure to Vent
                    G4 P500                                                                                                         ; Dwell 500ms
            if iterations < 20
                M118 S{"indexspindle.g: Spindle blip attempt "^iterations ^ " at " ^ var.blipSpindleSpeed ^"RPM"} L3
                M3 S{var.blipSpindleSpeed} P{param.S}                                                                           ; Blip spindle
                G4 P{var.blipDuration}                                                                                          ; Dwell for {var.blipDuration} ms
                M5                                                                                                              ; Stop Spindle
                G4 P200                                                                                                         ; Dwell 200ms
            else
                M291 P{"Warning: Spindle blipped " ^ iterations ^ " times without success."} R"Warning" S3            ; Display a blocking warning with no timeout.
    M400

if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    M118 P0 S{"Error: This machine is not configured for spindle indexing."} L1

M118 S{"End indexspindle.g"} L3
