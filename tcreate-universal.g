; tcreate-universal.g
; Creates and configures all tools
; Parameters for create-tool.g:
;   T: Variable name containing Tool Type
;   S: Variable name containing Temp Sense Pin / Spindle Speed Sense Pin
;   H: Variable name containing Heater Pin / Spindle Speed Pin
;   E: Variable name containing Extruder Drive Number / Spindle Direction Pin
;   F: Variable name containing Filament Assist Drive Number / Spindle Air Pin
; TODO: Revisit when variable arrays are available.
;   - Identifying heaters for thermostatic fan. - RT
;   - Automatically looping create-tool.g for variable-defined tools
; TODO: Revisit when spindles aren't all automatically created. - RT
; Written by Diabase Engineering
; Last Updated: July 15, 2021

M118 S{"Info: Begin tcreate-universal.g"} L2

; M291 P"Ready to create tools?" S3

; Tool 1
M98 P"create-tool.g" T{global.ToolType1} S{global.E1TempPin} H{global.EHeat1Pin} E{global.E1Drive} F{global.FA1Drive}

; Tool 2
M98 P"create-tool.g" T{global.ToolType2} S0 H{global.Spindle2SpeedPin} E{global.Spindle2DirectionPin} F{global.Spindle2AirPin}

; Tool 3
M98 P"create-tool.g" T{global.ToolType3} S{global.E3TempPin} H{global.EHeat3Pin} E{global.E3Drive} F{global.FA3Drive}

; Tool 4
M98 P"create-tool.g" T{global.ToolType4} S1 H{global.Spindle4SpeedPin} E{global.Spindle4DirectionPin} F{global.Spindle4AirPin}

; Tool 5
M98 P"create-tool.g" T{global.ToolType5} S{global.E5TempPin} H{global.EHeat5Pin} E{global.E5Drive} F{global.FA5Drive}

; Tool 10
M118 S{"Info: Creating Probe"} L2
M563 P10 S"Probe"
G10 P10 X0.00 Y0.00 Z0.00 U0.00 V0.00 W0.00 A0.00 C0.00
set global.ProbeRetractOutNum = #state.gpOut
M118 S{"Info: Creating state.gpOut[" ^ {global.ProbeRetractOutNum} ^ "] on pin " ^ {global.ProbeRetractPin} ^ " for probe retract"} L2
M950 P{global.ProbeRetractOutNum} C{global.ProbeRetractPin}                                                                             ; Probe Retract
M402 P0                                                                                                                                 ; Retract Probe

; Fans
M118 S{"Info: Creating/Configuring Fans"} L2

; FFF Fans
set global.FffFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.FffFanNum} ^"] on pin" ^ {global.FffFanPin} ^ " for FFF Fans"} L2
M950 F{global.FffFanNum} C{global.FffFanPin}                                                                 ; Extruder cooling fans
M118 S{"Info: Configuring FFF Fans (fans[" ^ {global.FffFanNum} ^"]:) Thermostatic mode (50C) on tools.[1,3,5].heaters[0]"} L2
M106 P{global.FffFanNum} H{tools[1].heaters[0]}:{tools[3].heaters[0]}:{tools[5].heaters[0]} T50 C"FFF Fans"  ; thermostatic control of cooling fan on heaters 1, 3, and 5. Turns on at 50C

; Layer Fan
set global.LayerFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.LayerFanNum} ^"] on pin" ^ {global.LayerFanPin} ^ " for Layer Fans"} L2
M950 F{global.LayerFanNum} C{global.LayerFanPin}   ; Layer cooling fans
M106 P{global.LayerFanNum}} C"Layer Fans"           ; Enable manual control of layer cooling fans

; Build Enclosure LEDs
set global.BELedFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.BELedFanNum} ^"] on pin" ^ {global.BELedPin} ^ " for Build Enclosure LEDs"} L2
M950 F{global.BELedFanNum} C{global.BELedPin}          ; Define fan for build enclosure LEDs
M106 P{global.BELedFanNum} C"Build Enclosure LEDs" S1.0 L1.0  ; Configure "fan" for build enclosure LEDs as toggle-able without dimming

