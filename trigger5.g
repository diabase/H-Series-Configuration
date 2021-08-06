; trigger5.g
; Behavior on E-Stop Disengagement
; Written by Diabase Engineering
; Last Updated: August 6, 2021

M118 S{"Debug: Begin trigger5.g"} L3

M118 S{"Debug: Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L3
M118 S{"Warning: E-Stop Disengaged"} L1
M98 P"resurrect-prologue.g"
M118 S{"Debug: Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L3

M118 S{"Debug: End trigger5.g"} L3
