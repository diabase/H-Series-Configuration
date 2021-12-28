; heatedbed.g
; Configures heated bed for H5 machines
; Written by Diabase Engineering
; Last Updated: December 06, 2021

M118 S{"Info: Begin heatedbed.g"} L2

if global.bedSensorNum == -1
    set global.bedSensorNum = #sensors.analog
M118 S{"Info: Creating sensors.analog[" ^ {global.bedSensorNum} ^"] on pin " ^ {global.bedTempPin} ^ " for use with a bed heater"} L2
M308 S{global.bedSensorNum} P{global.bedTempPin} Y"thermistor" T100000 B3950 C0 A"Bed" ; Create new sensor assigned to pin defined in defaultparameters.g. It's thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Bed"

if global.bedHeaterNum == -1
    set global.bedHeaterNum = #heat.heaters
M118 S{"Info: Creating heat.heaters[" ^ {global.bedHeaterNum} ^"] on pin " ^ {global.bedHeatPin} ^ " to be monitored by sensors.analog[" ^ {global.bedSensorNum} ^ "] for use as a bed heater"} L2
M950 H{global.bedHeaterNum} C{global.bedHeatPin} T{global.bedSensorNum} ; Create new heater using new sensor and bed heat pin as defined in defaultparameters.g
M118 S{"Info: Registering heat.heaters[" ^ {global.bedHeaterNum} ^"] as a bed heater"} L2
M140 H{global.bedHeaterNum} ; Define this heater as a bed heater
M143 H{global.bedHeaterNum} S120 ; Limit Bed temperature to 120C
M307 H{global.bedHeaterNum} R0.111 C1212.519:1212.519 D20.84 S1.00 V24.0 B1 I0 ; Set initial heater parameters

set global.heatedBedLastRun = state.upTime

M118 S{"Info: End heatedbed.g"} L2
