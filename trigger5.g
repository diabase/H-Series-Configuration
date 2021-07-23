; trigger5.g
; Behavior for Disengaging the E-Stop
; Written by Diabase Engineering
; Last Updated: July 22, 2021

M118 S{"Info: Begin trigger5.g"} L2
M118 S{"Info: Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L2
M98 P"resurrect-prologue.g"
M118 S{"Info: Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L2
M118 S{"Info: End trigger5.g"} L2
