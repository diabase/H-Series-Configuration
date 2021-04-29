; Macro file to disable CNC mode on slot 4 and to enable FFF mode on it
M451 ; Switch back to FFF mode
M307 H6 A400 C140 D5.5 S1 B0 ; Configure heater 6
M563 P4 D3:5 H6 L-1 ; Define tool 4
M567 P4 E1:1.1 ; Configure filament assist

