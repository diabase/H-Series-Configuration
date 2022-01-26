; homeu.g
; Called to home only the U axis
; Written by Diabase Engineering
; Last Updated: January 26, 2022
; TODO: Save current WCS, switch to G54 for homing, return to saved WCS

M118 S{"Debug: Begin homeu.g"} L3

if {global.machineModel} == "H5B"
        if sensors.gpIn[{global.airPressureInNum}].value == 0
            M291 P"Warning: Incoming air pressure low. Resolve before continuing." R"Warning" S3            ; Display a blocking warning with no timeout.
            abort

M453 ; Switch to CNC Mode

; Ensure appropriate axis endstops are used
M574 Z2 S1 P{global.zSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in machinespecific.h

G60 S0 ; Save current position to Slot 0
if {global.machineModel} == "H4"
    M84 E0:1:2:3 ; Idle all extruder motors
T-1 ; Deselect current tool (if any)

G91 ; Relative Positioning
G1 H1 Z.5 F6000                 ; Move Z +0.5mm at 6000 mm/min
M98 P"disengagezbrake.g" H1      ; Disengage Z brake
G4 P300                         ;wait 300 ms

if move.axes[2].machinePosition + 40 <= move.axes[2].max ; If we have enough room for a normal tool change Z-hop, do it.
    G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
elif move.axes[2].machinePosition + 40 > move.axes[2].max ; If we don't have enough room, move as high as we can.
    M574 Z2 S1 P{global.zSwitchPin} ; Configure Z endstop position at high end, it's a microswitch on pin defined in machinespecific.h
    M400 ; Wait for all moves to finish
    G1 Z40 F1000 H1 ; Attempt to move Z +40mm at 1000 mm/min, but halt if endstop triggered and set current position to axis limit set by previous M208 or G1 H3 special move
    M400 ; Wait for all moves to finish

M98 P"unlock_turret.g" ; Call unlock_turret.g
M915 U R0 ; Configure stall detection for U axis to take no action when a stall is detected
G4 P100 ; Dwell for 100 ms
if {global.machineModel} == "H5B"
    G1 H1 U5 F6000
    G1 H1 U-10 F6000
    G1 H1 U10 F6000
    G1 H1 U-10 F6000
    G1 H1 U10 F6000
    G1 H1 U-5 F6000
    M400
G1 H1 U-380 F6000 ; Attempt to move U -380mm at 6000 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
G1 H2 U2 F6000 ; Move U +2mm at 6000 mm/min, ignoring endstop while moving
G1 H1 U-20 F200 ; Attempt to move U -20mm at 200 mm/min, but halt if endstop triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move

G90 ; Absolute Positioning
G1 U0 F16000 ; Rotate Turret to 0 mm at 16000 mm/min
M98 P"lock_turret.g" ; Call lock_turret.g
G92 U0 ; Set current U position as 0 mm

M574 Z1 S2 ; Set Z endstop position to low end and configure as Z probe

G1 R0 Z0 ; Return to Z-axis position stored in Slot 0

; Put all the tools into standby mode and leave the Z probe tool active
while iterations < #tools
    if tools[iterations] != null
        T{iterations} P0
T{global.zProbeToolNum} P0                ; Select Probe P0
M401 P0                                   ; Deploy Probe

M118 S{"Debug: End homeu.g"} L3
