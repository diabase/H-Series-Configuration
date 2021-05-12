; tcreate2.g
; Creates Tool 2
; Written by Diabase Engineering
; Last Updated: May 12, 2021

; Extruder Configurations
M451 ; Switch to FFF mode - Possibly unnecessary. RT commented out for testing on 2/19/2021
M308 S2 P"1.temp1" Y"thermistor" T100000 B3950 C0 A"Nozzle 2" ; Create Sensor 2 assigned to duex.e3temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 2"
M950 H2 C"1.out1" T2 ; Create Heater 2, assigned to inverse exp.heater4 pin using Sensor 2 for temperature sensing
M143 H2 S250 ; Monitor Heater 2 and throw an error if it exceeds 250C
M563 P2 D1:4 H2 L-1 S"Nozzle 2" ; Create Tool 2, use extruder drives XXX (extruder) and the highest numbered extruder drive (assist), Heater 2, no filament mapping, and call it "Nozzle 2"
M567 P2 E1:1 ; Drive Tool 2 with a 1:1 ratio between the extruder and filament assist

