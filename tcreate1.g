; Macro file to enable CNC mode on spindle 1 and to disable FFF mode
M563 P1 F4 S"Spindle 1" ; Define tool 1
M453 S0 T1 C"!exp.heater3" R12000 ; Assign tool 1 and PWM channel of heater 3 to spindle 1