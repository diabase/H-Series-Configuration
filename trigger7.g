; trigger7.g
; Behavior for Opening Filament Cabinet
; Written by Diabase Engineering
; Last Updated: October 29, 2021

M118 S{"Debug: Begin trigger7.g"} L3

while iterations < #sensors.analog
    if sensors.analog[iterations] != null
        if sensors.analog[iterations].name == "FilamentCabinetRH[%]"
            set global.FCRH = sensors.analog[iterations].lastReading
            break

set global.FCDoorOpenTime = state.upTime
M118 S{"Warning: Filament Cabinet -- Door opened, fans stopping, relative humidity is "^{global.FCRH}^"%"} L1    ; Log warning event
while iterations < #fans
    if fans[iterations] != null
        if fans[iterations].name == "Filament Cabinet Fan"
            M106 P{iterations} S0.0
            break

M118 S{"Debug: End trigger7.g"} L3
