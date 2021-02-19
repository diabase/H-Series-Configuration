; Create Tool 1
M451 ; Switch to FFF mode
M308 S1 P"2.temp2"  Y"thermistor" T100000 B3950 C0 A"Nozzle 1" ; Create Sensor 3 assigned to duex.e4temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 3"
M950 H1 C"2.out2" T1 ; Create Heater 3, assigned to inverse exp.heater5 pin using Sensor 3 for temperature sensing
M143 H1 S250 ; Monitor Heater 3 and throw an error if it exceeds 250C
M563 P1 D0:3 H1 S"Nozzle 1"; L-1 ; Define Tool 3 to use extruder drives 0 (extruder) and 3 (assist), Heater 3 and -1 filament mapping?
M567 P1 E1:1 ; Drive Tool 3 with a 1:1 ratio between the extruder and filament assist