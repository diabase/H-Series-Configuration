; Create Tool 4
M451 ; Switch to FFF mode
M308 S4 P"duex.e5temp" Y"thermistor" T100000 B3950 C0 A"Nozzle 4" ; Create Sensor 4 assigned to duex.e5temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 4"
M950 H4 C"!exp.heater6" T4 ; Create Heater 4, assigned to inverse exp.heater6 pin using Sensor 4 for temperature sensing
M143 H4 S250 ; Monitor Heater 4 and throw an error if it exceeds 250C
M563 P4 D1:3 H4 L-1 S"Nozzle 4" ; Create Tool 4, use extruder drives 1 (extruder) and 3 (assist), Heater 4, no filament mapping, and call it "Nozzle 4"
M567 P4 E1:1 ; Drive Tool 4 with a 1:1 ratio between the extruder and filament assist
