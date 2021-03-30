if {(move.axes[5].letter ^ "") == "W"} ; Motor-driven cleaning station
    G90 ; Set to Absolute Positioning
    M400 ; Wait for current moves to finish
    G1 W30 F15000 ; Move W to 21 at 15000 mm/min
    G4 P125 ; Dwell for 125 ms
    M400 ; Wait for current moves to finish
    M42 P1 S1 ; Close pliers
    G4 P125 ; Dwell for 125 ms
	G1 W20
    G28 W ; Home W
    M42 P1 S0.75 ; Reduce pliers-closing solenoid current to 75%
    G4 P125 ; Dwell for 125 ms
    M42 P1 S0.5 ; Reduce pliers-closing solenoid current to 50%
    G4 P175 ; Dwell for 175 ms
    M42 P1 S0 ; Open Pliers
    M400 ; Wait for current moves to finish

else ; Solenoid-driven cleaning station
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
