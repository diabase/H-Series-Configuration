; tcreate5.g
; Creates Tool 5
; Written by Diabase Engineering
; Last Updated: May 12, 2021

; Extruder Configurations - PLACEHOLDER 5/12/21 BY AR. NEED TOOL DEFINED, BUT CAN'T CONTROL IT YET
; M451 ; Switch to FFF mode
M308 S5 P"2.temp1" Y"thermistor" T100000 B3950 C0 A"Nozzle 5" ; Create Sensor 5 assigned to duex.e6temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 5"
M950 H5 C"2.out1" T5 ; Create Heater 5, assigned to inverse exp.heater7 pin using Sensor 5 for temperature sensing
M143 H5 S290 ; Monitor Heater 5 and throw an error if it exceeds 290C
M563 P5 D1:3 H5 L-1 S"Nozzle 5" ; Create Tool 5, use extruder Drives 2 (extruder) and the highest numbered extruder drive (assist), Heater 5, no filament mapping, and call it "Nozzle 5"
M567 P5 E1:1 ; Drive Tool 5 with a 1:1 ratio between the extruder and filament assist

