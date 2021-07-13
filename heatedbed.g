; heatedbed.g
; Configures heated bed for H5 machines
; Written by Diabase Engineering
; Last Updated: July 12, 2021

M118 S{"Info: Begin heatedbed.g"} L2
var NewSensorNum = #sensors.analog
var NewHeatNum = #heat.heaters

M308 S{var.NewSensorNum} P{global.BedTempPin} Y"thermistor" T100000 B3950 C0 A"Bed" ; Create new sensor assigned to pin defined in machinespecific.g. It's thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Bed"
M950 H{var.NewHeatNum} C{global.BedHeatPin} T{var.NewSensorNum} ; Create new heater using new sensor and bed heat pin as defined in machinespecific.g
M140 H{var.NewHeatNum} ; Define this heater as a bed heater
M143 H{var.NewHeatNum} S120 ; Limit Bed temperature to 120C
M307 H{var.NewHeatNum} R0.129 C700.000:700.000 D10.00 S1.00 V0.0 B1 I0 ; Set initial heater parameters
M118 S{"Info: End heatedbed.g"} L2
