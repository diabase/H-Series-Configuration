; Macro file to enable CNC mode on spindle 1 and to disable FFF mode
M563 P2 S"Spindle 2" ; Create tool 1 with fan 4 and call it "Spindle 1"
M453 S0 T2 C"io7.out+io8.out+io1.out" F100 R12000 ; Assign tool 1 to spindle index 0, with PWM pin on heater 3 and 12000 RPM achieved at full PWM