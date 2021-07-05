; config.g
; H5A Configuration File
; Written by Diabase Engineering
; Last Updated: May 12, 2021

;Machine-specific settings
M98 P"MachineSpecific.g"

; Logging
M929 P"{global.LogFileName}" S{global.LogLevel} ; Start logging with the filename and log level defined in machinespecific.global

;Network
M550 P{global.NetworkName}
M552 S1 ; Enable network

; General preferences
G90 ; Absolute Positioning
M83 ; Relative Extrusions

; Drive orientation
M569 P{global.XDrive} S{global.XDirection};     Set motor driver direction. Line 37: X (Linear)
M569 P{global.YDrive} S{global.YDirection};     Set motor driver direction. Line 37: Y (Linear)
M569 P{global.ZDrive} S{global.ZDirection} ;    Set motor driver direction. Line 37: Z (Linear)
M569 P{global.UDrive} S{global.UDirection} ;    Set motor driver direction. Line 37: U (Turret)
M569 P{global.VDrive} S{global.VDirection} ;    Set motor driver direction. Line 37: V (Turret Lock)
M569 P{global.WDrive} S{global.WDirection} ;    Set motor driver direction. Line 37: W (Cleaing Station)
while(iterations < 5)
    if exists(global.E{iterations}Drive) && exists(global.E{iterations}Directions))
        M569 P{global.E{iterations}Drive} S{global.E{iterations}Direction} ;  Set motor driver direction. Line 37: E (Extruder)
while(iterations < 5)
    if exists(global.FA{iterations}Drive) && exists(global.FA{iterations}Directions))
        M569 P{global.FA{iterations}Drive} S{global.FA{iterations}Direction} ;  Set motor driver direction. Line 37: E (Filament Assist)
M569 P{global.ADrive} S{global.ADirection} ;  Set motor driver direction. Line 37: A (Rotary)
M569 P{global.APrimeDrive} S{global.APrimeDirection} ;  Set motor driver direction. Line 37: A' (Rotary)
M569 P{global.CDrive} S{global.CDirection} ;  Set motor driver direction. Line 37: C (Rotary)

; Drive settings
M584 X{global.XDrive} Y{global.YDrive} Z{global.ZDrive} U{global.UDrive} V{global.VDrive} W{global.WDrive} A{global.ADrive}:{global.A2Drive} C{global.CDrive} E1.0:1.1:1.2:3.0:3.1:3.2; Set driver mapping, E drive is multiplexed. Hide the extra axes
M208 X-208 Y-90 Z-10 U{global.Umin} V-100 W0 A-365 C-1000 S1 ; Set axis minima
M208 X208 Y90 Z410 U360 V200 W35 A365 C10000 S0 ; Set axis maxima
M350 X16 Y16 Z16 U16 V16 W400 A16 C16 E16 I1 ; Configure microstepping with interpolation - high lead cleaning station motor
M92 X320 Y320 Z320 U230.22 V1600 W400 A53.33 C53.33 E96 ; Set steps per mm
M566 X300 Y300 Z300 U120 V500 W500 A1000 C1000 E1200 ; Set maximum instantaneous speed changes (mm/min)
M203 X12000 Y12000 Z3000 U8900 V10000 W20000 A20000 C20000 E6000 ; Set maximum speeds (mm/min)
M201 X600 Y600 Z450 U600 V500 W500 A600 C600 E250 ; Set accelerations (mm/s^2)
M906 X1800 Y2100 Z1800 U1200 V800 W800 A1600 C1600 E1500:1500:1500:1000:1000:1000 I30 ; Set motor currents (mA) and motor idle factor percent
M84 S5 ; Allow all motors to drop hold current to idle after 5 seconds

; Endstops
M574 X1 S1 P"io2.in"
M574 Y1 S1 P"io3.in"
M574 Z2 S1 P"io4.in"
M574 U1 S1 P"1.io1.in"
M574 V2 S1 P"1.io2.in"
;M574 W1 S1 p"!2.io1.in"
M574 A1 S1 P"3.io1.in"
M574 C1 S1 P"3.io2.in"

; Probes
M558 P8 C"1.io0.in" H2 F150 T12000; ; Set Z probe type for Probe 0 (Tool 10). It's a normally closed switch between the "zprobe.in" pin and ground using the internal pullup resistor, 2mm dive height, 150mm/min probing speed, and 12000 mm/min travel speed between probe points
M558 K1 P8 C"1.io5.in" I0 F200 T12000 ; Set Z probe type for Probe 1 (touchoff plate). It's an unfiltered normally closed switch between the "1.io5.in" pin and ground, non-inverted probe reading, 200mm/min probing speed, and 12000 mm/min travel speed between probe points
G31 Z0; Set Z probe trigger height to 0mm

; Tools
M98 P"tcreate-universal.g"

; Miscellaneous
;M950 P1 C"out1"             ;   P1 - cleaning station 1
M950 P2 C"out2"				;   Z axis brake
M950 F3 C"out3"				;LEDs
M106 P3 C"TOP LIGHTS" L1    ;LEDs defined as Fan with toggle (no dimming control)
M950 F4 C"3.out6"			;12V LEDs
M106 P4 C"FC LIGHTS" L1    ;LEDs defined as Fan with toggle (no dimming control)

M98 P"cleaningstation.g" ; Configure cleaning station
;M98 P"drycabinet.g" ; Configure filament drying cabinet
;M98 P"heatedbed.g" ; Configure heated bed
M98 P"toolpriming.g" ; Configure tool priming parameters
M911 S19 R22 P"M98 P""estop.g"""  ; Run estop.g on power loss during a print
M575 P1 B115200 S1; Set up UART for pendant input

;define variables
global maxoffset=0              ;maximum tool offset
global diameterProbeHole = 0    ;diameter to probe cavity

; Post Config.g Commands
M501 ; Set active parameters to those stored in config-override.g
M98 P"Maxoffset.g"     ;set maxoffset to maximum tool length
M307 H6 I1 ; A bug exists in RRF 3.2.2 and before that prevents M500 from saving the inversion parameter for heater models. RT added this line as a temporary workaround on 2/18/2021
