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
; Last Updated: October 13, 2021

M118 S{"Info: Begin tcreate-universal.g"} L2

; Tool 1
if global.E1HeatIndex == -1
    set global.E1HeatIndex = #heat.heaters
if global.E1TempIndex == -1
    set global.E1TempIndex = #sensors.analog
M98 P"create-tool.g" T1 Y{global.ToolType1} S{global.E1TempPin} N{global.E1TempIndex} H{global.EHeat1Pin} R{global.E1HeatIndex} E{global.E1Drive} F{global.FA1Drive}

; Tool 2
if global.Spindle2AirIndex == -1
    set global.Spindle2AirIndex = #fans
M98 P"create-tool.g" T2 Y{global.ToolType2} S0 H{global.Spindle2SpeedPin} N{global.Spindle2AirIndex} E{global.Spindle2DirectionPin} F{global.Spindle2AirPin}

; Tool 3
if global.E3HeatIndex == -1
    set global.E3HeatIndex = #heat.heaters
if global.E3TempIndex == -1
    set global.E3TempIndex = #sensors.analog
M98 P"create-tool.g" T3 Y{global.ToolType3} S{global.E3TempPin} N{global.E3TempIndex} H{global.EHeat3Pin} R{global.E3HeatIndex} E{global.E3Drive} F{global.FA3Drive}

; Tool 4
if global.Spindle4AirIndex == -1
    set global.Spindle4AirIndex = #fans
M98 P"create-tool.g" T4 Y{global.ToolType4} S1 H{global.Spindle4SpeedPin} N{global.Spindle4AirIndex} E{global.Spindle4DirectionPin} F{global.Spindle4AirPin}

; Tool 5
if global.E5HeatIndex == -1
    set global.E5HeatIndex = #heat.heaters
if global.E5TempIndex == -1
    set global.E5TempIndex = #sensors.analog
M98 P"create-tool.g" T5 Y{global.ToolType5} S{global.E5TempPin} N{global.E5TempIndex} H{global.EHeat5Pin} R{global.E5HeatIndex} E{global.E5Drive} F{global.FA5Drive}

; Tool 10
M118 S{"Info: Creating Probe"} L2
M563 P10 S"Probe"
G10 P10 X0.00 Y0.00 Z0.00 U0.00 V0.00 W0.00 A0.00 C0.00
if global.ProbeRetractOutNum == -1
    set global.ProbeRetractOutNum = #state.gpOut
M118 S{"Info: Creating state.gpOut[" ^ {global.ProbeRetractOutNum} ^ "] on pin " ^ {global.ProbeRetractPin} ^ " for probe retract"} L2
M950 P{global.ProbeRetractOutNum} C{global.ProbeRetractPin}                                                                             ; Probe Retract
M402 P0                                                                                                                                 ; Retract Probe

; Fans
M118 S{"Info: Creating/Configuring Fans"} L2

; FFF Fans
if global.FffFanNum == -1
    set global.FffFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.FffFanNum} ^"] on pin " ^ {global.FffFanPin} ^ " for FFF Fans"} L2
M950 F{global.FffFanNum} C{global.FffFanPin}                                                                 ; Extruder cooling fans
M118 S{"Info: Configuring FFF Fans (fans[" ^ {global.FffFanNum} ^"]:) Thermostatic mode (50C) on tools.[1,3,5].heaters[0]"} L2
M106 P{global.FffFanNum} H{tools[1].heaters[0]}:{tools[3].heaters[0]}:{tools[5].heaters[0]} T50 C"FFF Fans"  ; thermostatic control of cooling fan on heaters 1, 3, and 5. Turns on at 50C

; Layer Fan
if global.LayerFanNum == -1
    set global.LayerFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.LayerFanNum} ^"] on pin " ^ {global.LayerFanPin} ^ " for Layer Fans"} L2
M950 F{global.LayerFanNum} C{global.LayerFanPin}   ; Layer cooling fans
M106 P{global.LayerFanNum}} C"Layer Fans"           ; Enable manual control of layer cooling fans

; Build Enclosure LEDs
if global.BELedFanNum == -1
    set global.BELedFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.BELedFanNum} ^"] on pin " ^ {global.BELedPin} ^ " for Build Enclosure LEDs"} L2
M950 F{global.BELedFanNum} C{global.BELedPin}          ; Define fan for build enclosure LEDs
M106 P{global.BELedFanNum} C"Build Enclosure LEDs" S1.0 L1.0  ; Configure "fan" for build enclosure LEDs as toggle-able without dimming

; Filament Cabinet LEDs
if global.FCLedFanNum == -1
    set global.FCLedFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.FCLedFanNum} ^"] on pin " ^ {global.FCLedPin} ^ " for Filament Cabinet LEDs"} L2
M950 F{global.FCLedFanNum} C{global.FCLedPin}          ; Define fan for filament cabinet LEDs
M106 P{global.FCLedFanNum} C"Filament LEDs" S1.0 L1.0         ; Configure "fan" for filament cabinet LEDs as toggle-able without dimming

; Z-Axis Brake
if global.ZBrakeOutNum == -1
    set global.ZBrakeOutNum = #state.gpOut
M118 S{"Info: Creating state.gpOut[" ^ {global.ZBrakeOutNum} ^ "] on pin " ^ {global.ZBrakePin} ^ " for Z axis brake"} L2
M950 P{global.ZBrakeOutNum} C{global.ZBrakePin}            ; Z axis brake

