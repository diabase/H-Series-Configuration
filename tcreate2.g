; tcreate2.g
; Creates Tool 2
; Written by Diabase Engineering
; Last Updated: February 22, 2021

; Extruder Configurations
; M451 ; Switch to FFF mode - Possibly unnecessary. RT commented out for testing on 2/19/2021
; M308 S2 P"duex.e3temp" Y"thermistor" T100000 B3950 C0 A"Nozzle 2" ; Create Sensor 2 assigned to duex.e3temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 2"
; M950 H2 C"!exp.heater4" T2 ; Create Heater 2, assigned to inverse exp.heater4 pin using Sensor 2 for temperature sensing
; M143 H2 S250 ; Monitor Heater 2 and throw an error if it exceeds 250C
; M563 P2 DXXX:{move.extruders-1} H2 L-1 S"Nozzle 2" ; Create Tool 2, use extruder drives XXX (extruder) and the highest numbered extruder drive (assist), Heater 2, no filament mapping, and call it "Nozzle 2"
; M567 P2 E1:1 ; Drive Tool 2 with a 1:1 ratio between the extruder and filament assist

; Spindle Configurations
M563 P2 F5 S"Spindle 2" ; Create tool 2 with fan 5 and call it "Spindle 2"
M453 T2 S1 C"!exp.heater4" R12000 ; Assign tool 2 to spindle index 1, with PWM control on inverted pin "exp.heater4" and 12000 RPM achieved at full PWM
M950 F5 C"duex.fan5" ; Spindle 2 Air Flow - Define Fan 5 to use pin duex.fan5
M106 P5 S0 B0 L1 C"Spindle 2" ; Spindle 2 air flow
