; Macro file to enable CNC mode on spindle 3 and to disable FFF mode
M563 P4 F7 S"Spindle 4" ; Define tool 4
M307 H6 A-1 C-1 D-1 ; Disable heater 6
M453 S3 T4 P6 R13000 ; Assign tool 4 and PWM channel of heater 6 to spindle 3

