; H4 Configuration File
; written by Diabase Engineering

; General preferences
G90 ; Send absolute coordinates...
M83 ; ...but relative extruder moves

; Drive orientation
M569 P0 S1 ; Set motor driver direction. Motor driver number 0 goes forwards (S1). (Line 21: X)
M569 P1 S0 ; Set motor driver direction. Motor driver number 1 goes backwards (S0). (Line 21: Y)
M569 P2 S0 ; Set motor driver direction. Motor driver number 2 goes backwards (S0). (Line 21: Z)
M569 P3 S0 ; Set motor driver direction. Motor driver number 3 goes backwards (S0). (Line21: U)
; M569 P4 S0 ; Set motor driver direction. Motor driver number 4 goes backwards (S0). (Unused)
; M569 P5 S1 ; Set motor driver direction. Motor driver number 5 goes forwards (S1). (Unused)
M569 P6 S0 ; Set motor driver direction. Motor driver number 6 goes backwards (S0). (Line21: E.1-5)
M569 P7 S0 ; Set motor driver direction. Motor driver number 7 goes backwards (S0) (Line21: E6)
M569 P8 S0 ; Set motor driver direction. Motor driver number 8 goes backwards (S0)  (Line21: V)

; Drive settings
M584 X0 Y1 Z2 U3 V8 E6:6:6:6:6:7 P5 ; Set driver mapping, E drive is multiplexed. Hide the extra axes
M208 X-196 Y-89 Z-10 U-10.2 V-100 S1 ; Set axis minima
M208 X196 Y89 Z235.64 U360 V200 S0 ; Set axis maxima
M350 X16 Y16 Z16 U16 V16 E16:16:16:16:16:16 I1 ; Configure microstepping with interpolation
M92 X66.405 Y80 Z640 U322.31 V1600 E96:96:96:96:96:96 ; Set steps per mm
M566 X600 Y600 Z300 U120 V500 E1200:1200:1200:1200:1200:1200 ; Set maximum instantaneous speed changes (mm/min)
M203 X20000 Y20000 Z3000 U9900 V10000 E6000:6000:6000:6000:6000:6000 ; Set maximum speeds (mm/min)
M201 X1200 Y1000 Z450 U600 V500 E250:250:250:250:250:250 ; Set accelerations (mm/s^2)
M906 X1600 Y1600 Z1800 U1400 V800 E1500:1500:1500:1500:1500:500 I30 ; Set motor currents (mA) and motor idle factor in per cent
M84 S5 ; Set idle timeout

; Endstops
M574 X1 S1 P"xstop" ; Configure X endstop position at low end, it's a microswitch on pin "xstop"
M574 Y1 S1 P"ystop" ; Configure Y endstop position at low end, it's a microswitch on pin "ystop"
M574 Z1 S1 P"zstop" ; Configure Z endstop position at low end, it's a microswitch on pin "zstop"
M574 U1 S1 P"e0stop" ; Configure U endstop position at low end, it's a microswitch on pin "e0stop"
M574 V2 S1 P"e1stop" ; Configure V endstop position at high end, it's a microswitch on pin "e1stop"
M574 A1 S1 P"duex.e2stop" ; Configure A endstop position at high end, it's a microswitch on pin "duex.e2stop"
M574 C1 S1 P"duex.e3stop" ; Configure C endstop position at high end, it's a microswitch on pin "duex.e3stop"

;M574 V2 S0 ; Define active low microswitches
M558 K0 P5 C"^zprobe.in" H2 F150 T12000 ; Set Z probe type to switch, probing height and the probe + travel speeds
M558 K1 P8 C"duex.e4stop" I0 F200 T12000 ; Additional Z probe used for touchoff
G31 Z0.0 ; Set Z probe trigger height

; Temperature sensors
M308 S0 P"bedtemp"      Y"thermistor" T100000 B3950 C0 A"Bed" ; Create Sensor 0 assigned to bedtemp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Bed"
;M308 S1 P"e0temp"       Y"thermistor" T100000 B3950 C0         ; E0_HEATER is unused
;M308 S2 P"e1temp"       Y"thermistor" T100000 B3950 C0         ; E1_HEATER is used for the dry cabinet, see below
;other sensors defined in tcreate#.g files

; Heaters
M950 H0 C"bedheat" T0 ; Create Heater 0, call it "bedheat", and use temperature sensor 0
M140 H0 ; Define heater 0 as a bed heater
;other heaters defined in tcreate#.g files

; Temperature limits
M143 H0 S120 ; Limit Bed temperature to 120C
M302 S150 ; Set minimum extrude temp

; Fan definition
M950 F0 C"nil"         ; free up fan
M950 F1 C"fan1" ; Create Fan 1 and assign it to pin fan1
M950 F2 C"nil"         ; free up fan
M950 F3 C"duex.fan3"
; M950 F3 C"nil"
M950 F4 C"duex.fan4" ; Create Fan 4 and assign it to pin duex.fan4
M950 F5 C"duex.fan5" ; Create Fan 5 and assign it to pin duex.fan5
;M950 F6 C"duex.fan6"
;M950 F7 C"duex.fan7"
M950 F8 C"duex.fan8"

; Servo pins (for M42)
M950 P0 C"fan0" ; Was M42 P20 ; Create GPIO pin 0 and assign it to pin fan0
M950 P1 C"fan2" ; Was M42 P22 ; Create GPIO pin 1 and assign it to pin fan2
M950 P2 C"duex.gp1" ; Was M42 P100 ; Create GPIO pin 2 and assign it to duex.gp1
M950 P3 C"duex.gp2" ; Was M42 P101 ; Create GPIO pin 3 and assign it to duex.gp2
M950 P4 C"duex.gp3" ; Was M42 P102 ; Create GPIO pin 4 and assign it to duex.gp3
M950 P5 C"duex.gp4" ; Was M42 P103 ; Create GPIO pin 5 and assign it to duex.gp4

; Tools
M98 P"tcreate1.g"
M98 P"tcreate2.g"
M98 P"tcreate3.g"
M98 P"tcreate4.g"
M98 P"tcreate5.g"

M563 P10 S"Probe"

M501 ; Set active parameters to those stored in config-override.g

; Dry Cabinet
M98 P"drycabinet.g"

; Network
M550 P"H4010" ; Set machine name
M552 S1 ; Enable network

; Fan configuration
M106 P1 H3:4:5:6:7 T50 ; Nozzle fan
M106 P3 C"Layer fan" 


; Miscellaneous
M911 S22 R23 P"M98 P""estop.g"""  ; Run estop.g on power loss during a print
M575 P1 B250000 ; Set up UART for pendant input
M750 ; Enable scanner