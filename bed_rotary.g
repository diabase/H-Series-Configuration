M291 P"Edit bed_rotary.g AND USE ROTARY AXES TAB to define mesh area for rotary axis" R"First open" S3
;UNCOMMENT ALL GCODE LINES

;T10 								;bring up probe
;M561								;ensure user coordinated

;G1 X0 Y-5 Z3 F8000 				;go to starting position
;G30 								;probe once to find Z=0
;M557 X-100:100 Y-180:180 S50:40	;define mesh levelling
;G29 								;run mesh levelling
