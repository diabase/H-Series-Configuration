; tcreate3.g
; Creates Tool 3
; Written by Diabase Engineering
; Last Updated: February 22, 2021

; Extruder Configurations
; M451 ; Switch to FFF mode - Possibly unnecessary. RT commented out for testing on 2/19/2021
;M308 S3 P"2.temp0" Y"thermistor" T100000 B3950 C0 A"Nozzle 3" ; Create Sensor 3 assigned to duex.e4temp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 3"
;M950 H3 C"2.out0" T3 ; Create Heater 3, assigned to inverse exp.heater5 pin using Sensor 3 for temperature sensing
;M143 H3 S280 ; Monitor Heater 3 and throw an error if it exceeds 250C
;M563 P3 D0:{#move.extruders-1} H3 L-1 S"Nozzle 3" ; Create Tool 3, use extruder drives 0 (extruder) and the highest numbered extruder drive (assist), Heater 3, no filament mapping, and call it "Nozzle 3"
;M567 P3 E1:1 ; Drive Tool 3 with a 1:1 ratio between the extruder and filament assist

; Spindle Configurations
M950 F3 C"out8" ; Spindle 2 Air Flow - Define Fan 5 to use pin duex.fan5
M950 F4 C"out9" ; Spindle collet closer
M106 P3 S0 B0 L1 C"T2 Air" ; Spindle 2 air flow
M106 P4 S0 B0 L1 C"Spin Collet"

M453 T3 S0 C"io5.out+nil+!io6.out" R12000 ; Assign tool 2 to spindle index 1, with PWM control on inverted pin "exp.heater4" and 12000 RPM achieved at full PWM
