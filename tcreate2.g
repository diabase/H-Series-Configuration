; Macro file to enable CNC mode on spindle 2 and to disable FFF mode
M563 P2 F5 S"Spindle 2" ; Define tool 2
M307 H4 A-1 C-1 D-1 ; Disable heater 4
M453 S1 T2 P4 R12000 ; Assign tool 2 and PWM channel of heater 4 to spindle 1
