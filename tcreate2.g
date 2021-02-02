; Create Tool 2
M563 P2 F5 S"Spindle 2" ; Create tool 2 with fan 5 and call it "Spindle 2"
M453 S1 T2 C"!exp.heater4" R12000 ; Assign tool 2 to spindle index 1, with PWM pin on heater 4 and 12000 RPM achieved at full PWM
