; H4 Configuration File
; written by Diabase Engineering
; M929 P"eventlog.txt" S3 ; start logging to file eventlog.txt (S0 = stop logging, S1 = log level WARN, S2 = log level INFO, S3 = log level DEBUG)

; General preferences
G90 ; Absolute Positioning
M83 ; Relative Extrusions

; Drive orientation
M569 P0 S1 ; Set motor driver direction. Motor driver number 0 goes forwards  (S1). Line 22: X (Linear)
M569 P0 S0 ; Set motor driver direction. Motor driver number 1 goes forwards  (S1). Line 22: Y (Linear)
M569 P2 S0 ; Set motor driver direction. Motor driver number 2 goes backwards (S0). Line 22: Z (Linear)
M569 P3 S0 ; Set motor driver direction. Motor driver number 3 goes backwards (S0). Line 22: U (Turret)
M569 P4 S0 ; Set motor driver direction. Motor driver number 4 goes backwards (S0). Line 22: A (Rotary)
M569 P5 S1 ; Set motor driver direction. Motor driver number 5 goes forwards  (S1). Line 22: C (Rotary)
M569 P6 S0 ; Set motor driver direction. Motor driver number 6 goes backwards (S0). Line 22: E:1-3 (Extruders)
M569 P7 S1 ; Set motor driver direction. Motor driver number 7 goes forwards  (S1). Line 22: W (Cleaning Station)
M569 P8 S1 ; Set motor driver direction. Motor driver number 8 goes forwards  (S1). Line 22: V (Turret Lock)
M569 P9 S0 ; Set motor driver direction. Motor driver number 9 goes backwards (S0). Line 22: E4 (Filament Assist)

; Drive settings
M584 X0 Y1 Z2 U3 V8 W7 E6:6:6:9 A4 C5 ; Set driver mapping, E drive is multiplexed. Hide the extra axes
M208 X-208 Y-90 Z-10 U-9.2 V-100 W0 A-365 C-1000 S1 ; Set axis minima
M208 X208 Y90 Z210 U360 V200 W35 A365 C10000 S0 ; Set axis maxima
M350 X16 Y16 Z16 U16 V16 W16 A16 C16 E16:16:16:16 I1 ; Configure microstepping with interpolation
M92 X320 Y320 Z640 U322.31 V1600 W800 A53.33 C53.33 E96:96:96:96 ; Set steps per mm
M566 X300 Y300 Z300 U120 V500 W500 A1000 C1000 E1200:1200:1200:1200 ; Set maximum instantaneous speed changes (mm/min)
M203 X12000 Y12000 Z3000 U8900 V10000 W20000 A20000 C20000 E6000:6000:6000:6000 ; Set maximum speeds (mm/min)
M201 X600 Y600 Z450 U600 V500 W500 A600 C600 E250:250:250:250 ; Set accelerations (mm/s^2)
M906 X1800 Y2100 Z1800 U1200 V800 W800 A1600 C1600 E1500:1500:1500:500 I30 ; Set motor currents (mA) and motor idle factor percent
M84 S5 ; Allow all motors to drop hold current to idle after 5 seconds

; Endstops
M574 X1 S1 P"xstop" ; Configure X endstop position at low end, it's a microswitch on pin "xstop"
M574 Y1 S1 P"ystop" ; Configure Y endstop position at low end, it's a microswitch on pin "ystop"
M574 Z2 S1 P"zstop" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
M574 U1 S1 P"e0stop" ; Configure U endstop position at low end, it's a microswitch on pin "e0stop"
M574 V0 S1 P"e1stop" ; Configure V endstop position at no end, it's a microswitch on pin "e1stop"
M574 A1 S1 P"duex.e2stop" ; Configure A endstop position at low end, it's a microswitch on pin "duex.e2stop"
M574 C1 S1 P"duex.e3stop" ; Configure C endstop position at low end, it's a microswitch on pin "duex.e3stop"

;M574 V2 S0 ; Define active low microswitches
M558 K0 P5 C"^zprobe.in" H2 F150 T12000 ; Set Z probe type for Probe 0 (Tool 10). It's a normally closed switch between the "zprobe.in" pin and ground using the internal pullup resistor, 2mm dive height, 150mm/min probing speed, and 12000 mm/min travel speed between probe points
M558 K1 P8 C"duex.e4stop" I0 F200 T12000 ; Set Z probe type for Probe 1 (touchoff plate). It's an unfiltered normally closed switch between the "duex.e4stop" pin and ground, non-inverted probe reading, 200mm/min probing speed, and 12000 mm/min travel speed between probe points
G31 Z0 ; Set Z probe trigger height to 0mm

