; tcreate1.g
; Creates Tool 1
; Written by Diabase Engineering
; Last Updated: May 12, 2021

; Extruder Configurations
M451 ; Switch to FFF mode
M308 S1 P"1.temp0" Y"thermistor" T100000 B3950 C0 A"Nozzle 1" ; Create Sensor 1 assigned to duex.e2temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 1"
M950 H1 C"1.out0" T1 ; Create Heater 1, assigned to inverse exp.heater3 pin using Sensor 1 for temperature sensing
M143 H1 S250 ; Monitor Heater 1 and throw an error if it exceeds 250C
M563 P1 D0:3 H1 L-1 S"Nozzle 1" ; Create Tool 1, use extruder drives XXX (extruder) and the highest numbered extruder drive (assist), Heater 1, no filament mapping, and call it "Nozzle 1"
M567 P1 E1:1 ; Drive Tool 1 with a 1:1 ratio between the extruder and filament assist
