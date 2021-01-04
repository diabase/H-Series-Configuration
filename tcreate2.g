; Create Tool 2
M451 ; Switch to FFF mode
M308 S2 P"duex.e3temp"  Y"thermistor" T100000 B3950 C0 A"Nozzle 2" ; Create Sensor 2 assigned to duex.e3temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 2"
M950 H2 C"!exp.heater4" T2 ; Create Heater 2, assigned to inverse exp.heater3 pin using Sensor 2 for temperature sensing
M143 H2 S290 ; Monitor Heater 2 and throw an error if it exceeds 290C
M563 P2 D1 H2 L-1 ; Define Tool 2 to use extruder drives 1 (extruder), Heater 2 and no filament mapping
; M567 P2 E1:1 ; Drive Tool 2 with a 1:1 ratio between the extruder and filament assist
