; daemon.g
; This macro runs in the background every 10 seconds
; Written by Diabase Engineering
; Last Updated: March 18, 2022

; Log UMot Temperature every 30 seconds when machine not idle
if {{global.uMotTempNum} != -1}
    if state.status != "idle"
        if {state.upTime >= {{global.uMotTempTime} + {global.uMotTempTimeInterval}}}
            set global.uMotTempTime = state.upTime
            set global.uMotTemp = sensors.analog[{global.uMotTempNum}].lastReading
            M118 S{"Info: UMot Temperature was "^{global.uMotTemp}^" at "^{global.uMotTempTime}} L2
            M118 S{global.uMotTemp} L2

; Log Spindle Temperature every 30 seconds when spindle not stopped
if {{global.spinTempNum} != -1}
    if spindles[0].state != "stopped"
        if {state.upTime >= {{global.spinTempTime} + {global.spinTempTimeInterval}}}}
            set {global.spinTempTime} = state.upTime
            set global.spinTemp = sensors.analog[{global.spinTempNum}].lastReading
            M118 S{"Info: Spindle Temperature was "^{global.spinTemp}^" at "^{global.spinTempTime}} L2
            M118 S{global.spinTemp} L2

; Set Status LED Color Depending on Homed State
if {global.machineModel} == "H5B"
    while iterations < #move.axes
        if move.axes[iterations].homed == false
            if state.gpOut[{global.greenLedOutNum}].pwm != 0
                M118 S{{move.axes[iterations].letter} ^ " axis unhomed. Changing status LED."} L3
                M42 P{global.greenLedOutNum} S0
            if state.gpOut[{global.redLedOutNum}].pwm != 1
                M42 P{global.redLedOutNum} S1
            break
        elif iterations +1 == #move.axes && move.axes[iterations].homed == true
            if state.gpOut[{global.redLedOutNum}].pwm != 0
                M42 P{global.redLedOutNum} S0
                M118 S{"All axes homed. Changing status LED."} L3
            if state.gpOut[{global.greenLedOutNum}].pwm != 1
                M42 P{global.greenLedOutNum} S1
            break
