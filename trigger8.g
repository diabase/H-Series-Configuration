; trigger8.g
; Activates when incoming air pressure drops below set point
; Written by Diabase Engineering
; Last Updated: October 29, 2021

M118 S{"Debug: Begin trigger8.g"} L3

if {global.machineModel} == "H5B"
        if sensors.gpIn[{global.airPressureInNum}] == 0
            if {state.status} == "processing"
                M25                                                                                                     ; Pause job
            M18 U                                                                                                       ; Disable U axis motor and...
            M17 U                                                                                                       ; immediately re-enable U axis motor to force re-homing.
            M291 P"Warning: Incoming air pressure low. Resolve and re-home U axis before continuing." R"Warning" S3     ; Display a blocking warning with no timeout.

M118 S{"Debug: End trigger8.g"} L3