; Temperature sensors
M308 S0 P"bedtemp" Y"thermistor" T100000 B3950 C0 A"Bed" ; Create Sensor 0 assigned to bedtemp pin, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Bed"
; Other sensors defined in drycabinet.g and tcreate#.g files

; Heaters
M950 H0 C"bedheat" T0 ; Create Heater 0 using pin "bedheat" and temperature sensor 0
M140 H0 ; Define heater 0 as a bed heater
; Other heaters defined in drycabinet.g and tcreate#.g files

; Temperature limits
M143 H0 S120 ; Limit Bed temperature to 120C
M302 S150 ; Set minimum extrude temp

; Fan definition
M950 F1 C"fan1"         ; Extruder Cooling Fans - Define Fan 1 to use pin fan1
M950 F3 C"duex.fan3"    ; Tool/Layer Fans - Define Fan 3 to use pin duex.fan3
M950 F4 C"duex.fan4"    ; Spindle 1 Air Flow - Define Fan 4 to use pin duex.fan4
M950 F5 C"duex.fan5"    ; Spindle 2 Air Flow - Define Fan 5 to use pin duex.fan5
; M950 F6 C"duex.fan6"    ; Spindle 3 Air Flow - Define Fan 6 to use pin duex.fan6
; M950 F7 C"duex.fan7"    ; Spindle 4 Air Flow - Define Fan 7 to use pin duex.fan7
M950 F8 C"duex.fan8"    ; Cleaning Station Vacuum - Define Fan 8 to use pin duex.fan8

; Fan configuration
M106 P1 H3:4:5 T50 ; Extruder Fans - Configure Fan 1: Turn on when heater 3, 4, or 5 reach the trigger temperature of 50C
M106 P3 C"Tool Fan" ; Tool/Layer Fans - Configure Fan 3
M106 P4 S0 B0 L1.0 C"Spindle 1" ; Spindle 1 air flow
M106 P5 S0 B0 L1.0 C"Spindle 2" ; Spindle 2 air flow
; M106 P6 S0 B0 L1.0 C"Spindle 3" ; Spindle 3 air flow
; M106 P7 S0 B0 L1.0 C"Spindle 4" ; Spindle 4 air flow
M106 P8 S0 B0 L1 C"Vacuum" ; I/O Pin for Cleaning Station Vacuum Relay - Configure Fan 8: Speed 0, Blip Time 0, Minimum Fan Speed 1, and call it "Cleaning Station Vacuum"

; GPIO pins (for M42)
M950 P0 C"fan0" ; Cleaning Station, Station Extension Solenoid (if equipped) - Define GPIO Pin 0 to use pin "fan0"
M950 P1 C"fan2" ; Cleaning Station, Pliers-Closing Solenoid - Define GPIO Pin 1 to use pin "fan2"
M950 P2 C"duex.gp1" ; Extruder Multiplexer and Spindle Enable - Define GPIO Pin 2 to use pin "duex.gp1"
M950 P3 C"duex.gp2" ; Extruder Multiplexer and Spindle Enable - Define GPIO Pin 3 to use pin "duex.gp2" 
M950 P4 C"duex.gp3" ; Extruder Multiplexer and Spindle Enable - Define GPIO Pin 4 to use pin "duex.gp3" 
M950 P5 C"duex.gp4" ; Extruder Multiplexer and Spindle Enable - Define GPIO Pin 5 to use pin "duex.gp4" 

; Dry Cabinet configured in separate file
M98 P"drycabinet.g"

; Tools
M98 P"tcreate1.g"
M98 P"tcreate2.g"
M98 P"tcreate3.g"
M98 P"tcreate4.g"
M98 P"tcreate5.g"

M563 P10 S"Probe"

M501 ; Set active parameters to those stored in config-override.g
M453 ; Switch to CNC mode
G4 P100 ; Dwell for 100 ms
M451 ; Switch to FFF mode
G4 P100 ; Dwell for 100 ms

; Network
M550 P"H4XXX" ; Set machine name
M552 S1 ; Enable network

; Miscellaneous
M911 S19 R22 P"M98 P""estop.g"""  ; Run estop.g on power loss during a print
M575 P1 B115200 S1; Set up UART for pendant input
; M750 ; Enable scanner
