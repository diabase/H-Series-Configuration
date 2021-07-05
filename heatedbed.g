; heatedbed.g
; Configures heated bed for H4 machines
; Written by Diabase Engineering
; Last Updated: February 19, 2021

M308 S0 P"temp0" Y"thermistor" T100000 B3950 C0 A"Bed" ; Create Sensor 0 assigned to temp0 pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Bed"
M950 H0 C"out7" T0 ; Create Heater 0 using pin "out7p" and temperature sensor 0
M140 H0 ; Define heater 0 as a bed heater
M143 H0 S120 ; Limit Bed temperature to 120C
