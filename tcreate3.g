; Macro file to disable CNC mode on slot 3 and to enable FFF mode on it
M451 ; Switch back to FFF mode
M563 P3 D2:5 H3 L-1 ; Define tool 3
M567 P3 E1:1 ; Configure filament assist