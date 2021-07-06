; maxoffset.g
; Determines the tool offset of the longest tool.
; Written by Diabase Engineering
; Last Updated: May 12, 2021

set global.maxoffset=0 ; Wipe any maxoffset set previously.
while iterations<#tools ; Step through all tools.
    if tools[iterations] !=null ; Skip any undefined tools.
        set global.maxoffset={min(tools[iterations].offsets[2],global.maxoffset)} ; Assign the most negative tool offset to maxoffset or leave at zero if all are positive.
