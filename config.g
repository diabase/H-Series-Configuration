; H4 Configuration File
; written by Diabase Engineering

; General preferences
G90 ; Send absolute coordinates...
M83 ; ...but relative extruder moves

; Drive orientation
M569 P0 S0; Drive 0 goes backwards
M569 P1 S1; Drive 1 goes backwards
M569 P2 S0 ; Drive 2 goes forwards
M569 P3 S1 ; Drive 3 goes backwards
M569 P4 S1 ; Drive 4 goes backwards
M569 P5 S1 ; Drive 5 goes forwards
M569 P1.0 S1 ; Drive 6 goes forwards
M569 P1.1 S0 ; Drive 7 goes backwards
M569 P1.2 S0 ; Drive 8 goes backwards
M569 P2.0 S1 ; Drive 9 goes backwards
M569 P2.1 S1 ; Drive 9 goes backwards

; Drive settings
M584 Z0 X1 Y2 U3 V4 W5 E2.0:2.1 ; Set driver mapping, E drive is multiplexed. Hide the extra axes
M208 X-200 Y-93 Z-10 U-10 V-100 W0 A0 B-0 C0 S1; Set axis minima
M208 X200 Y93 Z360 U360 V200 W35 A120 B580 C500 S0 ; Set axis maxima
M350 X16 Y16 Z16 U16 B16 V16 W16 A16 C16 E16 I1 ; Configure microstepping with interpolation
M92 X320 Y320 Z320 U230 V1600 W800 B79.97 A1600 C400 E96 ; Set steps per mm 
M566 X300 Y300 Z300 U120 V1200 W500 B1200 A1200 C1200 E1200 ; Set maximum instantaneous speed changes (mm/min)
M203 X12000 Y12000 Z4000 U5900 V10000 W20000 B8000 A1500 C2000 E6000 ; Set maximum speeds (mm/min)
M201 X600 Y600 Z450 U300 B600 V500 W500 A500 C600 E250 ; Set accelerations (mm/s^2)
M906 X1800 Y2100 Z1800 U1200 V800 W800 B1800 A1200 C1800 E1500 I30 ; Set motor currents (mA) and motor idle factor in per cent
M84 S5 ; Set idle timeout

; Endstops
M574 X1 S1 P"io2.in"
M574 Y1 S1 P"!io3.in"
M574 Z1 S1 P"!io4.in"
M574 U1 S1 P"io5.in"
M574 V2 S1 P"io6.in"
M574 W1 S1 p"!2.io1.in"
;M574 B1 S1 P"!1.io1.in"
;M574 A1 S1 P"!1.io2.in"
;M574 C1 S1 P"!1.io3.in"

;M574 V2 S0 ; Define active low microswitches
M558 P8 C"2.io0.in" H2 F150 T12000; Set Z probe type to switch, probing height and the probe + travel speeds
G31 Z0 K0; Set Z probe trigger height

; Temperature sensors
;M308 S0 P"bedtemp"      Y"thermistor" T100000 B3950 C0 A"Bed" ; Bed thermistor
;;M308 S1 P"e0temp"       Y"thermistor" T100000 B3950 C0         ; E0_HEATER is unused
;M308 S2 P"e1temp"       Y"thermistor" T100000 B3950 C0         ; E1_HEATER is used for the dry cabinet, see below
;M308 S3 P"duex.e2temp"  Y"thermistor" T100000 B3950 C0 A"Nozzle 1"
;M308 S4 P"temp1"  Y"thermistor" T100000 B3950 C0 A"Nozzle 2"
;M308 S5 P"temp2"  Y"thermistor" T100000 B3950 C0 A"Nozzle 3"
;M308 S6 P"temp3"  Y"thermistor" T100000 B3950 C0 A"Nozzle 4"
;M308 S7 P"duex.e6temp"  Y"thermistor" T100000 B3950 C0 A"Nozzle 5"

; Heaters
;M950 H0 C"bedheat" T0                                    ; Bed heater
M950 P1 C"out1"                ; P1 - cleaning station 1
;M950 P2 C"io1.out" 				; P2 - motor direction
;M950 P8 C"out8"               ; P2 - cleaning station 2
;M950 H3 C"!duex.e2heat" T3
;M950 H4 C"out1" T4
;M950 H5 C"out2" T5
;M950 H6 C"out3" T6
;M950 H7 C"!duex.e6heat" T7

; Temperature limits
;M143 H0 S120 ; Limit Bed temperature to 120C
;M143 H3 S290 ; Limit H3/E2 temperature to 290C
;M143 H4 S290 ; Limit H4/E3 temperature to 290C
;M143 H5 S290 ; Limit H5/E4 temperature to 290C
;M143 H6 S290 ; Limit H6/E5 temperature to 290C
;M143 H7 S290 ; Limit H7/E6 temperature to 290C
M302 S150 ; Set minimum extrude temp

; Fan definition
;;M950 F0 C"nil"         ; free up fan
M950 F1 C"2.out6"		;FDM cooling fan
;M950 F2 C"nil"         ; free up fan
;M950 F4 C"duex.fan4"
;M950 F5 C"duex.fan5"
;M950 F6 C"duex.fan6"
;M950 F7 C"duex.fan7"

; Tools
M98 P"tcreate1.g"
;M98 P"tcreate2.g"
M98 P"tcreate3.g"
M98 P"tcreate4.g"
;M98 P"tcreate5.g"
;M563 P8 S"Camera"
M563 P10 S"Probe"

; Load config-override.g after the tools have been created
M501
M453 ;toggle CNC mode
G4 P100
M451 ;return to FFF mode
G4 P100

;Dry Cabinet
;M98 P"drycabinet.g"

; Network
M550 P"H5" ; Set machine name
M552 S1 ; Enable network

; Fan configuration
M106 P1 H3:4 T50 ; Nozzle fans
;M106 P4 S0 B0 C"Spindle 1" ; Spindle 1 air flow
;M106 P5 S0 B0 C"Spindle 2" ; Spindle 2 air flow
;M106 P6 S0 B0 C"Spindle 3" ; Spindle 3 air flow
;M106 P7 S0 B0 C"Spindle 4" ; Spindle 4 air flow

; Miscellaneous
M911 S22 R23 P"M98 P""estop.g"""  ; Run estop.g on power loss during a print
M575 P1 S1 B57600

