; trigger11.g
; Behavior for Opening Build Enclosure
; Written by Diabase Engineering
; Last Updated: October 20, 2021

M118 S{"Debug: Begin trigger11.g"} L3

set global.bEOpenTime = state.upTime
M118 S{"Info: Build Enclosure -- Enclosure Opened"} L2    ; Log informational event

M118 S{"Debug: state.status is " ^ {state.status}} L3
if {state.status} == "processing"
        M25                                                                                             ; Pause job
        M291 P"Warning: Build enclosure opened and job paused. Resume job to continue." R"Warning" S3   ; Display a blocking warning with no timeout.

M118 S{"Debug: End trigger11.g"} L3
