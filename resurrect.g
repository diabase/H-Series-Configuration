; File "0:/gcodes/Validation Test.gcode" resume print after power failure at 2022-04-22 10:22
G21
G29 S1
T-1 P0
G92 X-4.538 Y11.086 Z14.540 U318.300 V-10.000 W0.000 A0.000 C0.000
G60 S1
G10 P3 S235 R175
G10 P4 S230 R175
G10 P5 S260 R260
T5 P0
M98 P"resurrect-prologue.g"
M116
M290 X0.000 Y0.000 Z0.000 U0.000 V0.000 W0.000 A0.000 C0.000 R0
T-1 P0
T5 P6
; Workplace coordinates
G10 L2 P1 X0.00 Y0.00 Z0.00 U0.00 V0.00 W0.00 A0.00 C0.00
G10 L2 P2 X-50.00 Y0.00 Z0.00 U0.00 V0.00 W0.00 A0.00 C0.00
G10 L2 P3 X-383.28 Y-22.85 Z-0.75 U0.00 V0.00 W0.00 A-1.07 C0.00
G10 L2 P4 X0.00 Y0.00 Z0.00 U0.00 V0.00 W0.00 A0.00 C0.00
G10 L2 P5 X34.51 Y-14.22 Z23.09 U0.00 V0.00 W0.00 A0.00 C0.00
G10 L2 P6 X0.00 Y0.00 Z0.00 U0.00 V0.00 W0.00 A0.00 C0.00
G10 L2 P7 X0.00 Y0.00 Z0.00 U0.00 V0.00 W0.00 A0.00 C0.00
G10 L2 P8 X1.13 Y4.22 Z29.19 U0.00 V0.00 W0.00 A0.00 C0.00
G10 L2 P9 X0.00 Y0.00 Z0.00 U0.00 V0.00 W0.00 A0.00 C0.00
G54
M106 S0.00
M106 P1 S1.00
M116
G92 E0.00000
M83
M23 "0:/gcodes/Validation Test.gcode"
M26 S20194
G0 F6000 Z4.270
G0 F6000 X-3.678 Y9.556 U318.300 V-10.000 W0.000 A0.000 C0.000
G0 F6000 Z2.270
G1 F1680.0 P0
G21
M24
