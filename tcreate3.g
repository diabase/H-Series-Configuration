; Macro file to enable CNC mode on spindle 1 and to disable FFF mode
M563 P2 F5 S"Spindle 2" ; Define tool 2
M307 H5 A-1 C-1 D-1 ; Disable heater 5
M453 S2 T2 C"!exp.heater4" R12000 ; Assign tool 1 and PWM channel of heater 3 to spindle 0