; create-tool.g
; Creates a new tool with the inbound parameters
; Parameters:
;   T: Tool Number
;   Y: Variable name containing Tool Type
;   S: Variable name containing Temp Sense Pin / Spindle Index / Tool Changer Tool Number of Spindle
;   N: Variable name containing Temp Sense Index / "Fan" Number for Spindle Air
;   H: Variable name containing Heater Pin / Spindle Speed Pin
;   R: Variable name containing Heater Index
;   E: Variable name containing Extruder Drive Number / Spindle Direction Pin
;   F: Variable name containing Filament Assist Drive Number / Spindle Air Pin
; Written by Diabase Engineering
; Last Updated: December 14, 2021

M118 S{"Info: Begin create-tool.g."} L2

var newUOffset = 0
var newBOffset = 0
if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    M118 S{"Info: Using H5A Tool Spacings"} L2
    set var.newUOffset = {{{param.T - 1} * -72} - 30}
elif {global.machineModel} == "H5B"
    M118 S{"Info: Using H5B Tool Spacings"} L2
    if {{param.T} <= 5}
        set var.newUOffset = {{{param.T - 1} * -72} - 36}
    elif {{param.T} >= 11}
        set var.newUOffset = tools[{param.S}].offsets[3]          ; For tool changer tools, get the u-axis offset from its associated spindle
        if {{param.T} <= 17}
            set var.newBOffset = -{{{18 - {param.T}} * 30} + 3}
        elif {{param.T} > 17}
            set var.newBOffset = -{{{18 - {param.T}} * 30} - 33}
    M118 S{"Info: var.newBOffset is " ^ var.newBOffset} L2

; Extruder and High Temp Extruder
if {{param.Y == "Extruder"} || {param.Y == "HT Extruder"}}
    var extruderIndex = 0
    var fAIndex = 0
    while iterations < #move.extruders
        if {({param.E} ^ "") == (move.extruders[iterations].driver ^ "")}
            set var.extruderIndex = iterations
        elif {({param.F} ^ "") == (move.extruders[iterations].driver ^ "")}
            set var.fAIndex = iterations

    M118 S{"Info: Creating Nozzle "^param.T^" using Heater "^param.R^", Sensor "^param.N^", Extruder "^var.extruderIndex^", FA "^var.fAIndex} L2
    M308 S{param.N} P{param.S} Y"thermistor" T100000 B3950 C0 A{"Nozzle "^{param.T}}                                ; Create a new sensor assigned to the temp sense pin parameter, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle #"
    M950 H{param.R} C{param.H} T{param.N}                                                                           ; Create a new heater using the heater pin parameter and the newly created sensor
    if {param.Y == "Extruder"}
        M143 H{param.R} S250                                                                                        ; Monitor this new heater and throw an error if it exceeds 250C
    elif {param.Y == "HT Extruder"}
        M143 H{param.R} S295                                                                                        ; Monitor this new heater and throw an error if it exceeds 295C
    M307 H{param.R} R2.429 C140.000:140.000 D5.50 S1.00 V0.0 B0 I0
    M563 P{param.T} D{var.extruderIndex}:{var.fAIndex} H{param.R} L-1 S{"Nozzle "^{param.T}}                        ; Create a new tool using the extruder and assist drive parameters, no filament mapping, and call it "Nozzle #"
    M567 P{param.T} E1:1                                                                                            ; Drive this new tool with a 1:1 ratio between the extruder and filament assist
    M118 S{"Info: Setting initial tool offsets"} L2
    G10 P{param.T} X0 Y1.5 Z-5                                                                                      ; Set initial tool offsets to default values for an extruder

; Spindle
if param.Y == "Spindle"
    M118 S{"Info: Creating Spindle "^param.T^" using Spindle "^param.S^"and air assist on Fan "^param.N} L2
    M950 F{param.N} C{param.F}                                                                                      ; Define a new "fan" for spindle air assist using the inbound parameters
    M106 P{param.N} S0 B0 L1.0 C{"T"^{param.T}^" Air"}                                                              ; Configure the "fan" for spindle air assist.
    if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
        M950 R{param.S} C{param.H}^"+nil+"^{param.E} L10000 Q10000                                                      ; Define a new spindle with inbound parameters and 10000 RPM achieved at full PWM using a 10kHz PWM frequency
    elif {global.machineModel} == "H5B"
        M950 R{param.S} C{param.H}^"+nil+"^{param.E} L20000 Q10000                                                      ; Define a new spindle with inbound parameters and 10000 RPM achieved at full PWM using a 10kHz PWM frequency
    M563 P{param.T} F{param.N} R{param.S} S{"Spindle "^{param.T}}                                                   ; Create a new tool with the newly created fan and spindle and call it "Spindle #"
    G10 P{param.T} X6 Y7.5 Z-2                                                                                      ; Set initial tool offsets to default values for a spindle
    M453                                                                                                            ; CNC Mode
    M3 P{param.S} S0 ; Ensure new spindle is off

; Tool Changer
if param.Y == "TC Tool"
    M118 S{"Info: Creating Tool Changer Tool "^param.T^" using Spindle "^ param.S} L2
    var spindleFanNum = {global.spindle2AirIndex}
    M563 P{param.T} F{var.spindleFanNum} R{tools[{param.S}].spindle} S{"TC "^{param.T}}                                                   ; Create a new tool with the newly created fan and spindle and call it "Spindle #"

; Set other initial tool offsets
G10 P{param.T} U{var.newUOffset} W0.00 A0.00 C0.00
if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    G10 P{param.T} V0.00
elif {global.machineModel} == "H5B"
    G10 P{param.T} B{var.newBOffset}

; Create tfree.g, tpre.g, and tpost.g for this tool
M98 P"createtoolfiles.g" T{param.T}
M118 S{"Info: End create-tool.g"} L2
