; Drive settings
M584 Y2.2 R1
M584 A2 R0 ; Set driver mapping, E drive is multiplexed. Hide the extra axes
M208 Y-365 A-93 S1 ; Set axis minima
M208 Y365 A93 S0 ; Set axis maxima
M350 Y16 A16  I1 ; Configure microstepping with interpolation
M92  Y53.33 A320 ; Set steps per mm
M566 Y1000 A600 ; Set maximum instantaneous speed changes (mm/min)
M203 X2000 Y30000 A10000  ; Set maximum speeds (mm/min)
M201 Y1400 A900 ; Set accelerations (mm/s^2)
M906 Y2000 A2000 I30 ; Set motor currents (mA) and motor idle factor in per cent
M84 S5 ; Set idle timeout

M574 Y1 P"nil"			;disable pin on Y endstop
M574 A1 P"nil"			;disable pin on A endstop
G1 P100					; wait
M574 A1 S1 P"!io3.in"	;enable new pin on A endstop
M574 Y1 S1 P"2.io3.in"	;enable new pin on Y endstop


G92 A Y
