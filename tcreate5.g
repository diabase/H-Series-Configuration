; Create Tool 5
M451 ; Switch to FFF mode
M308 S5 P"duex.e6temp" Y"thermistor" T100000 B3950 C0 A"Nozzle 5" ; Create Sensor 5 assigned to duex.e6temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 5"
M950 H5 C"!exp.heater7" T5 ; Create Heater 5, assigned to inverse exp.heater7 pin using Sensor 5 for temperature sensing
M143 H5 S290 ; Monitor Heater 5 and throw an error if it exceeds 290C
M563 P5 D2:3 H5 L-1 ; Define Tool 5 to use extruder drives 2 (extruder) and 3 (assist), Heater 5 and -1 filament mapping?
M567 P5 E1:1 ; Drive Tool 4 with a 1:1 ratio between the extruder and filament assist
