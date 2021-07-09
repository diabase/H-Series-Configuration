; heatedbed.g
; Configures heated bed for H5 machines
; Written by Diabase Engineering
; Last Updated: July 9, 2021

var NewSensorNum = #sensors.analog
;echo "NewSensorNum is "^var.NewSensorNum
var NewHeatNum = #heat.heaters
;echo "NewHeatNum is"^var.NewHeatNum

M308 S{var.NewSensorNum} P{global.BedTempPin} Y"thermistor" T100000 B3950 C0 A"Bed" ; Create Sensor 0 assigned to temp0 pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Bed"
M950 H{var.NewHeatNum} C{global.BedHeatPin} T{var.NewSensorNum} ; Create Heater 0 using pin "out7p" and temperature sensor 0
M140 H{var.NewHeatNum} ; Define heater 0 as a bed heater
M143 H{var.NewHeatNum} S120 ; Limit Bed temperature to 120C
M307 H{var.NewHeatNum} R0.129 C700.000:700.000 D10.00 S1.00 V0.0 B1 I0
