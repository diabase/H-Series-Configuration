; drycabinet.g
; Configures parameters for monitoring H5 filament drying cabinet.
; Written by Diabase Engineering
; Last Updated: October 29, 2021

M118 S{"Info: Begin drycabinet.g"} L2

; Create Sensors for Dry Cabinet
M308 S10 P{global.dhtPin} Y"dht22" A"FilamentCabinetTemp"                                                                   ; Define DHT22 temperature sensor
M308 S11 P"S10.1" Y"dhthumidity" A"FilamentCabinetRH[%]"                                                                    ; Attach DHT22 humidity sensor to secondary output of temperature sensor

; Create Fans for Dry Cabinet
if global.dryCabinetFanNum == -1
    set global.dryCabinetFanNum = #fans
M118 S{"Info: Creating filament cabinet fans as fan "^{global.dryCabinetFanNum}^" using pin "^{global.fCFanPin}} L2         ; Log informational event
M950 F{global.dryCabinetFanNum} C{global.fCFanPin}                                                                          ; Filament cabinet fans

if global.fCSwitchInNum == -1                                                                                               ; If a gpIn sensor number hasn't yet been assigned for the filament cabinet switch...
    set global.fCSwitchInNum = #sensors.gpIn                                                                                ; ... take the next available gpIn sensor number
M118 S{"Info: Creating filament cabinet switch as input"^{global.fCSwitchInNum}^" using pin "^{global.fcSwitchPin}} L2      ; Log informational event
M950 J{global.fCSwitchInNum} C{global.fcSwitchPin}                                                                          ; Filament Cabinet Switch Definition
M118 S{"Info: Activation of Input"^{global.fCSwitchInNum}^" will run trigger"^global.fCSwitchOnTrigger^".g"} L2             ; Log informational event
M581 P{global.fCSwitchInNum} T{global.fCSwitchOnTrigger} S1 R0                                                              ; Filament Cabinet Engage Behavior
M118 S{"Info: Deactivation of Input"^{global.fCSwitchInNum}^" will run trigger"^global.fCSwitchOffTrigger^".g"} L2          ; Log informational event
M581 P{global.fCSwitchInNum} T{global.fCSwitchOffTrigger} S0 R0                                                             ; Filament Cabinet Release Behavior

if global.fCSwitchInNum != -1                                                                                               ; If a gpIn sensor number has been assigned for the filament cabinet switch...
    if sensors.gpIn[global.fCSwitchInNum].value == 0                                                                        ; ... and its currently in the deactivated state...
        M98 P{"trigger"^global.fCSwitchOffTrigger^".g"}                                                                     ; ... turn off the filament cabinet fans.

set global.dryCabinetLastRun = state.upTime

M118 S{"Info: End drycabinet.g"} L2