; Filament Cabinet LEDs
set global.FCLedFanNum = #fans
M118 S{"Info: Creating fans[" ^ {global.FCLedFanNum} ^"] on pin" ^ {global.FCLedPin} ^ " for Filament Cabinet LEDs"} L2
M950 F{global.FCLedFanNum} C{global.FCLedPin}          ; Define fan for filament cabinet LEDs
M106 P{global.FCLedFanNum} C"Filament LEDs" S1.0 L1.0         ; Configure "fan" for filament cabinet LEDs as toggle-able without dimming

; Z-Axis Brake
set global.ZBrakeOutNum = #state.gpOut
M118 S{"Info: Creating state.gpOut[" ^ {global.ZBrakeOutNum} ^ "] on pin " ^ {global.ZBrakePin} ^ " for Z axis brake"} L2
M950 P{global.ZBrakeOutNum} C{global.ZBrakePin}            ; Z axis brake

; E-Stop Detection
set global.EStopSwitchInNum = #sensors.gpIn
M118 S{"Info: Creating sensors.gpIn["^ {global.EStopSwitchInNum} ^ "] on pin " ^ {global.EStopSwitchPin} ^" for e-stop detect switch"} L2   ; Log informational event
M950 J{global.EStopSwitchInNum} C{global.EStopSwitchPin}                                                                                    ; E-Stop Switch Definition
M118 S{"Info: Activating sensors.gpIn["^ {global.EStopSwitchInNum} ^ "] will run trigger" ^ {global.EStopOnTrigger} ^".g"} L2               ; Log informational event
M581 P{global.EStopSwitchInNum} T{global.EStopOnTrigger} S1 R0                                                                             ; E-Stop Switch Engage Behavior
M118 S{"Info: Deactivating sensors.gpIn["^ {global.EStopSwitchInNum} ^ "] will run trigger" ^ {global.EStopOffTrigger} ^".g"} L2            ; Log informational event
M581 P{global.EStopSwitchInNum} T{global.EStopOffTrigger} S0 R0                                                                             ; E-Stop Switch Release Behavior

; Extruder Crash Detection
set global.ExtruderCrashDetectInNum = #sensors.gpIn
M118 S{"Info: Creating sensors.gpIn[" ^ {global.ExtruderCrashDetectInNum} ^ "] on pin " ^ {global.ExtruderCrashDetectPin} ^ " for extruder crash detect switch"} L2 ; Log informational event
M950 J{global.ExtruderCrashDetectInNum} C{global.ExtruderCrashDetectPin}                                                                                            ; Extruder crash detect input definintion
M118 S{"Info: Activating sensors.gpIn["^ global.ExtruderCrashDetectInNum} ^ "] will run trigger" ^ {global.CDOnTrigger} ^ ".g"} L2                                  ; Log informational event
M581 P{global.ExtruderCrashDetectInNum} T{global.CDOnTrigger} S1 R0                                                                                                 ; Extruder crash detect behavior
M118 S{"Info: Deactivating sensors.gpIn[" ^ {global.ExtruderCrashDetectInNum} ^ "] will be ignored"} L2                                                             ; Log informational event
M669 S100 T0.1                                                                                                                                                      ; Split movements into smaller bits - this is necessary for the machine to be able to pause if a crash is detected

M302 S150 ; Set minimum extrude temp

if {exists(global.UMotTempPin)}
    set global.UMotTempNum = #sensors.analog
    M118 S{"Info: Creating sensors.analog[" ^ {global.UMotTempNum} ^ "] on pin " ^ {global.UMotTempPin} ^ " for measuring U-axis motor temperature"} L2 ; Log informational event
    M308 S{global.UMotTempNum} P{global.UMotTempPin} Y"thermistor" T100000 B3950 C0 A"UMot Temp"


M118 S{"Info: End tcreate-universal.g"} L2
