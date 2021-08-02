; trigger2.g
; Activates when extruder crash detect switch is triggered
; Written by Diabase Engineering
; Last Updated: August 2, 2021

if global.IsRetractingProbe != 1                                                                    ; Run only if we're not in the middle of a probe retraction
    M25                                                                                             ; Pause job
    M291 P"Crash detect switch is engaged. Reseat extruder and continue." R"Crash Detected" S3      ; Display alert message