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
; Last Updated: July 9, 2021

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
var NewFanIndex = #fans

M950 F{var.NewFanIndex} C{global.FffFanPin}                                                                 ; Extruder cooling fans
M106 P{var.NewFanIndex} H{tools[1].heaters[0]}:{tools[3].heaters[0]}:{tools[5].heaters[0]} T50 C"FFF Fans"  ; thermostatic control of cooling fan on heaters 1, 3, and 5. Turns on at 50C
set var.NewFanIndex={var.NewFanIndex+1}                                                                     ; Increment NewFanIndex

M950 F{var.NewFanIndex} C{global.LayerFanPin}   ; Layer cooling fans
M106 P{var.NewFanIndex} C"Layer Fans"           ; Enable manual control of layer cooling fans
set var.NewFanIndex={var.NewFanIndex+1}         ; Increment NewFanIndex

M950 F{var.NewFanIndex} C{global.BELedPin}          ; Define fan for build enclosure LEDs
M106 P{var.NewFanIndex} C"Build Enclosure LEDs" S1.0 L1.0  ; Configure "fan" for build enclosure LEDs as toggle-able without dimming
set var.NewFanIndex={var.NewFanIndex+1}             ; Increment NewFanIndex

M950 F{var.NewFanIndex} C{global.FCLedPin}          ; Define fan for filament cabinet LEDs
M106 P{var.NewFanIndex} C"Filament LEDs" S1.0 L1.0         ; Configure "fan" for filament cabinet LEDs as toggle-able without dimming
set var.NewFanIndex={var.NewFanIndex+1}             ; Increment NewFanIndex

; I/O pins and Associated Behavior
M950 P2 C{global.ZBrakePin}            ; Z axis brake

var NewInputIndex = #sensors.gpIn
M118 S{"Info: Creating E-Stop Detect Switch as sensors.gpIn["^var.NewInputIndex^"] using pin "^global.EStopSwitchPin} L2    ; Log informational event
M950 J{var.NewInputIndex} C{global.EStopSwitchPin}       ; E-Stop Switch Definition
M118 S{"Info: Activation of Input"^{var.NewInputIndex}^" will run trigger"^global.EStopOnTrigger^".g"} L2    ; Log informational event
M581 P{var.NewInputIndex} T{global.EStopOnTrigger} S1 R0                       ; E-Stop Switch Engage Behavior
M118 S{"Info: Deactivation of Input"^{var.NewInputIndex}^" will run trigger"^global.EStopOffTrigger^".g"} L2    ; Log informational event
M581 P{var.NewInputIndex} T{global.EStopOffTrigger} S0 R0                       ; E-Stop Switch Release Behavior
set var.NewInputIndex = {var.NewInputIndex+1}                   ; Increment NewInputIndex

; Extruder crash detection
M118 S{"Info: Creating Extruder Crash Detect Switch as sensors.gpIn["^var.NewInputIndex^"] using pin "^global.ExtruderCrashDetectPin} L2    ; Log informational event
M950 J{var.NewInputIndex} C{global.ExtruderCrashDetectPin} ;define pin for crash detection
M118 S{"Info: Activation of Input"^{var.NewInputIndex}^" will run trigger"^global.CDOnTrigger^".g"} L2    ; Log informational event
M581 P{var.NewInputIndex} T{global.CDOnTrigger} S1 R0    ;triggers any time (printing or jogging), runs "trigger2.g"
M118 S{"Info: Deactivation of Input"^{var.NewInputIndex}^" will be ignored"} L2    ; Log informational event
M669 S100 T0.1      ;break up movements into smaller bits - this is necessary for the machine to be able to pause if a crash is detected

M302 S150 ; Set minimum extrude temp

M118 S{"Info: End tcreate-universal.g"} L2
