; trigger8.g
; Activates when incoming air pressure drops below set point
; Written by Diabase Engineering
; Last Updated: October 11, 2021

M118 S{"Debug: Begin trigger8.g"} L3

if {global.MachineModel} == "H5A"
    if {state.machineMode} == "CNC"
        M291 P"Caution: Incoming air pressure low." R"Caution" S1 T5                                    ; Display a non-blocking warning with an automatic five-second timeout

elif {global.MachineModel} == "H5B"
        M25                                                                                             ; Pause job
        M291 P"Warning: Incoming air pressure low. Resolve before continuing." R"Warning" S3            ; Display a blocking warning with no timeout.


M118 S{"Debug: End trigger8.g"} L3
