; tcreate-universal.g
; Creates and configures all tools
; Parameters for create-tool.g:
;   T: Tool Number
;   Y: Tool Type
;   S: Temp Sense Pin if Extruder / Spindle Index if Spindle
;   N: Temp Sense Index if Extruder / "Fan" Index for Air Assist if Spindle
;   H: Heater Pin if Extruder / Spindle Speed Pin if Spindle
;   R: Heater Index
;   E: Extruder Drive Number if Extruder / Spindle Direction Pin if Spindle
;   F: Filament Assist Drive Number if Extruder / Spindle Air Pin if Spindle
; TODO: Revisit when variable arrays are available.
;   - Identifying heaters for thermostatic fan. - RT
;   - Automatically looping create-tool.g for variable-defined tools
; TODO: Revisit when spindles aren't all automatically created. - RT
; Written by Diabase Engineering
; Last Updated: January 31, 2022

M118 S{"Info: Begin tcreate-universal.g"} L2

; Fans
M118 S{"Info: Creating/Configuring Fans"} L2

; FFF Fans
if global.fffFanNum == -1
    set global.fffFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.fffFanNum} ^"] on pin " ^ {global.fffFanPin} ^ " for FFF Fans"} L2
M950 F{global.fffFanNum} C{global.fffFanPin}                                                                 ; Extruder cooling fans

; Layer Fan
if global.layerFanNum == -1
    set global.layerFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.layerFanNum} ^"] on pin " ^ {global.layerFanPin} ^ " for Layer Fans"} L2
M950 F{global.layerFanNum} C{global.layerFanPin}   ; Layer cooling fans
M106 P{global.layerFanNum}} C"Layer Fans"           ; Enable manual control of layer cooling fans

; Tool 1
if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    if global.e1HeatIndex == -1
        set global.e1HeatIndex = #heat.heaters
    if global.e1TempIndex == -1
        set global.e1TempIndex = #sensors.analog
    M98 P"create-tool.g" T1 Y{global.toolType1} S{global.e1TempPin} N{global.e1TempIndex} H{global.eHeat1Pin} R{global.e1HeatIndex} E{global.e1Drive} F{global.fA1Drive}

; Tool 2
if global.spindle2AirIndex == -1
    set global.spindle2AirIndex = #fans
M98 P"create-tool.g" T2 Y{global.toolType2} S0 H{global.spindle2SpeedPin} N{global.spindle2AirIndex} E{global.spindle2DirectionPin} F{global.spindle2AirPin}

; Tool 3
if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    if global.eHeat3Pin == "nil"
        set global.eHeat3Pin = global.eHeat4Pin
        set global.eHeat4Pin = "nil"
    if global.fSense3Pin  == "nil"
        set global.fSense3Pin = global.fSense4Pin
        set global.fSense4Pin = "nil"
    if global.e3TempPin == "nil"
        set global.e3TempPin = global.e4TempPin
        set global.e4TempPin = "nil"
elif {global.machineModel} == "H5B"
    if global.eHeat3Pin == "nil"
        set global.eHeat3Pin = global.eHeat1Pin
        set global.eHeat1Pin = "nil"
    if global.fSense3Pin  == "nil"
        set global.fSense3Pin = global.fSense1Pin
        set global.fSense1Pin = "nil"
    if global.e3TempPin == "nil"
        set global.e3TempPin = global.e1TempPin
        set global.e1TempPin = "nil"

if global.e3HeatIndex == -1
    set global.e3HeatIndex = #heat.heaters
if global.e3TempIndex == -1
    set global.e3TempIndex = #sensors.analog
M98 P"create-tool.g" T3 Y{global.toolType3} S{global.e3TempPin} N{global.e3TempIndex} H{global.eHeat3Pin} R{global.e3HeatIndex} E{global.e3Drive} F{global.fA3Drive}

; ;Tool 4
if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    if global.spindle4AirIndex == -1
        set global.spindle4AirIndex = #fans
    M98 P"create-tool.g" T4 Y"Spindle" S1 H{global.spindle4SpeedPin} N{global.spindle4AirIndex} E{global.spindle4DirectionPin} F{global.spindle4AirPin}
if {global.machineModel} == "H5B"
    if global.e4HeatIndex == -1
        set global.e4HeatIndex = #heat.heaters
    if global.e4TempIndex == -1
        set global.e4TempIndex = #sensors.analog
    M98 P"create-tool.g" T4 Y"HT Extruder" S{global.e4TempPin} N{global.e4TempIndex} H{global.eHeat4Pin} R{global.e4HeatIndex} E{global.e4Drive} F{global.fA4Drive}

; Tool 5
if global.e5HeatIndex == -1
    set global.e5HeatIndex = #heat.heaters
if global.e5TempIndex == -1
    set global.e5TempIndex = #sensors.analog
