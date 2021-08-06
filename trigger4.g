; trigger4.g
; Behavior on E-Stop Engagement
; Written by Diabase Engineering
; Last Updated: August 6, 2021

M118 S{"Debug: Begin trigger4.g"} L3

M118 S{"Debug: Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L3
M118 S{"Warning: E-Stop Engaged"} L1
M98 P"engagezbrake.g"
M118 S{"Debug: Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L3

M118 S{"Debug: End trigger4.g"} L3
