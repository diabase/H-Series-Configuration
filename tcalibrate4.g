M574 X1 Y1 S2 ; Configure Z-probe as endstop for XY axes
M675 X F100 R0.1; Find center of cavity on the X axis
M675 Y F100 R0.1; Find center of cavity on the Y axis
M675 X F100 R0.1; Find center of cavity on the X axis
M675 Y F100 R0.1; Find center of cavity on the Y axis

;G92 X0 Y0 ; Set new origin
M574 X1 Y1 S1 ;