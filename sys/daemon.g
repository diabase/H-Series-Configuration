; daemon.g
; This macro runs in the background every 10 seconds
; Written by Diabase Engineering
; Last Updated: January 14, 2022

; Log UMot Temperature every 30 seconds when machine not idle
if {{global.uMotTempNum} != -1}
    if state.status != "idle"
        if {state.upTime >= {{global.uMotTempTime} + {global.uMotTempTimeInterval}}}
            set global.uMotTempTime = state.upTime
            set global.uMotTemp = sensors.analog[{global.uMotTempNum}].lastReading
            M118 S{"Info: UMot Temperature was "^{global.uMotTemp}^" at "^{global.uMotTempTime}} L2
            M118 S{global.uMotTemp} L2
