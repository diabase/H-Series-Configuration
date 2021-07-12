; drycabinet.g
; Configures parameters for monitoring H5 filament drying cabinet.
; Written by Diabase Engineering
; Last Updated: July 12, 2021

; Create Sensors for Dry Cabinet
; var NewSensorNum = #sensors.analog
;M308 S{var.NewSensorNum} P{global.DhtPin} Y"dht22" A"FilamentCabinetTemp" ; define DHT22 temperature sensor
;M308 S{{var.NewSensorNum}+1} P"{{var.NewSensorNum} ^ ".1"}" Y"dhthumidity" A"FilamentCabinetRH[%]" ; Attach DHT22 humidity sensor to secondary output of temperature sensor
M308 S10 P"0.spi.cs1" Y"dht22" A"FilamentCabinetTemp" ; define DHT22 temperature sensor
M308 S11 P"S10.1" Y"dhthumidity" A"FilamentCabinetRH[%]" ; Attach DHT22 humidity sensor to secondary output of temperature sensor

; Create Fans for Dry Cabinet
var NewFanIndex = #fans
M118 S"Creating filament cabinet fans as fan "^{var.NewFanIndex}^" using pin "^{global.FCFanPin}" L2    ; Log informational event
M950 F{var.NewFanIndex} C{global.FCFanPin}                                                              ; Filament cabinet fans
M106 P{var.NewFanIndex} C"Filament Cabinet Fans" S1.0 L1.0                                              ; Enable manual control of filament cabinet fans -- TODO: Remove this after testing
set var.NewFanIndex={var.NewFanIndex+1}                                                                 ; Increment NewFanIndex
