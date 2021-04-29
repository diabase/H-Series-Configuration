; Macro file to disable CNC mode on slot 2 and to enable FFF mode on it
M451 ; Switch back to FFF mode
M307 H4 A400 C140 D5.5 S1 B0 ; Configure heater 4
;M563 P2 D1:5 H4 L-1 ; Define tool 2
M563 P2 D0:1 H4 L-1 F3 ; Define tool 2 martijn: adjusted for use with paste extruder  -- dimitris: added fan 3 as the accompanied fan
M567 P2 E1:1