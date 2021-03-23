; config.g
; H4 Configuration File
; Written by Diabase Engineering
; Last Updated: February 22, 2021

; Logging
; M929 P"eventlog.txt" S3 ; start logging to file eventlog.txt (S0 = stop logging, S1 = log level WARN, S2 = log level INFO, S3 = log level DEBUG)

; Network
M550 P"H4051" ; Set machine name
M552 S1 P192.168.1.52 ; Enable network

; General preferences
G90 ; Absolute Positioning
M83 ; Relative Extrusions

; Drive orientation
M569 P0 S1 ; Set motor driver direction. Motor driver number 0 goes forwards  (S1). Line 22: X (Linear)
M569 P1 S0 ; Set motor driver direction. Motor driver number 1 goes forwards  (S1). Line 22: Y (Linear)
M569 P2 S0 ; Set motor driver direction. Motor driver number 2 goes backwards (S0). Line 22: Z (Linear)
M569 P3 S0 ; Set motor driver direction. Motor driver number 3 goes backwards (S0). Line 22: U (Turret)
M569 P4 S0 ; Set motor driver direction. Motor driver number 4 goes backwards (S0). Line 22: A (Rotary)
M569 P5 S1 ; Set motor driver direction. Motor driver number 5 goes forwards  (S1). Line 22: C (Rotary)
M569 P6 S0 ; Set motor driver direction. Motor driver number 6 goes backwards (S0). Line 22: E:1-3 (Extruders)
M569 P7 S1 ; Set motor driver direction. Motor driver number 7 goes forwards  (S1). Line 22: W (Cleaning Station)
M569 P8 S1 ; Set motor driver direction. Motor driver number 8 goes forwards  (S1). Line 22: V (Turret Lock)
M569 P9 S0 ; Set motor driver direction. Motor driver number 9 goes backwards (S0). Line 22: E4 (Filament Assist)

; Drive settings
M584 X0 Y1 Z2 U3 V8 W7 E6:6:6:6:6:9  ; Set driver mapping, E drive is multiplexed. Hide the extra axes
M208 X-210 Y-93 Z-10 U-9.42 V-100 W0 S1 ; Set axis minima
M208 X210 Y93 Z202.64 U350 V200 W35 S0 ; Set axis maxima
M350 X16 Y16 Z16 U16 V16 W16 E16:16:16:16:16:16 I1 ; Configure microstepping with interpolation
M92 X320 Y320 Z640 U322.31 V1600 W800 E96:96:96:96:96:96 ; Set steps per mm
M566 X300 Y300 Z300 U120 V500 W500 E1200:1200:1200:1200:1200:1200 ; Set maximum instantaneous speed changes (mm/min)
M203 X12000 Y12000 Z3000 U8900 V10000 W20000 E6000:6000:6000:6000:6000:6000 ; Set maximum speeds (mm/min)
M201 X600 Y600 Z450 U600 V500 W500 E250:250:250:250:250:250 ; Set accelerations (mm/s^2)
M906 X1800 Y2100 Z1800 U1200 V800 W800 E1500:1500:1500:1500:1500:500 I30 ; Set motor currents (mA) and motor idle factor in per cent
M84 S5 ; Allow all motors to drop hold current to idle after 5 seconds

; Endstops
M574 X1 S1 P"xstop" ; Configure X endstop position at low end, it's a microswitch on pin "xstop"
M574 Y1 S1 P"ystop" ; Configure Y endstop position at low end, it's a microswitch on pin "ystop"
M574 Z2 S1 P"zstop" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
M574 U1 S1 P"e0stop" ; Configure U endstop position at low end, it's a microswitch on pin "e0stop"
M574 V0 S1 P"e1stop" ; Configure V endstop position at no end, it's a microswitch on pin "e1stop"
M574 A1 S1 P"duex.e2stop" ; Configure A endstop position at low end, it's a microswitch on pin "duex.e2stop"
M574 C1 S1 P"duex.e3stop" ; Configure C endstop position at low end, it's a microswitch on pin "duex.e3stop"

; Probes
M558 K0 P5 C"^zprobe.in" H2 F150 T12000 ; Set Z probe type for Probe 0 (Tool 10). It's a normally closed switch between the "zprobe.in" pin and ground using the internal pullup resistor, 2mm dive height, 150mm/min probing speed, and 12000 mm/min travel speed between probe points
M558 K1 P8 C"duex.e4stop" I0 F200 T12000 ; Set Z probe type for Probe 1 (touchoff plate). It's an unfiltered normally closed switch between the "duex.e4stop" pin and ground, non-inverted probe reading, 200mm/min probing speed, and 12000 mm/min travel speed between probe points
G31 Z0 ; Set Z probe trigger height to 0mm

; Tools
M98 P"tcreate-universal.g"

; Miscellaneous
M98 P"cleaningstation.g" ; Configure cleaning station
M98 P"drycabinet.g" ; Configure filament drying cabinet
M98 P"heatedbed.g" ; Configure heated bed
M98 P"toolpriming.g" ; Configure tool priming parameters
M911 S19 R22 P"M98 P""estop.g"""  ; Run estop.g on power loss during a print
M575 P1 B115200 S1; Set up UART for pendant input
; M750 ; Enable scanner

; Post Config.g Commands
M501 ; Set active parameters to those stored in config-override.g
M307 H6 I1 ; A bug exists in RRF 3.2.2 and before that prevents M500 from saving the inversion parameter for heater models. RT added this line as a temporary workaround on 2/18/2021
