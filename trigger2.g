; trigger2.g
; Activates when extruder crash detect switch is triggered
; Written by Diabase Engineering
; Last Updated: October 29, 2021

M118 S{"Debug: Begin trigger2.g"} L3

if global.IsMovingProbe != 1                                                                        ; Run only if we're not in the middle of moving the probe
    if state.machineMode == "FFF"                                                                   ; and we're in FFF mode.
        if {state.status} == "processing"
            M25                                                                                     ; Pause job
        M291 P"Crash detect switch is engaged. Reseat extruder and continue." R"Crash Detected" S3  ; Display alert message

M118 S{"Debug: End trigger2.g} L3
