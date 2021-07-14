; trigger4.g
; Behavior for Disengaging the E-Stop
; Written by Diabase Engineering
; Last Updated: July 13, 2021

M118 S{"Info: Begin trigger4.g"} L2
M118 S{"Info: Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L2
M98 P"engagezbrake.g"
M118 S{"Info: Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L2
M118 S{"Info: End trigger4.g"} L2
