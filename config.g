; H4 Configuration File
; written by Diabase Engineering

; General preferences
G90 ; Send absolute coordinates...
M83 ; ...but relative extruder moves

; Drive orientation
M569 P0 S1; Drive 0 goes backwards
M569 P1 S1; Drive 1 goes backwards
M569 P2 S0 ; Drive 2 goes forwards
M569 P3 S0 ; Drive 3 goes backwards
M569 P4 S0 ; Drive 4 goes backwards
M569 P5 S1 ; Drive 5 goes forwards
M569 P6 S0 ; Drive 6 goes forwards
M569 P7 S1 ; Drive 7 goes backwards
M569 P8 S1 ; Drive 8 goes backwards
M569 P9 S0 ; Drive 9 goes backwards

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
M84 S5 ; Set idle timeout

; Endstops
M574 X1 S1 P"xstop"
M574 Y1 S1 P"ystop"
M574 Z1 S1 P"zstop"
M574 U1 S1 P"e0stop"
M574 V0 S1 P"e1stop"


;M574 V2 S0 ; Define active low microswitches
M558 K0 P5 C"^zprobe.in" H2 F150 T12000 ; Set Z probe type to switch, probing height and the probe + travel speeds
M558 K1 P8 C"duex.e4stop" I0 F200 T12000 ; Additional Z probe used for touchoff
G31 Z0 ; Set Z probe trigger height

; Temperature sensors
M308 S0 P"bedtemp" Y"thermistor" T100000 B3950 C0 A"Bed" ; Bed thermistor
;M308 S0 P"e0temp"       Y"thermistor" T100000 B3950 C0         ; E0_HEATER is unused
;M308 S2 P"e1temp"       Y"thermistor" T100000 B3950 C0         ; E1_HEATER is used for the dry cabinet, see below
M308 S1 P"duex.e2temp" Y"thermistor" T100000 B3950 C0 A"Nozzle 1"
M308 S2 P"duex.e3temp" Y"thermistor" T100000 B3950 C0 A"Nozzle 2"
M308 S3 P"duex.e4temp" Y"thermistor" T100000 B3950 C0 A"Nozzle 3"
M308 S4 P"duex.e5temp" Y"thermistor" T100000 B3950 C0 A"Nozzle 4"
M308 S5 P"duex.e6temp" Y"thermistor" T100000 B3950 C0 A"Nozzle 5"

; Heaters
M950 H0 C"bedheat" T0                                    
M950 H1 C"!duex.e2heat" T1
M950 H2 C"!duex.e3heat" T2
M950 H3 C"!duex.e4heat" T3
M950 H4 C"!duex.e5heat" T4
M950 H5 C"!duex.e6heat" T5


M950 H1 C"duex.e2heat" T1
M950 H2 C"duex.e3heat" T2
M950 H3 C"!exp.heater5" T3
M950 H4 C"!exp.heater6" T4
M950 H5 C"!exp.heater7" T5

;Bed Heater
M140 H0

; Temperature limits
M143 H0 S120 ; Limit Bed temperature to 120C
M143 H1 S290 ; Limit H3/E2 temperature to 290C
M143 H2 S250 ; Limit H4/E3 temperature to 290C
M143 H3 S250 ; Limit H3/E2 temperature to 290C
M143 H4 S250 ; Limit H4/E3 temperature to 290C
M143 H5 S250 ; Limit H5/E4 temperature to 290C
M302 S150 ; Set minimum extrude temp

; Fan definition
M950 F0 C"nil"         ; free up fan
M950 F1 C"fan1"
M950 F2 C"nil"         ; free up fan
M950 F3 C"duex.fan3"
;M950 F4 C"duex.fan4"
;M950 F5 C"duex.fan5"
;M950 F6 C"duex.fan6"
;M950 F7 C"duex.fan7"
;M950 F8 C"duex.fan8" ;used for vacuum control

; Servo pins (for M42)
;M950 P0 C"fan0" ; Was M42 P20
M950 P1 C"fan2" ; Was M42 P22
M950 P2 C"duex.gp1" ; Was M42 P100
M950 P3 C"duex.gp2" ; Was M42 P101
M950 P4 C"duex.gp3" ; Was M42 P102
M950 P5 C"duex.gp4" ; Was M42 P103

; Tools
M98 P"tcreate1.g"
M98 P"tcreate2.g"
M98 P"tcreate3.g"
M98 P"tcreate4.g"
M98 P"tcreate5.g"

M563 P10 S"Probe"

; Load config-override.g after the tools have been created
M501
M453 ;toggle CNC mode
G4 P100
M451 ;return to FFF mode
G4 P100

;Dry Cabinet
M98 P"drycabinet.g"

; Network
M550 P"H4052" ; Set machine name
M552 S1 P192.168.1.52; Enable network

; Fan configuration
M106 P1 H1:2:3:4:5 T50 ; Nozzle fans
M106 P3 C"Print Fan"

; Miscellaneous
M911 S19 R22 P"M98 P""estop.g"""  ; Run estop.g on power loss during a print
M575 P1 S1; Set up UART for pendant input
;M750 ; Enable scanner
