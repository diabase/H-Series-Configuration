; indexspindle.g
; Use low pressure spindle release and the spindle driver to index the spindle
; Parameters:
;    H: Has Tool (H0 - No tool, H1 - Tool Loaded)
;    S: Spindle Number
; Written by Diabase Engineering
; Last Updated: December 21, 2021

M118 S{"Debug: Begin indexspindle.g with parameters H" ^ {param.H} ^ "and S" ^ {param.S} } L3

M42 P{global.spindleIndexOutNum} S1                                                                             ; Toggle Drawbar Release Pressure Low
M42 P{global.dbarOutNum} S1                                                                                     ; Turn Drawbar Release Pressure On
; if sensors.gpIn[{global.spindleIndexSense2InNum}].value == 1                                                     ; Drawbar position sensor active means the index pin hasn't dropped into its slot
;     M291 P"Rotate spindle until index pin is in the correct location. Press OK when aligned." R"Warning" S3     ; Display a blocking warning with no timeout.
var blipSpindleSpeed = 1000
var blipDuration = 200


if {param.H} == 0
    while sensors.gpIn[{global.spindleIndexSense1InNum}].value == 1
        if iterations > 0
            if {{mod(iterations,5)} == 0}
                M42 P{global.dbarOutNum} S0                                                                                     ; Turn Drawbar Release Pressure Off
                G4 P500                                                                                                         ; Dwell 100ms
                M118 S{"Debug: Additional blip with drawbar fully clamped on attempt "^iterations ^ " at " ^ var.blipSpindleSpeed ^"RPM"} L3
                M3 S{var.blipSpindleSpeed} P{param.S}
                G4 P{var.blipDuration}
                M5
                G4 P200
                M42 P{global.dbarOutNum} S1
                G4 P500                                                                                                         ; Dwell 100ms
        if iterations = 10
            set var.blipSpindleSpeed = 2000
            set var.blipDuration = 400
        if iterations < 20
            M118 S{"Debug: Spindle blip attempt "^iterations ^ " at " ^ var.blipSpindleSpeed ^"RPM"} L3
            M3 S{var.blipSpindleSpeed} P{param.S}
            G4 P{var.blipDuration}
            M5
            G4 P200
        else
            M291 P{"Warning: Spindle blipped " ^ iterations ^ " times without success."} R"Warning" S3            ; Display a blocking warning with no timeout.
            ; abort

if {param.H} == 1
    while sensors.gpIn[{global.spindleIndexSense2InNum}].value == 1
        if iterations > 0
            if {{mod(iterations,5)} == 0}
                M42 P{global.dbarOutNum} S0                                                                                     ; Turn Drawbar Release Pressure Off
                G4 P500                                                                                                         ; Dwell 100ms
                M118 S{"Debug: Additional blip with drawbar fully clamped on attempt "^iterations ^ " at " ^ var.blipSpindleSpeed ^"RPM"} L3
                M3 S{var.blipSpindleSpeed} P{param.S}
                G4 P{var.blipDuration}
                M5
                G4 P200
                M42 P{global.dbarOutNum} S1
                G4 P500                                                                                                         ; Dwell 100ms
        if iterations = 10
            set var.blipSpindleSpeed = 2000
            set var.blipDuration = 400
        if iterations < 20
            M118 S{"Debug: Spindle blip attempt "^iterations ^ " at " ^ var.blipSpindleSpeed ^"RPM"} L3
            M3 S{var.blipSpindleSpeed} P{param.S}
            G4 P{var.blipDuration}
            M5
            G4 P200
        else
            M291 P{"Warning: Spindle blipped " ^ iterations ^ " times without success."} R"Warning" S3            ; Display a blocking warning with no timeout.
            ; abort
M400

M118 S{"Debug: End indexspindle.g"} L3
