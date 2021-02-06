; Drive settings
M584 Y2 A2.2 ; Set driver mapping, E drive is multiplexed. Hide the extra axes
M208 Y-93 A-365 S1; Set axis minima
M208 Y93 A365 S0 ; Set axis maxima
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
M574 Y1 S1 P"!io3.in"
M574 A1 S1 P"2.io3.in"