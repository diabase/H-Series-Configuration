; daemon.g

; Log UMot Temperature every 30 seconds when machine not idle
if state.status != "idle"
    if {{global.uMotTempNum} != -1}
        if {state.upTime >= {{global.uMotTempTime} + {global.uMotTempTimeInterval}}}
            set global.uMotTempTime = state.upTime
            set global.uMotTemp = sensors.analog[{global.uMotTempNum}].lastReading
            ; M118 S{"Info: UMot Temperature was "^{global.uMotTemp}^" at "^{global.uMotTempTime}} L2
            M118 S{global.uMotTemp} L2
