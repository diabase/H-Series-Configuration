; Macro file to disable CNC mode on slot 3 and to enable FFF mode on it
M451 ; Switch back to FFF mode
M308 S1 P"duex.e2temp"  Y"thermistor" T100000 B3950 C0 A"Nozzle 1"
M950 H1 C"!exp.heater3" T1
M563 P1 D0:4 H1 L-1 ; Define tool 1
M567 P1 E1:1.00 ; Configure filament assist
