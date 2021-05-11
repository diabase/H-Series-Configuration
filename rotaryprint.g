; Drive settings
M584 Y4 A1  ; Set driver mapping, A becomes Y, Y becomes A
M208 Y-365 A-90 S1 ; Set axis minima
M208 Y365 A90 S0 ; Set axis maxima
M350 Y16 A16  I1 ; Configure microstepping with interpolation
M92  Y53.33 A320 ; Set steps per mm
M566 Y1000 A600 ; Set maximum instantaneous speed changes (mm/min)
M203 X2000 Y20000 A10000  ; Set maximum speeds (mm/min)
M201 Y1400 A900 ; Set accelerations (mm/s^2)
M906 Y2000 A2000 I30 ; Set motor currents (mA) and motor idle factor in per cent
M84 S5 ; Set idle timeout

M574 Y1 P"nil"			;disable pin on Y endstop
M574 A1 P"nil"			;disable pin on A endstop
G1 P100					; wait
M574 A1 S1 P"ystop"	;enable new pin on A endstop
M574 Y1 S1 P"duex.e2stop"	;enable new pin on Y endstop

while iterations < 5
 G10 P{iterations+1} A{tools[(iterations+1)].offsets[1]}
 G10 P{iterations+1} Y0

G92 Y{move.axes[6].machinePosition} 
G92 A0


echo "Rotary axis configuration complete"