; tcreate5.g
; Creates Tool 5
; Written by Diabase Engineering
; Last Updated: May 12, 2021

; Extruder Configurations
M451 ; Switch to FFF mode 
M308 S5 P"1.temp2" Y"thermistor" T100000 B3950 C0 A"Nozzle 5" ; Create Sensor 5 assigned to "temp2" pin of extruder board, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 5"
M950 H5 C"1.out2" T5 ; Create Heater 5, assigned to inverse "out2" pin of extruder board using Sensor 5 for temperature sensing
M143 H5 S290 ; Monitor Heater 5 and throw an error if it exceeds 290C
M563 P5 D2:6 H5 L-1 S"Nozzle 5" ; Create Tool 5, use extruder Drives 2 (3rd extruder) and 6 (3rd assist), Heater 5, no filament mapping, and call it "Nozzle 5"
M567 P5 E1:1 ; Drive Tool 5 with a 1:1 ratio between the extruder and filament assist

; Spindle Configurations
; Tool 5 cannot be a spindle.
