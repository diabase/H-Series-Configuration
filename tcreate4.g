; Macro file to disable CNC mode on slot 4 and to enable FFF mode on it
M451 ; Switch back to FFF mode
M308 S4 P"duex.e5temp"  Y"thermistor" T100000 B3950 C0 A"Nozzle 4"
M950 H4 C"!exp.heater6" T4
M143 H4 S250 ; Limit H6/E5 temperature to 250C
M563 P4 D1:3 H4 L-1 ; Define tool 4
M567 P4 E1:1 ; Configure filament assist (e.g. 1.05 = 5% excess filament)

