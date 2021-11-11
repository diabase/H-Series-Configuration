; clean.g
; Extend, close, retract, and open the cleaning station pliers
; Written by Diabase Engineering
; Last Updated: July 28, 2021

if global.cSType == "Motor"
    G90 ; Set to Absolute Positioning
    M400 ; Wait for current moves to finish
    G1 W{global.wClean} F15000 ; Move W to value specified in cleaningstation.g at 15000 mm/min to extend the cleaning station pliers to surround the nozzle
    G4 P125 ; Dwell for 125 ms
    M400 ; Wait for current moves to finish
    M42 P{global.cSPinchOutNum} S1.0 ; Close pliers
    G4 P125 ; Dwell for 125 ms
    G1 W{global.wGrab} F15000 ; Move W to value specified in cleaningstation.g at 15000 mm/min to retract the cleaning station pliers to pull the filament button from the nozzle
    G28 W ; Home W
    M42 P{global.cSPinchOutNum} S0.75 ; Reduce pliers-closing solenoid current to 75%
    G4 P125 ; Dwell for 125 ms
    M42 P{global.cSPinchOutNum} S0.5 ; Reduce pliers-closing solenoid current to 50%
    G4 P175 ; Dwell for 175 ms
    M42 P{global.cSPinchOutNum} S0 ; Open Pliers
    M400 ; Wait for current moves to finish

elif global.cSType == "Solenoid"
    M400 ; Wait for current moves to finish
    M42 P{global.cSSolenoidOutNum} S1 ; Extend Pliers
    G4 P125 ; Dwell for 125 ms
    M42 P{global.cSPinchOutNum} S1.0 ; Close pliers
    G4 P125 ; Dwell for 125 ms
    M42 P{global.cSPinchOutNum} S0.75 ; Reduce pliers-closing solenoid current to 75%
    G4 P125 ; Dwell for 125 ms
    M42 P{global.cSSolenoidOutNum} S0 ; Retract cleaning station
    M42 P{global.cSPinchOutNum} S0.5 ; Reduce pliers-closing solenoid current to 50%
    G4 P175 ; Dwell for 175 ms
    M42 P{global.cSPinchOutNum} S0 ; Open Pliers
    M400 ; Wait for current moves to finish