M98 P"create-tool.g" T5 Y{global.toolType5} S{global.e5TempPin} N{global.e5TempIndex} H{global.eHeat5Pin} R{global.e5HeatIndex} E{global.e5Drive} F{global.fA5Drive}

; Probe
if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    set global.zProbeToolNum = 10
elif {global.machineModel} == "H5B"
    set global.zProbeToolNum = 1

M98 P"create-tool.g" T{global.zProbeToolNum} Y"Probe"

; Tools 11 - 24 (Tool Changer)
if {global.machineModel} == "H5B"
    while iterations < 24
        if iterations < 10
            continue
        M118 S{"Info: Creating Tool " ^ {iterations+1}} L2
        M98 P"create-tool.g" T{iterations+1} Y"TC Tool" S2

if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    M118 S{"Info: Configuring FFF Fans (fans[" ^ {global.fffFanNum} ^"]:) Thermostatic mode (50C) on tools.[1,3,5].heaters[0]"} L2
    if {boards[0].firmwareVersion == "3.3"}
        M106 P{global.fffFanNum} H{tools[1].heaters[0]}:{tools[3].heaters[0]}:{tools[5].heaters[0]} T50 C"FFF Fans"                                                             ; thermostatic control of cooling fan on heaters 1, 3, and 5. Turns on at 50C
    elif {boards[0].firmwareVersion != "3.3"}
        M106 P{global.fffFanNum} H{tools[1].heaters[0],tools[3].heaters[0],tools[5].heaters[0]} T50 C"FFF Fans"                                                                 ; thermostatic control of cooling fan on heaters 1, 3, and 5. Turns on at 50C
elif {global.machineModel} == "H5B"
    M118 S{"Info: Configuring FFF Fans (fans[" ^ {global.fffFanNum} ^"]:) Thermostatic mode (50C) on tools.[3,4,5].heaters[0]"} L2
    if {boards[0].firmwareVersion == "3.3"}
        M106 P{global.fffFanNum} H{{tools[3].heaters[0]}:{tools[4].heaters[0]}:{tools[5].heaters[0]}} T50 C"FFF Fans"                                                             ; thermostatic control of cooling fan on heaters for tools 3, 4, and 5. Turns on at 50C
    elif {boards[0].firmwareVersion != "3.3"}
        M106 P{global.fffFanNum} H{tools[3].heaters[0],tools[4].heaters[0],tools[5].heaters[0]} T50 C"FFF Fans"                                                                 ; thermostatic control of cooling fan on heaters for tools 3, 4, and 5. Turns on at 50C

; Build Enclosure LEDs
if global.bELedFanNum == -1
    set global.bELedFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.bELedFanNum} ^"] on pin " ^ {global.bELedPin} ^ " for Build Enclosure LEDs"} L2
M950 F{global.bELedFanNum} C{global.bELedPin}          ; Define fan for build enclosure LEDs
M106 P{global.bELedFanNum} C"Build Enclosure LEDs" S1.0 L1.0  ; Configure "fan" for build enclosure LEDs as toggle-able without dimming

; Filament Cabinet LEDs
if global.fCLedFanNum == -1
    set global.fCLedFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.fCLedFanNum} ^"] on pin " ^ {global.fCLedPin} ^ " for Filament Cabinet LEDs"} L2
M950 F{global.fCLedFanNum} C{global.fCLedPin}          ; Define fan for filament cabinet LEDs
M106 P{global.fCLedFanNum} C"Filament LEDs" S1.0 L1.0         ; Configure "fan" for filament cabinet LEDs as toggle-able without dimming

; Status LEDs
if global.redLedOutNum == -1
    set global.redLedOutNum = #state.gpOut
M118 S{"Info: Creating state.gpOut[" ^ {global.redLedOutNum} ^ "] on pin " ^ {global.redLedPin} ^ " for red status LED"} L2
M950 P{global.redLedOutNum} C{global.redLedPin}            ; Red Status LED

if global.greenLedOutNum == -1
    set global.greenLedOutNum = #state.gpOut
M118 S{"Info: Creating state.gpOut[" ^ {global.greenLedOutNum} ^ "] on pin " ^ {global.greenLedPin} ^ " for green status LED"} L2
M950 P{global.greenLedOutNum} C{global.greenLedPin}            ; Green Status LED

; Z-Axis Brake
if global.zBrakeOutNum == -1
    set global.zBrakeOutNum = #state.gpOut
M118 S{"Info: Creating state.gpOut[" ^ {global.zBrakeOutNum} ^ "] on pin " ^ {global.zBrakePin} ^ " for Z axis brake"} L2
M950 P{global.zBrakeOutNum} C{global.zBrakePin}            ; Z axis brake

