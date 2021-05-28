; config.g
; H5 Configuration File
; Written by Diabase Engineering
; Last Updated: May 15, 2021

; Logging
M929 P"eventlog.txt" S3 ; start logging to file eventlog.txt (S0 = stop logging, S1 = log level WARN, S2 = log level INFO, S3 = log level DEBUG)

; Network
M550 P"H5001" ; Set machine name
M552 S1 ; Enable network

; General preferences
G90 ; Absolute Positioning
M83 ; Relative Extrusions

; Drive orientation
M569 P0 S1;     Set motor driver direction. Line 22: X (Linear)
M569 P1 S1;     Set motor driver direction. Line 22: Y (Linear)
M569 P2 S0 ;    Set motor driver direction. Line 22: Z (Linear)
M569 P3 S0 ;    Set motor driver direction. Line 22: U (Turret)
M569 P4 S0 ;    Set motor driver direction. Line 22: V (Turret Lock)
M569 P5 S0 ;    Set motor driver direction. Line 22: W (Cleaing Station)
M569 P1.0 S1 ;  Set motor driver direction. Line 22: E (Filament Assist)
M569 P1.1 S1 ;  Set motor driver direction. Line 22: E (Filament Assist)
M569 P1.2 S0 ;  Set motor driver direction. Line 22: C (Rotary)
M569 P2.0 S1 ;  Set motor driver direction. Line 22: E (Extruder)
M569 P2.1 S1 ;  Set motor driver direction. Line 22: E (Extruder)
M569 P2.2 S1 ;  Set motor driver direction. Line 22: A (Rotary)
M569 P3.0 S0
M569 P3.1 S1
M569 P3.2 S1

; Drive settings
M584 X0 Y1 Z2 U3 V4 W5 B3.0 D3.2 E1.0:1.1:1.2:2.0:2.1:2.2; Set driver mapping
M208 X-208 Y-90 Z-10 U-10 V-100 W0 B-213.5 D0 S1 ; Set axis minima
M208 X208 Y90 U360 V200 W35 B212.5 D40 S0 ; Set axis maxima
M350 X16 Y16 Z16 U16 V16 W16 B16 D16 E16 I1 ; Configure microstepping with interpolation
M92 X320 Y320 Z320 U230.22 V1600 W800 B80 D1000 E96 ; Set steps per mm
M566 X300 Y300 Z300 U120 V500 W500 B1000 D1000 E1200 ; Set maximum instantaneous speed changes (mm/min)
M203 X12000 Y12000 Z3000 U8900 V10000 W20000 B20000 D1500 E6000 ; Set maximum speeds (mm/min)
M201 X600 Y600 Z450 U600 V500 W500 B600 D600 E250 ; Set accelerations (mm/s^2)
M906 X1800 Y2100 Z1800 U1200 V800 W800 B1600 D2500 E1500:1500:1500:500 I30 ; Set motor currents (mA) and motor idle factor percent
M84 S5 ; Allow all motors to drop hold current to idle after 5 seconds

; Endstops
M574 X1 S1 P"!io2.in"
M574 Y1 S1 P"!io3.in"
M574 Z2 S1 P"!io4.in"
M574 U1 S1 P"1.io1.in"
M574 V2 S1 P"1.io2.in"
;M574 W1 S1 p"!2.io1.in"
M574 B1 S1 P"!3.io1.in"
M574 D1 S1 P"!3.io2.in"

; Probes
M558 K0 P8 C"1.io0.in" H2 F150 T12000; ; Set Z probe type for Probe 0 (Tool 10). It's a normally closed switch between the "zprobe.in" pin and ground using the internal pullup resistor, 2mm dive height, 150mm/min probing speed, and 12000 mm/min travel speed between probe points
M558 K1 P8 C"1.io5.in" F200 T12000 ; Set Z probe type for Probe 1 (touchoff plate). It's an unfiltered normally closed switch between the "1.io5.in" pin and ground, 200mm/min probing speed, and 12000 mm/min travel speed between probe points
M558 K2 P8 C"3.io0.in" F800:200 T12000 ; Set Z probe type for Probe 1 (touchoff plate). It's an unfiltered normally closed switch between the "1.io5.in" pin and ground, 200mm/min probing speed, and 12000 mm/min travel speed between probe points
G31 K0 Z0; Set Z probe trigger height to 0mm

; Tools
M98 P"tcreate-universal.g"

; Miscellaneous
;M950 P1 C"out1"            ;   P1 - cleaning station 1
M950 P2 C"out7"             ;   Z axis brake
M950 F5 C"out3"             ;LEDs
M106 P5 C"TOP LIGHTS" L1
M950 F6 C"3.out6"           ;LEDs
M106 P6 C"FC LIGHTS" L1

; Pneumatic Turret Lock
M950 P5 C"out5"             ; Define pin 5 on the main board as GPIO pin (Turret Lock).
M950 P6 C"out6"             ; Define pin 6 on the main board as GPIO pin (Turret Unlock).
global TLockType=1      ; Turret Lock Type - 0 = Stepper on V-Axis, 1 = Pneumatic

;M98 P"cleaningstation.g" ; Configure cleaning station
;M98 P"drycabinet.g" ; Configure filament drying cabinet
;M98 P"heatedbed.g" ; Configure heated bed
;M98 P"toolpriming.g" ; Configure tool priming parameters
M911 S19 R22 P"M98 P""estop.g"""  ; Run estop.g on power loss during a print
M575 P1 B115200 S1; Set up UART for pendant input

;define variables
global TCZ=367.956
global TClength=0
global TCload=-1
global TCin=0
global TCactive=0



; Post Config.g Commands
M501 ; Set active parameters to those stored in config-override.g
M98 P"TC_max.g"     ;set TClength to maximum tool length
M307 H6 I1 ; A bug exists in RRF 3.2.2 and before that prevents M500 from saving the inversion parameter for heater models. RT added this line as a temporary workaround on 2/18/2021
