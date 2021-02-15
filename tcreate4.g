; Macro file to enable CNC mode on spindle 1 and to disable FFF mode
M563 P4 F7 S"Spindle 4" ; Define tool 4
M453 S3 T4 C"!exp.heater6" R12000 ; Assign tool 1 and PWM channel of heater 3 to spindle 0