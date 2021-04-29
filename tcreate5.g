; Macro file to create an extrusion tool with heater 7
M451 ; Switch back to FFF mode
M307 H7 A400 C140 D5.5 S1 B0 ; Configure heater 7
;M563 P5 D4:5 H7 L-1 ; Define tool 5
M563 P5 D0:1 H7 L-1 F3; Define tool 5 martijn: adjusted for use with paste extruder  -- dimitris: added fan 3 as the accompanied fan
M567 P5 E1:1 ; Configure filament assist
