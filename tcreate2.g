; Macro file to enable CNC mode on spindle 1 and to disable FFF mode
M563 P2 F4 S"Spindle 2" ; Define tool 2
M453 S1 T2 C"!exp.heater4" R12000 ; Assign tool 2 and PWM channel of heater 4 to spindle 2
M106 P5 S0 B0 L1 C"Spindle 2" ; Spindle 2 air flow