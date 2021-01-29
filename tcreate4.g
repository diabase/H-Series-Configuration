; Macro file to enable CNC mode on spindle 1 and to disable FFF mode
M563 P4 S"Spindle 4" ; Create tool 1 with fan 4 and call it "Spindle 1"
M453 S2 T4 C"io5.out" F100 R12000 ; Assign tool 1 to spindle index 0, with PWM pin on heater 3 and 12000 RPM achieved at full PWM
