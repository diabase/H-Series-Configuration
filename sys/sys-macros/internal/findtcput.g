; findtcput.g
; Used to find an appropriate value for global.tCOvertravelPutTool
; Written by Diabase Engineering
; Last Updated: April 07, 2022

M118 S{"Begin findtcput.g"} L3

M291 P"This macro will measure Z and help you find the value for global.tCOvertravelPutTool. Ready?" R"Crash Check" S3  ; Warn the user about the imminent probing move.

M98 P"0:/sys/measurez.g"
T2

G54
if move.compensation.type == "mesh"
    G29 S0
M98 P"0:/sys/sys-macros/rotatetotc.g"
M98 P"0:/sys/indexspindle.g" H0 S0                                                                      ; Call indexspindle.g
if global.indexSpindleComplete == 0
    M118 S{"findtcput.g: indexspindle didn't exit successfully. Aborting."} L1
    abort

; Fully release drawbar 
if state.gpOut[global.dbarOutNum].pwm == 1
    M42 P{global.spindleIndexOutNum} S1                                                                                 ; Toggle Drawbar Release Pressure High
else
    abort "Error: Drawbar clamping pressure not released. Contact Diabase Support."

G1 B{-tools[17].offsets[6]} F30000                                                                              ; Move tool changer to the position for tool 17
M42 P{global.tCToolReleaseOutNum} S1                                                                            ; Open the jaws on the tool changer
M291 P"Place a tool holder in the spindle. Continue when ready." R"Insert Tool Holder" S3

; Fully clamp drawbar
M42 P{global.dbarOutNum} S0                                                                                     ; Toggle Drawbar Clamping Pressure to High Pressure
G4 P1000                                                                                                         ; Dwell for 1000 ms to allow the release-side of the drawbar cylinder time to vent
M42 P{global.spindleIndexOutNum} S0                                                                             ; Toggle Drawbar Release Pressure to Throttled Vent
G4 P500                                                                                                         ; Dwell for 1000 ms to allow the release-side of the drawbar cylinder time to vent

M98 P"0:/sys/indexspindle.g" H1 S0                                                                          ; Call indexspindle.g
if global.indexSpindleComplete == 0
    M118 S{"findtcput.g: indexspindle didn't exit successfully. Aborting."} L1
    abort

; Fully release drawbar 
if state.gpOut[global.dbarOutNum].pwm == 1
    M42 P{global.spindleIndexOutNum} S1                                                                                 ; Toggle Drawbar Release Pressure High
else
    abort "Error: Drawbar clamping pressure not released. Contact Diabase Support."

G53 G1 Z{move.axes[2].max} H2 F3000                                                                                 ; Move to z-axis homing position
M291 P"Is there at least 32mm of clearance bewteen the spindle and TC jaws?" R"Check Spindle Clearance" S3
G53 G1 Z{{move.axes[2].max}+32} H2 F3000                                                                            ; Move to starting position to find global.tCOvertravelPutTool

while true
    set global.tCOvertravelPutTool = move.axes[2].machinePosition - move.axes[2].max
    M291 P{"This is "^ global.tCOvertravelPutTool ^". Move up another 0.5mm?"} R"Check Spindle Clearance" S3
    G53 G1 Z{move.axes[2].machinePosition + 0.5} H2 F3000
    M400

M118 S{"End findtcput.g"} L3
