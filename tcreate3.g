; Macro file to disable CNC mode on slot 3 and to enable FFF mode on it
M451 ; Switch back to FFF mode

M308 S3 P"duex.e4temp"  Y"thermistor" T100000 B3950 C0 A"Nozzle 3"
M950 H3 C"!exp.heater5" T3
M143 H3 S290 ; Limit H5/E4 temperature to 290C
M563 P3 D1:4 H3 L-1 ; Define tool 3
M567 P3 E1:1 ; Configure filament assist