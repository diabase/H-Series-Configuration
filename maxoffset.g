; maxoffset.g
; Determines the tool offset of the longest tool.
; Written by Diabase Engineering
; Last Updated: July 20, 2021

M118 S{"Info: Begin maxoffset.g"} L2

set global.MaxOffset=0 ; Wipe any maxoffset set previously.
while iterations<#tools ; Step through all tools.
    if tools[iterations] !=null ; Skip any undefined tools.
        set global.MaxOffset={min(tools[iterations].offsets[2],global.MaxOffset)} ; Assign the most negative tool offset to MaxOffset or leave at zero if all are positive.

set global.MaxOffsetLastRun = state.upTime

M118 S{"Info: End maxoffset.g"} L2
