; Macro file to disable CNC mode on slot 3 and to enable FFF mode on it
M451 ; Switch back to FFF mode
M307 H5 A400.0 C140.0 D5.5 S1.00 V0.0 B0 ; Configure heater 5
M563 P3 D0 H5 L-1 ; Define tool 3
;M567 P3 E1:1.05 ; Configure filament assist

