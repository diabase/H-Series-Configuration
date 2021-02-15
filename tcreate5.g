; Macro file to create an extrusion tool with heater 7
M451 ; Switch back to FFF mode
M308 S5 P"duex.e6temp"  Y"thermistor" T100000 B3950 C0 A"Nozzle 5"
M950 H5 C"!exp.heater7" T5
M143 H5 S290 ; Limit H6/E5 temperature to 250C
M563 P5 D3:4 H5 L-1 ; Define tool 5
M567 P5 E1:1 ; Configure filament assist
