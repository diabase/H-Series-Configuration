; estop.g
; Additional behavior (not M112) when an e-stop is triggered or a 24V voltage drop is detected
; Written by Diabase Engineering
; Last Updated: April 12, 2022

M118 S{"Begin estop.g"} L1
M118 S{"E-Stop Engaged"} L1

M118 S{"Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L3
M98 P"engagezbrake.g"

if state.machineMode == "CNC"
    while iterations < #spindles
        if spindles[iterations].state != "stopped"
            M5 P{iterations}                ; Turn this spindle off
            G4 P1000                        ; Dwell for 1000 ms to allow it time to stop

M118 S{"Vin is " ^ boards[0].vIn.current ^ " at " ^ state.upTime ^ "." ^ state.msUpTime} L3

M291 P"Print has been paused. After recovery, unpause from print status screen." R"Emergency Stop" S1 ; Display message with "Emergency Stop" as the message box title and display a "Close" button
; M112

M118 S{"End estop.g"} L1
