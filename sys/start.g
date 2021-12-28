; start.g
; Called before running any job
; Written by Diabase Engineering
; Last Updated: December 01, 2021

M118 S{"Debug: Begin start.g"} L3

if {global.machineModel} == "H5B"
        if sensors.gpIn[{global.airPressureInNum}].value == 0
            M291 P"Warning: Incoming air pressure low. Resolve before continuing." R"Warning" S3            ; Display a blocking warning with no timeout.
            abort

M118 S{"Debug: End start.g"} L3
