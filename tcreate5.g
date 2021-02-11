; Macro file to create an extrusion tool with heater 7
M451 ; Switch back to FFF mode
M307 H7 A400 C140 D5.5 S1 B0 ; Configure heater 7
M563 P5 D2:3 H5 L-1 ; Define tool 5
M567 P5 E1:1 ; Configure filament assist (e.g. 1.05 = 5% excess filament)
