; daemon.g

; Log UMot Temperature every 30 seconds when machine not idle
if state.status != "idle"
    if {{global.UMotTempNum} != -1}
        if {state.upTime >= {{global.UMotTempTime} + {global.UMotTempTimeInterval}}}
            set global.UMotTempTime = state.upTime
            set global.UMotTemp = sensors.analog[{global.UMotTempNum}].lastReading
            M118 S{"Info: UMot Temperature was "^{global.UMotTemp}^" at "^{global.UMotTempTime}} L2
