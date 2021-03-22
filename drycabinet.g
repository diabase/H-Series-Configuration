M308 S10 P"spi.cs6"     Y"dht22" A"Cabinet Temp"
M308 S11 P"S10.1"       Y"dhthumidity" A"Cabinet RH [%]"
M308 S12 P"e1temp" Y"thermistor" T100000 B3950 C0 A"Cabinet Safety Temp"

; Dry Cabinet
M950 H6 C"e1heat" T11 ; create heater E2 with DHT humidity as sensor
M307 H6 B1 I1; Configure inverted bang-bang control
M141 P1 H6 ; Configure dry cabinet on heater
M143 P0 H6 X10 A2 S50 ; Configure heater protection to turn off heater E1 temporarily when the DHT temperature exceeds 50C
M143 P1 H6 X12 A0 S70 ; Configure heater protection to generate a heater fault when the safety temperature exceeds 70C

M141 S10 P1