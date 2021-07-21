; drycabinet.g
; Configures parameters for monitoring H5 filament drying cabinet.
; Written by Diabase Engineering
; Last Updated: July 20, 2021

M118 S{"Info: Begin drycabinet.g"} L2

; Create Sensors for Dry Cabinet
; var NewSensorNum = #sensors.analog
;M308 S{var.NewSensorNum} P{global.DhtPin} Y"dht22" A"FilamentCabinetTemp" ; define DHT22 temperature sensor
;M308 S{{var.NewSensorNum}+1} P"{{var.NewSensorNum} ^ ".1"}" Y"dhthumidity" A"FilamentCabinetRH[%]" ; Attach DHT22 humidity sensor to secondary output of temperature sensor
M308 S10 P"0.spi.cs1" Y"dht22" A"FilamentCabinetTemp" ; define DHT22 temperature sensor
M308 S11 P"S10.1" Y"dhthumidity" A"FilamentCabinetRH[%]" ; Attach DHT22 humidity sensor to secondary output of temperature sensor

; Create Fans for Dry Cabinet
var NewFanIndex = #fans
M118 S{"Info: Creating filament cabinet fans as fan "^{var.NewFanIndex}^" using pin "^{global.FCFanPin}} L2    ; Log informational event
M950 F{var.NewFanIndex} C{global.FCFanPin}                                                              ; Filament cabinet fans
M106 P{var.NewFanIndex} C"Filament Cabinet Fan" S1.0 L1.0                                               ; Enable manual control of filament cabinet fans -- TODO: Remove this after testing
set var.NewFanIndex={var.NewFanIndex+1}                                                                 ; Increment NewFanIndex

var NewInputIndex = #sensors.gpIn
M118 S{"Info: Creating filament cabinet switch as input"^{var.NewInputIndex}^" using pin "^{global.FCSwitchPin}} L2    ; Log informational event
M950 J{var.NewInputIndex} C{global.FCSwitchPin}                    ; Filament Cabinet Switch Definition
M118 S{"Info: Activation of Input"^{var.NewInputIndex}^" will run trigger"^global.FCSwitchOnTrigger^".g"} L2    ; Log informational event
M581 P{var.NewInputIndex} T{global.FCSwitchOnTrigger} S1 R0     ; Filament Cabinet Engage Behavior
M118 S{"Info: Deactivation of Input"^{var.NewInputIndex}^" will run trigger"^global.FCSwitchOffTrigger^".g"} L2    ; Log informational event
M581 P{var.NewInputIndex} T{global.FCSwitchOffTrigger} S0 R0    ; Filament Cabinet Release Behavior
set var.NewInputIndex = {var.NewInputIndex+1}                   ; Increment NewInputIndex

set global.DryCabinetLastRun = state.upTime

M118 S{"Info: End drycabinet.g"} L2
