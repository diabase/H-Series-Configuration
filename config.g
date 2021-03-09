; config.g
; H4 Configuration File
; Written by Diabase Engineering
; Last Updated: February 22, 2021

; Logging
; M929 P"eventlog.txt" S3 ; start logging to file eventlog.txt (S0 = stop logging, S1 = log level WARN, S2 = log level INFO, S3 = log level DEBUG)

; Network
M550 P"H5" ; Set machine name
M552 S1 ; Enable network

; General preferences
G90 ; Absolute Positioning
M83 ; Relative Extrusions

; Drive orientation
M569 P0 S0;     Set motor driver direction. Line 22: Z (Linear)
M569 P1 S1;     Set motor driver direction. Line 22: X (Linear)
M569 P2 S0 ;    Set motor driver direction. Line 22: Y (Linear)
M569 P3 S1 ;    Set motor driver direction. Line 22: U (Turret)
M569 P4 S1 ;    Set motor driver direction. Line 22: V (Turret Lock)
M569 P5 S1 ;    Set motor driver direction. Line 22: W (Cleaing Station)
M569 P1.0 S1 ;  Set motor driver direction. Line 22: E (Filament Assist)
M569 P1.1 S1 ;  Set motor driver direction. Line 22: E (Filament Assist)
M569 P1.2 S0 ;  Set motor driver direction. Line 22: C (Rotary)
M569 P2.0 S1 ;  Set motor driver direction. Line 22: E (Extruder)
M569 P2.1 S1 ;  Set motor driver direction. Line 22: E (Extruder)
M569 P2.2 S1 ;  Set motor driver direction. Line 22: A (Rotary)

; Drive settings
M584 Z0 X1 Y2 U3 V4 W5 A2.2 E2.0:2.1:1.0:1.1 ; Set driver mapping, E drive is multiplexed. Hide the extra axes
M208 X-208 Y-90 Z-10 U-10 V-100 W0 A-365 C-1000 S1 ; Set axis minima
M208 X208 Y90 Z210 U360 V200 W35 A365 C10000 S0 ; Set axis maxima
M350 X16 Y16 Z16 U16 V16 W16 A16 C16 E16:16:16:16 I1 ; Configure microstepping with interpolation
M92 X320 Y320 Z640 U230.22 V1600 W800 A53.33 C53.33 E96:96:96:96 ; Set steps per mm
M566 X300 Y300 Z300 U120 V500 W500 A1000 C1000 E1200:1200:1200:1200 ; Set maximum instantaneous speed changes (mm/min)
M203 X12000 Y12000 Z3000 U8900 V10000 W20000 A20000 C20000 E6000:6000:6000:6000 ; Set maximum speeds (mm/min)
M201 X600 Y600 Z450 U600 V500 W500 A600 C600 E250:250:250:250 ; Set accelerations (mm/s^2)
M906 X1800 Y2100 Z1800 U1200 V800 W800 A1600 C1600 E1500:1500:1500:500 I30 ; Set motor currents (mA) and motor idle factor percent
M84 S5 ; Allow all motors to drop hold current to idle after 5 seconds

; Endstops
M574 X1 S1 P"io2.in"
M574 Y1 S1 P"!io3.in"
M574 Z1 S1 P"!io4.in"
M574 U1 S1 P"2.io1.in"
M574 V2 S1 P"2.io2.in"
;M574 W1 S1 p"!2.io1.in"
M574 A1 S1 P"2.io3.in"

; Probes
M558 P8 C"2.io0.in" H2 F150 T12000; ; Set Z probe type for Probe 0 (Tool 10). It's a normally closed switch between the "zprobe.in" pin and ground using the internal pullup resistor, 2mm dive height, 150mm/min probing speed, and 12000 mm/min travel speed between probe points
M558 K1 P8 C"1.io5.in" I0 F200 T12000 ; Set Z probe type for Probe 1 (touchoff plate). It's an unfiltered normally closed switch between the "1.io5.in" pin and ground, non-inverted probe reading, 200mm/min probing speed, and 12000 mm/min travel speed between probe points
G31 Z0; Set Z probe trigger height to 0mm

; Tools
M98 P"tcreate-universal.g"

; Miscellaneous
;M950 P1 C"out1"             ;   P1 - cleaning station 1
M950 P2 C"out2"				;   Z axis brake

M98 P"cleaningstation.g" ; Configure cleaning station
;M98 P"drycabinet.g" ; Configure filament drying cabinet
;M98 P"heatedbed.g" ; Configure heated bed
M98 P"toolpriming.g" ; Configure tool priming parameters
M911 S19 R22 P"M98 P""estop.g"""  ; Run estop.g on power loss during a print
M575 P1 B115200 S1; Set up UART for pendant input
M98 P"toolpriming.g" ;load tool priming parameters
; M750 ; Enable scanner

; Post Config.g Commands
M501 ; Set active parameters to those stored in config-override.g
M307 H6 I1 ; A bug exists in RRF 3.2.2 and before that prevents M500 from saving the inversion parameter for heater models. RT added this line as a temporary workaround on 2/18/2021