; E-Stop Detection
if global.eStopSwitchInNum == -1
    set global.eStopSwitchInNum = #sensors.gpIn
M118 S{"Info: Creating sensors.gpIn["^ {global.eStopSwitchInNum} ^ "] on pin " ^ {global.eStopSwitchPin} ^" for e-stop detect switch"} L2   ; Log informational event
M950 J{global.eStopSwitchInNum} C{global.eStopSwitchPin}                                                                                    ; E-Stop Switch Definition
M118 S{"Info: Activating sensors.gpIn["^ {global.eStopSwitchInNum} ^ "] will run trigger" ^ {global.eStopOnTrigger} ^".g"} L2               ; Log informational event
M581 P{global.eStopSwitchInNum} T{global.eStopOnTrigger} S1 R0                                                                             ; E-Stop Switch Engage Behavior
M118 S{"Info: Deactivating sensors.gpIn["^ {global.eStopSwitchInNum} ^ "] will run trigger" ^ {global.eStopOffTrigger} ^".g"} L2            ; Log informational event
M581 P{global.eStopSwitchInNum} T{global.eStopOffTrigger} S0 R0                                                                             ; E-Stop Switch Release Behavior

; Extruder Crash Detection
if global.extruderCrashDetectInNum == -1
    set global.extruderCrashDetectInNum = #sensors.gpIn
M118 S{"Info: Creating sensors.gpIn[" ^ {global.extruderCrashDetectInNum} ^ "] on pin " ^ {global.extruderCrashDetectPin} ^ " for extruder crash detect switch"} L2 ; Log informational event
M950 J{global.extruderCrashDetectInNum} C{global.extruderCrashDetectPin}                                                                                            ; Extruder crash detect input definintion
M118 S{"Info: Activating sensors.gpIn["^ {global.extruderCrashDetectInNum} ^ "] will run trigger" ^ {global.cDOnTrigger} ^ ".g"} L2                                 ; Log informational event
M581 P{global.extruderCrashDetectInNum} T{global.cDOnTrigger} S1 R0                                                                                                 ; Extruder crash detect behavior
M118 S{"Info: Deactivating sensors.gpIn[" ^ {global.extruderCrashDetectInNum} ^ "] will be ignored"} L2                                                             ; Log informational event
M669 S100 T0.1                                                                                                                                                      ; Split movements into smaller bits - this is necessary for the machine to be able to pause if a crash is detected

; Monitor Compressed Air Pressure
if global.airPressureInNum == -1
    set global.airPressureInNum = #sensors.gpIn
M118 S{"Info: Creating sensors.gpIn[" ^ {global.airPressureInNum} ^ "] on pin " ^ {global.airPressureSwitchPin} ^ " for incoming air pressure switch"} L2   ; Log informational event
M950 J{global.airPressureInNum} C{global.airPressureSwitchPin}                                                                                              ; Air pressure switch input definintion
M118 S{"Info: Activating sensors.gpIn[" ^ {global.airPressureInNum} ^ "] will be ignored"} L2                                                               ; Log informational event
M118 S{"Info: Deactivating sensors.gpIn["^ {global.airPressureInNum} ^ "] will run trigger" ^ {global.airPressureLowTrigger} ^ ".g"} L2                     ; Log informational event
M581 P{global.airPressureInNum} T{global.airPressureLowTrigger} S0 R0                                                                                       ; Air pressure switch behavior

; Monitor Build Enclosure Switch
if global.bESwitchInNum == -1                                                                                                           ; If a gpIn sensor number hasn't yet been assigned for the build enclosure switch...
    set global.bESwitchInNum = #sensors.gpIn                                                                                            ; ... take the next available gpIn sensor number
M118 S{"Info: Creating sensors.gpIn[" ^ {global.bESwitchInNum} ^ "] on pin " ^{global.bESwitchPin} ^" for build enclosure switch"} L2   ; Log informational event
M950 J{global.bESwitchInNum} C{global.bESwitchPin}                                                                                      ; Build Enclosure Switch Definition
M118 S{"Info: Activating sensors.gpIn[" ^ {global.bESwitchInNum} ^ "] will run trigger" ^ {global.bESwitchHighTrigger} ^ ".g"} L2       ; Log informational event
M581 P{global.bESwitchInNum} T{global.bESwitchHighTrigger} S1 R0                                                                        ; Build Enclosure Close Behavior
M118 S{"Info: Deactivating sensors.gpIn[" ^ {global.bESwitchInNum} ^ "] will run trigger" ^ {global.bESwitchLowTrigger} ^ ".g"} L2      ; Log informational event
M581 P{global.bESwitchInNum} T{global.bESwitchLowTrigger} S0 R0                                                                         ; Build Enclosure Open Behavior

