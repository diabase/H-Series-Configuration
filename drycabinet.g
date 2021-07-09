; drycabinet.g
; Configures parameters for monitoring H5 filament drying cabinet.
; Written by Diabase Engineering
; Last Updated: July 9, 2021

var NewSensorNum = #sensors.analog
;echo "NewSensorNum is "^var.NewSensorNum

; Create Sensors for Dry Cabinet
;M308 S{var.NewSensorNum} P{global.DhtPin} Y"dht22" A"FilamentCabinetTemp" ; define DHT22 temperature sensor
;M308 S{{var.NewSensorNum}+1} P"{{var.NewSensorNum} ^ ".1"}" Y"dhthumidity" A"FilamentCabinetRH[%]" ; Attach DHT22 humidity sensor to secondary output of temperature sensor
M308 S10 P"0.spi.cs1" Y"dht22" A"FilamentCabinetTemp" ; define DHT22 temperature sensor
M308 S11 P"S10.1" Y"dhthumidity" A"FilamentCabinetRH[%]" ; Attach DHT22 humidity sensor to secondary output of temperature sensor
