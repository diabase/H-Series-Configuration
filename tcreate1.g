; Macro file to enable CNC mode on spindle 1 and to disable FFF mode
M563 P1 F4 S"Spindle 1" ; Define tool 1
M307 H3 A-1 C-1 D-1 ; Disable heater 3
M453 S0 T1 P3 R12000 ; Assign tool 1 and PWM channel of heater 3 to spindle 0
