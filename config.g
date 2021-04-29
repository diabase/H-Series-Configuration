; H4 Configuration File
; written by Diabase Engineering

; General preferences
G90 ; Send absolute coordinates...
M83 ; ...but relative extruder moves

; Drive orientation
M569 P0 S0 ; Drive 0 goes backwards
M569 P1 S0 ; Drive 1 goes backwards
M569 P2 S0 ; Drive 2 goes forwards
M569 P3 S0 ; Drive 3 goes backwards
M569 P4 S0 ; Drive 4 goes backwards
M569 P5 S0 ; Drive 5 goes forwards
M569 P6 S0 ; Drive 6 goes forwards
M569 P7 S0 ; Drive 7 goes backwards
M569 P8 S0 ; Drive 8 goes backwards
M569 P9 S0 ; Drive 9 goes backwards

; Drive settings martijn:adjusted to add paste extruder
M584 X0 Y1 Z2 U3 V8 E6:9:5 A4; Set driver mapping, E drive is multiplexed. Hide the extra axes
M208 X-210 Y-93 Z0 U-6.0 V-100 A-365 S1 ; Set axis minima
M208 X155 Y93 Z202.64 U360 V200 A365 S0 ; Set axis maxima martijn: reduced printbed size for paste extruder
M350 X16 Y16 Z16 U16 V16 A16 E16:16:16 I1 ; Configure microstepping with interpolation
M92 X320 Y320 Z640 U322.31 V1600 A53.33 E96:96:10; Set steps per mm
M566 X300 Y300 Z300 U120 V500 A1000 E1200:1200:1200 ; Set maximum instantaneous speed changes (mm/min)
M203 X12000 Y12000 Z3000 U8900 V10000 A20000 E6000:6000:10000 ; Set maximum speeds (mm/min)
M201 X600 Y600 Z450 U600 V500 A600 E250:250:250 ; Set accelerations (mm/s^2)
M906 X1200 Y2000 Z1800 U1400 V800 A1600 E1500:1500:1500 I30 ; default config - Set motor currents (mA) and motor idle factor in per cent
;M906 X700 Y1000 Z900 U1400 V800 A1600 E1300:1500:750 I30 ; sandbox mode - Set motor currents (mA) and motor idle factor in per cent

;stall detection
M915 X S20 F1 H100 R2; martijn 29/05/20 turned stall detection back on
M915 Y S20 F1 H100 R2; martijn 29/05/20 turned stall detection back on
M915 Z S20 F1 H100 R2; martijn 29/05/20 turned stall detection back on
M915 U S20 F1 H100 R2; martijn 29/05/20 turned stall detection back on
;M915 X S25 F1 H200 R2;Gerjan 02/03/20 - Gerjan 11/02/20 chagned H5 and s15 M915 X S15 F1 H5 R2; stall detection minimum 8
;M915 Y S25 F1 H200 R2;Gerjan 02/03/20 - Gerjan 11/02/20 chagned H5 and s15 M915 Y S15 F1 H5 R2; stall detection minimum 12
;M915 Z S25 F1 H200 R2;Gerjan 02/03/20 - Gerjan 11/02/20 chagned H5 and s15 M915 Z S15 F1 H5 R2; stall detection
M84 S5 ; Set idle timeout

; Endstops
M574 X1 Y1 U1 V2 A1 S1 ; Define active high microswitches
M558 P5 I0 H2 F150 T12000 ; Set Z probe type to switch, probing height and the probe + travel speeds
G31 Z0 ; Set Z probe trigger height

; Heaters
M140 H0 ; Turn on bed
M143 H0 S120 ; Limit Bed temperature to 120C
M143 H3 S295 ; Limit H3/E2 temperature to 290C
M143 H4 S240 ; Limit H4/E3 temperature to 290C martijn: edited to have a limit for normal flexion extruders
M143 H5 S240 ; Limit H5/E4 temperature to 290C martijn: edited to have a limit for normal flexion extruders
M143 H6 S240 ; Limit H6/E5 temperature to 290C martijn: edited to have a limit for normal flexion extruders
M143 H7 S240 ; Limit H7/E6 temperature to 290C martijn: edited to have a limit for normal flexion extruders
M302 S150 ; Set minimum extrude temp

; Tools
M98 P"tcreate1.g"
M98 P"tcreate2.g"
M98 P"tcreate3.g"
M98 P"tcreate4.g"
M98 P"tcreate5.g"
M98 P"tcreate0.g" ;martijn: added paste extruder
;M563 P8 S"Camera"
M563 P10 S"Probe"

; Load config-override.g after the tools have been created
M501
M451 ;return to FFF mode


; Thermistors
M305 P0 T100000 B3950 C0 R4700 S"Bed"
M305 P1 T100000 B3950 C0 R4700 ; E0_HEATER is unused
M305 P2 T100000 B3950 C0 R4700 ; E1_HEATER is used for the dry cabinet, see below
;M305 P3 T100000 B3950 C0 R4700 S"Nozzle 1" 
M305 P3 T100000 B4725 C7.06e-8 R4700 S"Nozzle 1"; Hemera thermistor
M305 P4 T100000 B3950 C0 R4700 S"Nozzle 2"
M305 P5 T100000 B3950 C0 R4700 S"Nozzle 3"
M305 P6 T100000 B3950 C0 R4700 S"Nozzle 4"
M305 P7 T100000 B3950 C0 R4700 S"Nozzle 5"

;Dry Cabinet
M98 P"drycabinet.g"

; Network
M550 P"H4006" ; Set machine name
M552 S1 ; Enable network

; Fans
M106 P0 S0 I-1 ; Cleaning station
M106 P2 S0 I-1 ; Cleaning station
M106 P1 H3:4:5:6:7 T50 ; Nozzle fans
;M106 P4 S0 B0 C"Spindle 1" ; Spindle 1 air flow
;M106 P5 S0 B0 C"Spindle 2" ; Spindle 2 air flow
;M106 P6 S0 B0 C"Spindle 3" ; Spindle 3 air flow
;M106 P7 S0 B0 C"Spindle 4" ; Spindle 4 air flow

; Miscellaneous
;M911 S22 R23 P"M98 P""estop.g"""  ; Run estop.g on power loss during a print
;M575 P1 B250000 ; Set up UART for pendant input
;M750 ; Enable scanner
