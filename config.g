; config.g
; H5A Configuration File
; Written by Diabase Engineering
; Last Updated: October 8, 2021

; Logging
M929 P"eventlog.txt" S1 ; start logging to file eventlog.txt (S0 = stop logging, S1 = log level WARN, S2 = log level INFO, S3 = log level DEBUG)
M118 S"Info: Begin config.g" L2

;Default Parameters
if !{exists(global.DefaultParametersLastRun)}
    M98 P"defaultparameters.g"

;Machine-specific settings
M98 P"machinespecific.g"

;Network
M550 P{global.MachineName}
M118 S{{global.MachineName}} L1
M552 S1 ; Enable network

; General preferences
G90 ; Absolute Positioning
M83 ; Relative Extrusions

; Drive orientation
M569 P{global.XDrive} S{global.XDirection}  ; Set motor driver direction. Line 37: X (Linear)
M569 P{global.YDrive} S{global.YDirection}  ; Set motor driver direction. Line 37: Y (Linear)
M569 P{global.ZDrive} S{global.ZDirection}  ; Set motor driver direction. Line 37: Z (Linear)
M569 P{global.UDrive} S{global.UDirection}  ; Set motor driver direction. Line 37: U (Turret)
M569 P{global.VDrive} S{global.VDirection}  ; Set motor driver direction. Line 37: V (Turret Lock)
M569 P{global.WDrive} S{global.WDirection}  ; Set motor driver direction. Line 37: W (Cleaing Station)
M569 P1.0 S{global.E1Direction}             ; Set motor driver direction. Line 37: E (Extruder)
M569 P1.1 S{global.E3Direction}             ; Set motor driver direction. Line 37: E (Extruder)
M569 P1.2 S{global.E5Direction}             ; Set motor driver direction. Line 37: E (Extruder)
M569 P3.0 S{global.FA1Direction}            ; Set motor driver direction. Line 37: E (Filament Assist)
M569 P3.1 S{global.FA3Direction}            ; Set motor driver direction. Line 37: E (Filament Assist)
M569 P3.2 S{global.FA5Direction}            ; Set motor driver direction. Line 37: E (Filament Assist)
M569 P2.0 S{global.ADirection}              ; Set motor driver direction. Line 37: A (Rotary)
M569 P2.1 S{global.APrimeDirection}         ; Set motor driver direction. Line 37: A' (Rotary)
M569 P2.2 S{global.CDirection}              ; Set motor driver direction. Line 37: C (Rotary)

; Drive settings
M584 X{global.XDrive} Y{global.YDrive} Z{global.ZDrive} U{global.UDrive} V{global.VDrive} W{global.WDrive} A2.0:2.1 C2.2 E1.0:1.1:1.2:3.0:3.1:3.2; Set driver mapping.
M208 X{global.XMin} Y{global.YMin} Z{global.ZMin} U{global.UMin} V{global.VMin} W{global.WMin} A{global.AMin} C{global.CMin} S1 ; Set axis minima
M208 X{global.XMax} Y{global.YMax} Z{global.ZMax} U{global.UMax} V{global.VMax} W{global.WMax} A{global.AMax} C{global.CMax} S0 ; Set axis maxima
M350 X16 Y16 Z16 U16 V16 W16 A16 C16 E16 I1 ; Configure microstepping with interpolation - high lead cleaning station motor
M92 X320 Y320 Z320 U230.22 V1600 W400 A53.33 C53.33 E96 ; Set steps per mm
M566 X300 Y300 Z300 U120 V500 W200 A1000 C1000 E1200 ; Set maximum instantaneous speed changes (mm/min)
M203 X10000 Y10000 Z3000 U8000 V10000 W13000 A20000 C20000 E6000 ; Set maximum speeds (mm/min)
M201 X600 Y600 Z450 U600 V500 W5000 A600 C600 E250 ; Set accelerations (mm/s^2)
M906 X1800 Y2100 Z2400 U1440 V1000 W1000 A1600 C1600 E1500:1500:1500:1000:1000:1000 I30 ; Set motor currents (mA) and motor idle factor percent
M84 S5 ; Allow all motors to drop hold current to idle after 5 seconds

; Endstops
M574 X1 S1 P{global.XSwitchPin}
M574 Y1 S1 P{global.YSwitchPin}
M574 Z2 S1 P{global.ZSwitchPin}
M574 U1 S1 P{global.USwitchPin}
M574 V2 S1 P{global.VSwitchPin}
M574 A1 S1 P{global.ASwitchPin}
M574 C1 S1 P{global.CSwitchPin}

; Probes
M558 K0 P8 C{global.ProbePin} H2 F150 T10000 ; Set Z probe type for Probe 0 (Tool 10). 2mm dive height, 150mm/min probing speed, and 10000 mm/min travel speed between probe points
M558 K1 P8 C{global.TouchOffPlatePin} I0 F200 T10000 ; Set Z probe type for Probe 1 (touchoff plate). It's on the pin designated in machinespecific.g, 200mm/min probing speed, and 10000 mm/min travel speed between probe points
G31 Z0; Set Z probe trigger height to 0mm

; Tools
M98 P"heatedbed.g" ; Configure heated bed
M98 P"tcreate-universal.g"  ; Create Tools, Fans, GPIO
M98 P"cleaningstation.g" ; Configure cleaning station
M98 P"toolpriming.g" ; Configure tool priming parameters
M98 P"drycabinet.g" ; Configure filament drying cabinet
M911 S19 R22 P"M98 P""estop.g"""  ; Run estop.g on power loss during a print
M575 P1 B115200 S1; Set up UART for pendant input

; Post Config.g Commands
M501 ; Set active parameters to those stored in config-override.g
M98 P"maxoffset.g"     ;set maxoffset to maximum tool length

;Machine-specific settings
M98 P"machinespecific.g"

set global.ConfigLastRun = state.upTime
M118 S"Info: End config.g" L2
