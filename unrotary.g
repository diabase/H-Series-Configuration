; Drive settings
M584 Y1 A4 ; Set driver mapping, Y returns to driver 1, A returns to driver 4
M208 X-208 Y-90 A-365 S1; Set axis minima
M208 X208 Y90 A365 S0 ; Set axis maxima
M350 Y16 A16 I1 ; Configure microstepping with interpolation
M92 Y320 A53.33 ; Set steps per mm - U axis 200steps/rev, 16 steps/step microstepping, 360mm/rev, 5.18 motor gear ration, 5 drive gear ratio
M566 Y300 A1000 ; Set maximum instantaneous speed changes (mm/min)
M203 Y12000 A20000 ; Set maximum speeds (mm/min)
M201 Y600 A600  ; Set accelerations (mm/s^2)
M906 Y2100 A1800 I30 ; Set motor currents (mA) and motor idle factor in per cent
M84 S5 ; Set idle timeout

; Endstops
M574 Y1 p"nil"
M574 A1 p"nil"
G4 P100
M574 Y1 S1 P"ystop"
M574 A1 S1 P"duex.e2stop"

while iterations < 5
 G10 P{iterations+1} Y{tools[(iterations+1)].offsets[6]}
 G10 P{iterations+1} A0

G92 Y{move.axes[6].machinePosition}
G92 A0

echo "Machine configured to standard 3-axis mode"