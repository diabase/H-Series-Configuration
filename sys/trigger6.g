; trigger6.g
; Behavior for Closing Filament Cabinet
; Written by Diabase Engineering
; Last Updated: November 05, 2021

M118 S{"Debug: Begin trigger6.g"} L3

while iterations < #sensors.analog
    if sensors.analog[iterations] != null
        if sensors.analog[iterations].name == "FilamentCabinetRH[%]"
            set global.fCRH = sensors.analog[iterations].lastReading
            break

set global.fCDoorCloseTime = state.upTime
M118 S{"Info: Filament Cabinet -- Door closed, fans starting, relative humidity is "^{global.fCRH}^"%"} L2    ; Log info event
while iterations < #fans
    if fans[iterations] != null
        if fans[iterations].name == "Filament Cabinet Fan"
            M106 P{iterations} S1.0
            break

M118 S{"Debug: End trigger6.g"} L3
