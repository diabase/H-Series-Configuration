; Macro file to disable CNC mode on slot 1 and to enable FFF mode on it
M451 ; Switch back to FFF mode
M307 H3 A400 C140 D5.5 S1 B0 ; Configure heater 3
M563 P1 D0:5 H3 L-1 ; Define tool 1
M567 P1 E1:1.1
