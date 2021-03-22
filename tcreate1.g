; Macro file to disable CNC mode on slot 3 and to enable FFF mode on it
M451 ; Switch back to FFF mode
M307 H1 A340.0 C140.0 D5.5 S1.00 V0.0 B0
M563 P1 D0:5 H1 L-1 ; Define tool 3
M567 P1 E1:1 ; Configure filament assist