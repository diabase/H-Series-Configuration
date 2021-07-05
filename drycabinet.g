; drycabinet.g
; Configures parameters for monitoring H5 filament drying cabinet.
; Written by Diabase Engineering
; Last Updated: July 19, 2021

; Create Sensors for Dry Cabinet
M308 S10 P"0.spi.cs1" Y"dht22" A"Filament Cabinet Temp" ; define DHT22 temperature sensor
M308 S11 P"S10.1" Y"dhthumidity" A"Filament Cabinet Humidity [%]" ; Attach DHT22 humidity sensor to secondary output of temperature sensor
