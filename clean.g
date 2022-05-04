; clean.g
; Extend, close, retract, and open the cleaning station pliers
; Written by Diabase Engineering
; Last Updated: February 23, 2021
; Customized for H4046 (Wclean and Wgrab) - May 4, 2022

while iterations < #move.axes ; Loop over all axes
    if {(move.axes[iterations].letter ^ "") == "W"} ; A W-axis is defined, so we have a motor-driven cleaning station.
        G90 ; Set to Absolute Positioning
        M400 ; Wait for current moves to finish
        G1 W30 F15000 ; Move W to 30mm at 15000 mm/min to extend the cleaning station pliers to surround the nozzle (Wclean)
        G4 P125 ; Dwell for 125 ms
        M400 ; Wait for current moves to finish
        M42 P1 S1 ; Close pliers
        G4 P125 ; Dwell for 125 ms
        G1 W10 F15000 ; Move W to 10mm at 15000 mm/min to retract the cleaning station pliers to pull the filament button from the nozzle (Wgrab)
        G28 W ; Home W
        M42 P1 S0.75 ; Reduce pliers-closing solenoid current to 75%
        G4 P125 ; Dwell for 125 ms
        M42 P1 S0.5 ; Reduce pliers-closing solenoid current to 50%
        G4 P175 ; Dwell for 175 ms
        M42 P1 S0 ; Open Pliers
        M400 ; Wait for current moves to finish
        break ; Stop Looping

    elif iterations == {#move.axes - 1} ; We're on the last loop and none were W, so assume we have a solenoid cleaning station.
        M400 ; Wait for current moves to finish
        M42 P0 S1 ; Extend Pliers
        G4 P125 ; Dwell for 125 ms
        M42 P1 S1 ; Close pliers
        G4 P125 ; Dwell for 125 ms
        M42 P1 S0.75 ; Reduce pliers-closing solenoid current to 75%
        G4 P125 ; Dwell for 125 ms
        M42 P0 S0 ; Retract cleaning station
        M42 P1 S0.5 ; Reduce pliers-closing solenoid current to 50%
        G4 P175 ; Dwell for 175 ms
        M42 P1 S0 ; Open Pliers
        M400 ; Wait for current moves to finish
