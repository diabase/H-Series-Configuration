; Macro file to disable CNC mode on slot 2 and to enable FFF mode on it
M451 ; Switch back to FFF mode
M307 H2 A340.0 C140.0 D5.5 S1.00 V0.0 B0
M563 P2 D1:5 H2 L-1 ; Define tool 3
M567 P2 E1:1 ; Configure filament assist