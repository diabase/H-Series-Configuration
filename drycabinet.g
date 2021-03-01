M305 P101 X405 S"Cabinet Temp" T22
M305 P102 X455 S"Cabinet RH [%]" T22
M305 P103 X2 T100000 B3950 C0 R4700 S"Cabinet Safety Temp"

; Dry Cabinet
M305 P2 X455 S"Dry Cabinet" ; Assign RH channel to heater E2
M307 H2 I1 B1 ; Configure inverted bang-bang control on E2
M141 P1 H2 ; Configure dry cabinet on heater E2
M143 P100 H2 X101 A2 S50 ; Configure heater protection to turn off heater E1 temporarily when the DHT temperature exceeds 50C
M143 P101 H2 X103 A0 S70 ; Configure heater protection to generate a heater fault when the safety temperature exceeds 70C