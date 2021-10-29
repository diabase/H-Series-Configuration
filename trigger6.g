; trigger6.g
; Behavior for Closing Filament Cabinet
; Written by Diabase Engineering
; Last Updated: October 29, 2021

M118 S{"Debug: Begin trigger6.g"} L3

while iterations < #sensors.analog
    if sensors.analog[iterations] != null
        if sensors.analog[iterations].name == "FilamentCabinetRH[%]"
            set global.FCRH = sensors.analog[iterations].lastReading
            break

set global.FCDoorCloseTime = state.upTime
M118 S{"Warning: Filament Cabinet -- Door closed, fans starting, relative humidity is "^{global.FCRH}^"%"} L1    ; Log warning event
while iterations < #fans
    if fans[iterations] != null
        if fans[iterations].name == "Filament Cabinet Fan"
            M106 P{iterations} S1.0
            break

M118 S{"Debug: End trigger6.g"} L3
