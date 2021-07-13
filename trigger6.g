; trigger6.g
; Behavior for Closing Filament Cabinet
; Written by Diabase Engineering
; Last Updated: July 12, 2021

while iterations < #sensors.analog
    if sensors.analog[iterations] != null
        if sensors.analog[iterations].name == "FilamentCabinetRH[%]"
            set global.FCRH = sensors.analog[iterations].lastReading
            break

set global.FCDoorCloseTime = state.upTime
M118 S{"Info: Filament Cabinet -- Door closed, fans starting, relative humidity is "^{global.FCRH}^"%"} L2    ; Log informational event
while iterations < #fans
    if fans[iterations] != null
        if fans[iterations].name == "Filament Cabinet Fan"
            M106 P{iterations} S1.0
            break
