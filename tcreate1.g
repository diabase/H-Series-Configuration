; Create Tool 1
M451 ; Switch to FFF mode
M308 S1 P"duex.e2temp"  Y"thermistor" T100000 B3950 C0 A"Nozzle 1" ; Create Sensor 1 assigned to duex.e2temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 1"
M950 H1 C"!exp.heater3" T1 ; Create Heater 1, assigned to inverse exp.heater3 pin using Sensor 1 for temperature sensing
M143 H1 S290 ; Monitor Heater 1 and throw an error if it exceeds 290C
M563 P1 D0 H1 L-1 ; Define Tool 1 to use extruder drives 0 (extruder), Heater 1 and no filament mapping
; M567 P1 E1:1 ; Drive Tool 1 with a 1:1 ratio between the extruder and filament assist
