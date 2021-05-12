; tcreate3.g
; Creates Tool 3
; Written by Diabase Engineering
; Last Updated: May 12, 2021

; Spindle Configurations
M950 F3 C"out8" ; Spindle air flow
M950 F4 C"out9" ; Spindle collet closer
M106 P3 S0 B0 L1 C"T2 Air" ; Spindle air flow
M106 P4 S0 B0 L1 C"Spin Collet" ;DEFINED AS A FAN NOW, WILL CHANGE TO M42 IN FUTURE
M563 P3 F3 S"Spindle 3" ; Create tool 3 with fan 3 and call it "Spindle 3"
M453 T3 S0 C"io5.out+nil+!io6.out" R12000 ; Assign tool 3 to spindle index 0, with PWM control on pin "io5.out", direction on inverted pin "io6.out"and 12000 RPM achieved at full PWM
