; tcreate3.g
; Creates Tool 3
; Written by Diabase Engineering
; Last Updated: February 22, 2021

; Extruder Configurations
; M451 ; Switch to FFF mode - Possibly unnecessary. RT commented out for testing on 2/19/2021
M308 S3 P"duex.e4temp" Y"thermistor" T100000 B3950 C0 A"Nozzle 3" ; Create Sensor 3 assigned to duex.e4temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 3"
M950 H3 C"!exp.heater5" T3 ; Create Heater 3, assigned to inverse exp.heater5 pin using Sensor 3 for temperature sensing
M143 H3 S250 ; Monitor Heater 3 and throw an error if it exceeds 250C
M563 P3 D0:{#move.extruders-1} H3 L-1 S"Nozzle 3" ; Create Tool 3, use extruder drives 0 (extruder) and the highest numbered extruder drive (assist), Heater 3, no filament mapping, and call it "Nozzle 3"
M567 P3 E1:1 ; Drive Tool 3 with a 1:1 ratio between the extruder and filament assist

; Spindle Configurations
; M563 P3 F6 S"Spindle 3" ; Create tool 3 with fan 6 and call it "Spindle 3"
; M453 T3 S2 C"!exp.heater5" R12000 ; Assign tool 3 to spindle index 2, with PWM control on inverted pin "exp.heater5" and 12000 RPM achieved at full PWM
; M950 F6 C"duex.fan6" ; Spindle 3 Air Flow - Define Fan 6 to use pin duex.fan6
; M106 P6 S0 B0 L1 C"Spindle 3" ; Spindle 3 air flow