; E-Stop Detection
if global.EStopSwitchInNum == -1
    set global.EStopSwitchInNum = #sensors.gpIn
M118 S{"Info: Creating sensors.gpIn["^ {global.EStopSwitchInNum} ^ "] on pin " ^ {global.EStopSwitchPin} ^" for e-stop detect switch"} L2   ; Log informational event
M950 J{global.EStopSwitchInNum} C{global.EStopSwitchPin}                                                                                    ; E-Stop Switch Definition
M118 S{"Info: Activating sensors.gpIn["^ {global.EStopSwitchInNum} ^ "] will run trigger" ^ {global.EStopOnTrigger} ^".g"} L2               ; Log informational event
M581 P{global.EStopSwitchInNum} T{global.EStopOnTrigger} S1 R0                                                                             ; E-Stop Switch Engage Behavior
M118 S{"Info: Deactivating sensors.gpIn["^ {global.EStopSwitchInNum} ^ "] will run trigger" ^ {global.EStopOffTrigger} ^".g"} L2            ; Log informational event
M581 P{global.EStopSwitchInNum} T{global.EStopOffTrigger} S0 R0                                                                             ; E-Stop Switch Release Behavior

; Extruder Crash Detection
if global.ExtruderCrashDetectInNum == -1
    set global.ExtruderCrashDetectInNum = #sensors.gpIn
M118 S{"Info: Creating sensors.gpIn[" ^ {global.ExtruderCrashDetectInNum} ^ "] on pin " ^ {global.ExtruderCrashDetectPin} ^ " for extruder crash detect switch"} L2 ; Log informational event
M950 J{global.ExtruderCrashDetectInNum} C{global.ExtruderCrashDetectPin}                                                                                            ; Extruder crash detect input definintion
M118 S{"Info: Activating sensors.gpIn["^ {global.ExtruderCrashDetectInNum} ^ "] will run trigger" ^ {global.CDOnTrigger} ^ ".g"} L2                                 ; Log informational event
M581 P{global.ExtruderCrashDetectInNum} T{global.CDOnTrigger} S1 R0                                                                                                 ; Extruder crash detect behavior
M118 S{"Info: Deactivating sensors.gpIn[" ^ {global.ExtruderCrashDetectInNum} ^ "] will be ignored"} L2                                                             ; Log informational event
M669 S100 T0.1                                                                                                                                                      ; Split movements into smaller bits - this is necessary for the machine to be able to pause if a crash is detected

; Monitor Compressed Air Pressure
if global.AirPressureInNum == -1
    set global.AirPressureInNum = #sensors.gpIn
M118 S{"Info: Creating sensors.gpIn[" ^ {global.AirPressureInNum} ^ "] on pin " ^ {global.AirPressureSwitchPin} ^ " for incoming air pressure switch"} L2   ; Log informational event
M950 J{global.AirPressureInNum} C{global.AirPressureSwitchPin}                                                                                              ; Air pressure switch input definintion
M118 S{"Info: Activating sensors.gpIn[" ^ {global.AirPressureInNum} ^ "] will be ignored"} L2                                                               ; Log informational event
M118 S{"Info: Deactivating sensors.gpIn["^ {global.AirPressureInNum} ^ "] will run trigger" ^ {global.AirPressureLowTrigger} ^ ".g"} L2                     ; Log informational event
M581 P{global.AirPressureInNum} T{global.AirPressureLowTrigger} S0 R0                                                                                       ; Air pressure switch behavior

; Monitor Build Enclosure Switch
if global.BESwitchInNum == -1                                                                                                           ; If a gpIn sensor number hasn't yet been assigned for the build enclosure switch...
    set global.BESwitchInNum = #sensors.gpIn                                                                                            ; ... take the next available gpIn sensor number
M118 S{"Info: Creating sensors.gpIn[" ^ {global.BESwitchInNum} ^ "] on pin " ^{global.BESwitchPin} ^" for build enclosure switch"} L2   ; Log informational event
M950 J{global.BESwitchInNum} C{global.BESwitchPin}                                                                                      ; Build Enclosure Switch Definition
M118 S{"Info: Activating sensors.gpIn[" ^ {global.BESwitchInNum} ^ "] will run trigger" ^ {global.BESwitchHighTrigger} ^ ".g"} L2       ; Log informational event
M581 P{global.BESwitchInNum} T{global.BESwitchHighTrigger} S1 R0                                                                        ; Build Enclosure Close Behavior
M118 S{"Info: Deactivating sensors.gpIn[" ^ {global.BESwitchInNum} ^ "] will run trigger" ^ {global.BESwitchLowTrigger} ^ ".g"} L2      ; Log informational event
M581 P{global.BESwitchInNum} T{global.BESwitchLowTrigger} S0 R0                                                                         ; Build Enclosure Open Behavior

M302 S150 ; Set minimum extrude temp

if {exists(global.UMotTempPin)}
    if global.UMotTempNum == -1
        set global.UMotTempNum = #sensors.analog
    M118 S{"Info: Creating sensors.analog[" ^ {global.UMotTempNum} ^ "] on pin " ^ {global.UMotTempPin} ^ " for measuring U-axis motor temperature"} L2 ; Log informational event
    M308 S{global.UMotTempNum} P{global.UMotTempPin} Y"thermistor" T100000 B3950 C0 A"UMot Temp"

set global.TCreateLastRun = state.upTime

M118 S{"Info: End tcreate-universal.g"} L2
