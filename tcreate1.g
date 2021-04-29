; Macro file to disable CNC mode on slot 1 and to enable FFF mode on it
M451 ; Switch back to FFF mode
M307 H3 A400 C140 D5.5 S1 B0 
;M307 H3 A392.6 C206 D5.3 S1 B0 ; Configure heater 3 for Hemera
;M563 P1 D0:5 H3 L-1 ; Define tool 1
M563 P1 D0:1 H3 L-1 F3; Define tool 1 martijn: adjusted for use with paste extruder -- dimitris: added fan 3 as the accompanied fan
;M567 P1 E4.375:1 adjusted for hemera
M567 P1 E1:1
