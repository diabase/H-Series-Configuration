; Macro file to create an extrusion tool with heater 7
M451 ; Switch back to FFF mode
M307 H7 A400 C140 D5.5 S1 B0 ; Configure heater 7
M563 P5 D2 H5 L-1 ; Define tool 5

