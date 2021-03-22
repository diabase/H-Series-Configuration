; Macro file to disable CNC mode on slot 4 and to enable FFF mode on it
M451 ; Switch back to FFF mode
M563 P4 D3:5 H4 L-1 ; Define tool 4
M567 P4 E1:1 ; Configure filament assist (e.g. 1.05 = 5% excess filament)

