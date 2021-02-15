M291 P"Edit bed_flat.g to define mesh area for flat bed" R"First open" S3
;UNCOMMENT ALL GCODE LINES

T10 							;bring up probe
M561							;ensure user coordinated

G1 X-100 Y0 Z3 F8000 			;go to starting position
G30 							;probe once to find Z=0
M557 X-180:180 Y-90:90 S90:90	;define mesh levelling
G29 							;run mesh levelling

