; heatedbed.g
; Configures heated bed for H5 machines
; Written by Diabase Engineering
; Last Updated: July 26, 2021

M118 S{"Info: Begin heatedbed.g"} L2

if global.BedSensorNum == -1
    M118 S{"Info: Setting global.BedSensorNum to next available sensor number."} L2
    set global.BedSensorNum = #sensors.analog

if global.BedHeaterNum == -1
    M118 S{"Info: Setting global.BedHeaterNum to next available heater number."} L2
    set global.BedHeaterNum = #heat.heaters

M118 S{"Info: Creating sensors.analog[" ^ {global.BedSensorNum} ^"] on pin " ^ {global.BedTempPin} ^ " for use with a bed heater"} L2
M308 S{global.BedSensorNum} P{global.BedTempPin} Y"thermistor" T100000 B3950 C0 A"Bed" ; Create new sensor assigned to pin defined in defaultparameters.g. It's thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Bed"
M118 S{"Info: Creating heat.heaters[" ^ {global.BedHeaterNum} ^"] on pin " ^ {global.BedHeatPin} ^ " to be monitored by sensors.analog[" ^ {global.BedSensorNum} ^ "] for use as a bed heater"} L2
M950 H{global.BedHeaterNum} C{global.BedHeatPin} T{global.BedSensorNum} ; Create new heater using new sensor and bed heat pin as defined in defaultparameters.g
M118 S{"Info: Registering heat.heaters[" ^ {global.BedHeaterNum} ^"] as a bed heater"} L2
M140 H{global.BedHeaterNum} ; Define this heater as a bed heater
M143 H{global.BedHeaterNum} S120 ; Limit Bed temperature to 120C
M307 H{global.BedHeaterNum} R0.111 C1212.519:1212.519 D20.84 S1.00 V24.0 B1 I0 ; Set initial heater parameters

set global.HeatedBedLastRun = state.upTime

M118 S{"Info: End heatedbed.g"} L2
