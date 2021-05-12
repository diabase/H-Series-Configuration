; tcreate1.g
; Creates Tool 1
; Written by Diabase Engineering
; Last Updated: May 12, 2021

; Extruder Configurations
M451 ; Switch to FFF mode - Possibly unnecessary. RT commented out for testing on 2/19/2021
M308 S1 P"1.temp0" Y"thermistor" T100000 B3950 C0 A"Nozzle 1" ; Create Sensor 1 assigned to temp0 of extruder board, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle 1"
M950 H1 C"1.out0" T1 ; Create Heater 1, assigned to OUT0 of extruder board using Sensor 1 for temperature sensing
M143 H1 S250 ; Monitor Heater 1 and throw an error if it exceeds 250C
M563 P1 D0:3 H1 L-1 S"Nozzle 1" ; Create Tool 1, use extruder drives 0 (first extruder) and 3 (first filament assist) extruder drive (assist), Heater 1, no filament mapping, and call it "Nozzle 1"
M567 P1 E1:1 ; Drive Tool 1 with a 1:1 ratio between the extruder and filament assist

; Spindle Configurations
;M563 P1 F4 S"Spindle 1" ; Create tool 1 with fan 4 and call it "Spindle 1"
;M453 T1 S0 C"!exp.heater3" R12000 ; Assign tool 1 to spindle index 0, with PWM control on inverted pin "exp.heater3" and 12000 RPM achieved at full PWM
;M950 F4 C"duex.fan4" ; Spindle 1 Air Flow - Define Fan 4 to use pin duex.fan4
;M106 P4 S0 B0 L1 C"Spindle 1" ; Spindle 1 air flow
