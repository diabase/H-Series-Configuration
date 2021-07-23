; cleaningstation.g
; Configure H4 Cleaning Station
; Written by Diabase Engineering
; Last Updated: July 22, 2021

M118 S{"Info: Begin cleaningstation.g"} L2

; Configure Cleaning Station Solenoids
if {exists(global.CSSolenoidPin)}
    if global.CSSolenoidOutNum == -1
        set global.CSSolenoidOutNum = #state.gpOut
    M118 S{"Info: cleaningstation.g: Creating state.gpOut[" ^ {global.CSSolenoidOutNum} ^"] on pin" ^ {CSSolenoidPin} ^ " for cleaning station solenoid extension"} L2
    M950 P{global.CSSolenoidOutNum} C{CSSolenoidPin} ; Cleaning Station, Station Extension Solenoid - Assign next available gpOut to the CS solenoid pin as defined in defaultparameters.g
else
    M118 S{"Info: No cleaning station solenoid pin defined"} L2


set global.CSPinchOutNum = #state.gpOut
M118 S{"Info: cleaningstation.g: Creating state.gpOut[" ^ {global.CSPinchOutNum} ^ "] on pin " ^ {global.CSPinchPin} ^ " for cleaning station pliers-closing solenoid"} L2
M950 P{global.CSPinchOutNum} C{global.CSPinchPin} ; Cleaning Station, Pliers-Closing Solenoid - Assign next available gpOut to the CS pinch pin as defined in defaultparameters.g

; Configure Optional Cleaning Station Vacuum
if {exists(global.VacuumPin)}
    if global.VacuumFanNum == -1
        set global.VacuumFanNum = #fans
    M118 S{"Info: cleaningstation.g: Creating fans["^{global.VacuumFanNum}^"] on pin "^{global.VacuumPin}^" for cleaning station vacuum."} L2
    M950 F{global.VacuumFanNum} C{global.VacuumPin} ; Cleaning Station Vacuum - Assign next available fan number to the vacuum pin as defined in defaultparameters.g
    M106 P{global.VacuumFanNum} S0 B0 L1.0 C"Vacuum" ; I/O Pin for Cleaning Station Vacuum Relay - Configure the newly created fan: Speed 0, Blip Time 0, Minimum Fan Speed 1.0, and call it "Vacuum"

set global.CleaningStationLastRun = state.upTime

M118 S{"Info: End cleaningstation.g"} L2