if {global.machineModel} == "H5B"
    ; Turret Lock
    if global.tLockOutNum == -1
        set global.tLockOutNum = #state.gpOut
    M118 S{"Info: Creating state.gpOut[" ^ {global.tLockOutNum} ^ "] on pin " ^ {global.tLockPin} ^ " for turret lock solenoid"} L2     ; Log informational event
    M950 P{global.tLockOutNum} C{global.tLockPin}
    
    ; Main Drawbar Solenoid
    if global.dbarOutNum == -1
        set global.dbarOutNum = #state.gpOut
    M118 S{"Info: Creating state.gpOut[" ^ {global.dbarOutNum} ^ "] on pin " ^ {global.dbarPin} ^ " for drawbar solenoid"} L2           ; Log informational event
    M950 P{global.dbarOutNum} C{global.dbarPin}
    
    ; Drawbar Spindle Indexing Pressure Select
    if global.spindleIndexOutNum == -1
        set global.spindleIndexOutNum = #state.gpOut
    M118 S{"Info: Creating state.gpOut[" ^ {global.spindleIndexOutNum} ^ "] on pin " ^ {global.spindleIndexPin} ^ " for drawbar spindle indexing pressure select"} L2   ; Log informational event
    M950 P{global.spindleIndexOutNum} C{global.spindleIndexPin}
    
    ; Drawbar Position Sensors
    if global.spindleIndexSense1InNum == -1
        set global.spindleIndexSense1InNum = #sensors.gpIn
    M118 S{"Info: Creating sensors.gpIn[" ^ {global.spindleIndexSense1InNum} ^ "] on pin " ^ {global.spindleIndexSense1Pin} ^ " drawbar position sensor"} L2            ; Log informational event
    M950 J{global.spindleIndexSense1InNum} C{global.spindleIndexSense1Pin}                                                                                              ; Define input
    M118 S{"Info: Activating sensors.gpIn[" ^ {global.spindleIndexSense1InNum} ^ "] will not run a trigger"} L2                                                         ; Log informational event
    M118 S{"Info: Deactivating sensors.gpIn["^ {global.spindleIndexSense1InNum} ^ "] will not run a trigger"} L2                                                        ; Log informational event
    if global.spindleIndexSense2InNum == -1
        set global.spindleIndexSense2InNum = #sensors.gpIn
    M118 S{"Info: Creating sensors.gpIn[" ^ {global.spindleIndexSense2InNum} ^ "] on pin " ^ {global.spindleIndexSense2Pin} ^ " drawbar position sensor"} L2            ; Log informational event
    M950 J{global.spindleIndexSense2InNum} C{global.spindleIndexSense2Pin}                                                                                              ; Define input
    M118 S{"Info: Activating sensors.gpIn[" ^ {global.spindleIndexSense2InNum} ^ "] will not run a trigger"} L2                                                         ; Log informational event
    M118 S{"Info: Deactivating sensors.gpIn["^ {global.spindleIndexSense2InNum} ^ "] will not run a trigger"} L2                                                        ; Log informational event

    ; Toolchanger Tool Release
    if global.tCToolReleaseOutNum == -1
        set global.tCToolReleaseOutNum = #state.gpOut
    M118 S{"Info: Creating state.gpOut[" ^ {global.tCToolReleaseOutNum} ^ "] on pin " ^ {global.tCToolReleasePin} ^ " for tool changer tool release"} L2                ; Log informational event
    M950 P{global.tCToolReleaseOutNum} C{global.tCToolReleasePin}
    
    ; Z High Switch
    if global.zHighInNum == -1
        set global.zHighInNum = #sensors.gpIn
    M118 S{"Info: Creating sensors.gpIn[" ^ {global.zHighInNum} ^ "] on pin " ^ {global.zHighSwitchPin} ^ " for High Z Switch"} L2  ; Log informational event
    M950 J{global.zHighInNum} C{global.zHighSwitchPin}                                                                              ; Input definintion
    M118 S{"Info: Activating sensors.gpIn[" ^ {global.zHighInNum} ^ "] will be ignored"} L2                                         ; Log informational event
    M118 S{"Info: Deactivating sensors.gpIn["^ {global.zHighInNum} ^ "] will be ignored"} L2                                        ; Log informational event


M302 S150 ; Set minimum extrude temp

if {exists(global.uMotTempPin)}
    if global.uMotTempNum == -1
        set global.uMotTempNum = #sensors.analog
    M118 S{"Info: Creating sensors.analog[" ^ {global.uMotTempNum} ^ "] on pin " ^ {global.uMotTempPin} ^ " for measuring U-axis motor temperature"} L2 ; Log informational event
    M308 S{global.uMotTempNum} P{global.uMotTempPin} Y"thermistor" T100000 B3950 C0 A"UMot Temp"

set global.tCreateLastRun = state.upTime

M118 S{"Info: End tcreate-universal.g"} L2
