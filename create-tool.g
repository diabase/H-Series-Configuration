; create-tool.g
; Creates a new tool with the inbound parameters
; Parameters:
;   T: Variable name containing Tool Type
;   S: Variable name containing Temp Sense Pin / Spindle Speed Sense Pin
;   H: Variable name containing Heater Pin / Spindle Speed Pin
;   E: Variable name containing Extruder Drive Number / Spindle Direction Pin
;   F: Variable name containing Filament Assist Drive Number / Spindle Air Pin
; Written by Diabase Engineering
; Last Updated: July 7, 2021

M118 S"Begin create-tool.g" L2

var NewToolNum = {#tools==0?1:#tools}
var NewSensorNum = #sensors.analog
var NewHeatNum = #heat.heaters
var NewFanNum = #fans
var NewSpindleNum = #spindles
var ExtruderIndex = 0
var FAIndex = 0
var NewUOffset = {{{var.NewToolNum - 1} * -72} - 30}

if param.T == "Extruder"
    while iterations < #move.extruders
        if {({param.E} ^ "") == (move.extruders[iterations].driver ^ "")}
            set var.ExtruderIndex = iterations
            break

if param.T == "Extruder"
    while iterations < #move.extruders
        if {({param.F} ^ "")== (move.extruders[iterations].driver ^ "")}
            set var.FAIndex = iterations
            break


; Extruder
if param.T == "Extruder"
    M308 S{var.NewSensorNum} P{param.S} Y"thermistor" T100000 B3950 C0 A{"Nozzle "^{var.NewToolNum}} ; Create a new sensor assigned to the temp sense pin parameter, thermistor type with resistance of 100Kohms at 25C, reciprocal of Steinhart-Hart B coefficient 3950, Steinhart-Hart C coefficient 0, and call it "Nozzle #"
    M950 H{var.NewHeatNum} C{param.H} T{var.NewSensorNum} ; Create a new heater using the heater pin parameter and the newly created sensor
    M143 H{var.NewHeatNum} S250 ; Monitor this new heater and throw an error if it exceeds 250C
    M307 H{var.NewHeatNum} R2.429 C140.000:140.000 D5.50 S1.00 V0.0 B0 I0
    M563 P{var.NewToolNum} D{var.ExtruderIndex}:{var.FAIndex} H{var.NewHeatNum} L-1 S{"Nozzle "^{var.NewToolNum}} ; Create a new tool using the extruder and assist drive parameters, no filament mapping, and call it "Nozzle #"
    M567 P{var.NewToolNum} E1:1 ; Drive this new tool with a 1:1 ratio between the extruder and filament assist
    G10 P{var.NewToolNum} X0 Y1.5 Z-5 U{var.NewUOffset} V0.00 W0.00 A0.00 C0.00 ; Set initial tool offsets to default values for an extruder

; Spindle
if param.T == "Spindle"
    M950 F{var.NewFanNum} C{param.F} ; Define a new "fan" for spindle air assist using the inbound parameters
    M106 P{var.NewFanNum} S0 B0 L1.0 C"T"^{var.NewToolNum}^" Air" ; Configure the "fan" for spindle air assist.
    M950 R{param.S} C{param.H}^"+nil+"^{param.E} L12000 ; Define a new spindle with inbound parameters and 12000 RPM achieved at full PWM
    M563 P{var.NewToolNum} F{var.NewFanNum} R{param.S} S{"Spindle "^{var.NewToolNum}} ; Create a new tool with the newly created fan and spindle and call it "Spindle #"
    G10 P{var.NewToolNum} X6 Y7.5 Z-2 U{var.NewUOffset} V0.00 W0.00 A0.00 C0.00
    M453
    M3 P{param.S} S0 ; Ensure new spindle is off

M118 S"End create-tool.g" L2
