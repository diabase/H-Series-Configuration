; estop.g
; Additional behavior (not M112) when an e-stop is triggered or a 24V voltage drop is detected
; Written by Diabase Engineering
; Last Updated: January 31, 2022

M118 S{"Begin estop.g"} L1
M118 S{"E-Stop Engaged"} L1

M118 S{"Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L3
M98 P"engagezbrake.g"
M5 ; Turn off all spindles
M118 S{"Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L3

M291 P"Print has been paused. After recovery, unpause from print status screen." R"Emergency Stop" S1 ; Display message with "Emergency Stop" as the message box title and display a "Close" button
M112

M118 S{"End estop.g"} L1
