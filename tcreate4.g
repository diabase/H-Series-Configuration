; tcreate4.g
; Creates Tool 4
; Written by Diabase Engineering
; Last Updated: May 12, 2021

; Extruder Configurations
; M451 ; Switch to FFF mode - Possibly unnecessary. RT commented out for testing on 2/19/2021
;M308 S4 P"duex.e5temp" Y"thermistor" T100000 B3950 C0 A"Nozzle 4" ; Create Sensor 4 assigned to duex.e5temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 4"
;M950 H4 C"!exp.heater6" T4 ; Create Heater 4, assigned to inverse exp.heater6 pin using Sensor 4 for temperature sensing
;M143 H4 S250 ; Monitor Heater 4 and throw an error if it exceeds 250C
;M563 P4 D1:{#move.extruders-1} H4 L-1 S"Nozzle 4" ; Create Tool 4, use extruder drives 1 (extruder) and the highest numbered extruder drive (assist), Heater 4, no filament mapping, and call it "Nozzle 4"
;M567 P4 E1:1 ; Drive Tool 4 with a 1:1 ratio between the extruder and filament assist

; Spindle Configurations
M950 F4 C"out6" ; Spindle 4 Air Flow - Define Fan 4 to use pin out6
M106 P4 S0 B0 L1 C"T4 Air" ; Spindle 4 air flow
M563 P4 F4 S"Spindle 4" ; Create tool 4 with fan 7 and call it "Spindle 4"
M453 T4 S1 C"io5.out+nil+io6.out" F100 R12000 ; Assign tool 4 to spindle index 1, with PWM control on pin "io5" direction on "io6" and 12000 RPM achieved at full PWM

