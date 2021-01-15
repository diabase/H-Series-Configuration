M308 S10 P"spi.cs6" Y"dht22" A"Cabinet Temp"                                ; Set parameters for Sensor 10: Use pin "spi.cs6", it's a "dht22" sensor type, display its name as "Cabinet Temp"
M308 S11 P"S10.1" Y"dhthumidity" A"Cabinet RH [%]"                          ; Set parameters for Sensor 11: Use pin "S10.1", it's a "dhthumidity" sensor type, display its name as "Cabinet RH %"
M308 S12 P"e1temp" Y"thermistor" T100000 B3950 C0  A"Cabinet Safety Temp"   ; Set parameters for Sensor 12: Use pin "e1ttemp", it's a thermistor sensor type, [...], display its name as "Cabinet Safety Temp"

; Dry Cabinet
M950 H6 C"e1heat" T11   ; Create Heater 6: use pin "e1heat" and Sensor 11 (dhthumidity)
M307 H6 B1 I1           ; Configure heating process parameters for Heater 6: select bang-bang control and invert it
M141 P1 H6              ; Configure Chamber Heater: Assign Heater 6 to Chamber Heater 1
M143 P0 H6 T10 A2 S50   ; Configure Temperature Monitor 0 on Heater 6: Temporarily switch off heater 6 if sensor 10 (Cabinet Temp) exceeds 50C
M143 P1 H6 T12 A0 S70   ; Configure Temperature Monitor 1 on Heater 6: Generate heater fault if sensor 12 (Cabinet Safety Temp) exceeds 70C
