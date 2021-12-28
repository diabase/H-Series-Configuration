; closetcjaws.g
; Manually Close Tool Changer Jaws
; Written by Diabase Engineering
; Last Updated: December 02, 2021

M118 S{"Info: Begin closetcjaws.g"} L2
if {global.machineModel} == "H5B"
    M400                                    ; Wait for any current moves to finish
    M42 P{global.tCToolReleaseOutNum} S0    ; Retract the tool changer release piston

M118 S{"Info: Begin closetcjaws.g"} L2
