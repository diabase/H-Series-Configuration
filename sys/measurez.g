; measurez.g
; Called to probe the bed and set Z0 to the bed surface and then set Z-axis maximum to the carefully measured location of the upper Z-axis endstop relative to the bed surface.
; Written by Diabase Engineering
; Last Updated: April 18, 2022

M118 S{"Begin measurez.g"} L3

var zAxisIndex = -1
while iterations < #move.axes
    if move.axes[iterations].letter == "Z"
        set var.zAxisIndex = iterations
        break

M118 S{"measurez.g: Z-axis limits are currently "^move.axes[var.zAxisIndex].min^":"^move.axes[var.zAxisIndex].max} L3

if {global.machineModel} == "H5B"
        if sensors.gpIn[{global.airPressureInNum}].value == 0
            M291 P"Warning: Incoming air pressure low. Resolve before continuing." R"Warning" S3            ; Display a blocking warning with no timeout.
            abort

M291 P"Arm will now move. Is the probe above the surface you want to measure?" R"Crash Check" S3  ; Warn the user about the imminent probing move.

T{global.zProbeToolNum}                                                                 ; Select Probe
M208 Z-10:400                                                                           ; Set z axis minimum and maximum travel
G92 Z400

; Go to first bed probe point and coarse probe Z
M558 F1200                                                                              ; Set Z probe feed rate to 1200 mm/min.
G30                                                                                     ; Probe the bed at the current XY position and set the Z coordinate to the probe trigger height.

; Fine probe Z
M558 F150                                                                               ; Set Z probe feed rate to 150 mm/min
G30                                                                                     ; Probe the bed at the current XY position and set the Z coordinate to the probe trigger height.

M574 Z2 S1 P{global.zSwitchPin}                                                         ; Configure Z endstop position at high end, it's a microswitch on pin defined in defaultparameters.g
M208 Z380 S0                                                                            ; Set Z-axis maximum to 380 mm
G91                                                                                     ; Relative Positioning
G1 Z330 F6000 H3                                                                        ; Attempt to move Z +340mm at 6000 mm/min, but halt when endstop triggered and set axis limit current position, overriding value set by M208 in config.g
G1 Z40 F200 H3
G1 H2 Z-2 F6000                                                                         ; Move Z -2mm at 6000 mm/min, ignoring endstop while moving
G1 H3 Z4 F200                                                                           ; Attempt to move Z +4mm at 200 mm/min, but halt if endstop triggered and set axis limit to current position, overriding value set by previous M208 or G1 H3 special move
M400                                                                                    ; Wait for all moves to finish

M500                                                                                    ; Save current parameters to config-override.g

M118 S{"measurez.g: Z-axis limits are now "^move.axes[var.zAxisIndex].min^":"^move.axes[var.zAxisIndex].max} L3

G90                                                                                     ; Absolute Positioning
if move.axes[2].machinePosition > move.axes[2].max                                      ; If we're now above the new Z-axis limit...
    G1 H2 Z{move.axes[2].max} F200                                                      ; ...move to it at 200 mm/min while ignoring endstops and limits.

G1 Z{move.axes[2].max + global.maxOffset} F10000                                        ; Move to Z = ZMax + Longest Z Offset at 10000 mm/min

M574 Z1 S2                                                                              ; Set Z endstop position to low end and configure as Z probe

M118 S{"End measurez.g"} L3
