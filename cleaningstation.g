; cleaningstation.g
; Configure Cleaning Station
; Written by Diabase Engineering
; Last Updated: August 5, 2021

M118 S{"Info: Begin cleaningstation.g"} L2

; Configure Positions for Cleaning Station Motor
if {exists(global.wPrimeSurface)}
    if global.wClearance == -1
        set global.wClearance = {{global.wPrimeSurface} - 5}
    if global.wClean == -1
        set global.wClean = {{global.wPrimeSurface} - 2}
    if global.wGrab == -1
        set global.wGrab = {{global.wPrimeSurface} - 10}

; Configure Cleaning Station Solenoids
if {exists(global.cSSolenoidPin)}
    if global.cSSolenoidOutNum == -1
        set global.cSSolenoidOutNum = #state.gpOut
    M118 S{"Info: cleaningstation.g: Creating state.gpOut[" ^ {global.cSSolenoidOutNum} ^"] on pin" ^ {cSSolenoidPin} ^ " for cleaning station solenoid extension"} L2
    M950 P{global.cSSolenoidOutNum} C{cSSolenoidPin} ; Cleaning Station, Station Extension Solenoid - Assign next available gpOut to the CS solenoid pin as defined in defaultparameters.g
else
    M118 S{"Info: No cleaning station solenoid pin defined"} L2


if global.cSPinchOutNum == -1
    set global.cSPinchOutNum = #state.gpOut
M118 S{"Info: cleaningstation.g: Creating state.gpOut[" ^ {global.cSPinchOutNum} ^ "] on pin " ^ {global.cSPinchPin} ^ " for cleaning station pliers-closing solenoid"} L2
M950 P{global.cSPinchOutNum} C{global.cSPinchPin} ; Cleaning Station, Pliers-Closing Solenoid - Assign next available gpOut to the CS pinch pin as defined in defaultparameters.g

; Configure Optional Cleaning Station Vacuum
if {exists(global.vacuumPin)}
    if global.vacuumFanNum == -1
        set global.vacuumFanNum = #fans
    M118 S{"Info: cleaningstation.g: Creating fans["^{global.vacuumFanNum}^"] on pin "^{global.vacuumPin}^" for cleaning station vacuum."} L2
    M950 F{global.vacuumFanNum} C{global.vacuumPin} ; Cleaning Station Vacuum - Assign next available fan number to the vacuum pin as defined in defaultparameters.g
    M106 P{global.vacuumFanNum} S0 B0 L1.0 C"Vacuum" ; I/O Pin for Cleaning Station Vacuum Relay - Configure the newly created fan: Speed 0, Blip Time 0, Minimum Fan Speed 1.0, and call it "Vacuum"

set global.cleaningStationLastRun = state.upTime

M118 S{"Info: End cleaningstation.g"} L2
