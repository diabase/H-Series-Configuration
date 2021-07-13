; trigger7.g
; Behavior for Opoening Filament Cabinet
; Written by Diabase Engineering
; Last Updated: July 12, 2021

while iterations < #sensors.analog
    if sensors.analog[iterations] != null
        if sensors.analog[iterations].name == "FilamentCabinetRH[%]"
            set global.FCRH = sensors.analog[iterations].lastReading
            break

set global.FCDoorOpenTime = state.upTime
M118 S{"Info: Filament Cabinet -- Door opened, fans stopping, relative humidity is "^{global.FCRH}^"%"} L2    ; Log informational event
while iterations < #fans
    if fans[iterations] != null
        if fans[iterations].name == "Filament Cabinet Fan"
            M106 P{iterations} S0.0
            break
