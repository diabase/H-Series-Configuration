; Create Tool 3
M451 ; Switch to FFF mode
M308 S3 P"duex.e4temp"  Y"thermistor" T100000 B3950 C0 A"Nozzle 3" ; Create Sensor 3 assigned to duex.e4temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 3"
M950 H3 C"!exp.heater5" T3 ; Create Heater 3, assigned to inverse exp.heater5 pin using Sensor 3 for temperature sensing
M143 H3 S290 ; Monitor Heater 3 and throw an error if it exceeds 290C
M563 P3 D2 H3 L-1 ; Define Tool 3 to use extruder drives 2 (extruder), Heater 3 and no filament mapping
; M567 P3 E1:1 ; Drive Tool 3 with a 1:1 ratio between the extruder and filament assist
