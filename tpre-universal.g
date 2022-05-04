; tpre-universal.g
; Universal tpre macro
; Written by Diabase Engineering
; Last Updated: April 5, 2021

M453 ; Switch to CNC mode
M84 E0:1:2:3 ; Idle all extruder motors

; Configure extruder multiplexer for upcoming tool
; GPIO[2-4]   Tool #
; ------------------
; 000         Tool 1
; 001         Tool 5
; 010         Tool 3
; 011         Unused
; 100         Tool 2
; 101         Unused
; 110         Tool 4
; 111         Tool 10

if state.nextTool == 1
    M42 P2 S0 ; Set GPIO pin 2 low
    M42 P3 S0 ; Set GPIO pin 3 low
    M42 P4 S0 ; Set GPIO pin 4 low

elif state.nextTool == 2
    M42 P2 S1 ; Set GPIO pin 2 high
    M42 P3 S0 ; Set GPIO pin 3 low
    M42 P4 S0 ; Set GPIO pin 4 low

elif state.nextTool == 3
    M42 P2 S0 ; Set GPIO pin 2 low
    M42 P3 S1 ; Set GPIO pin 3 high
    M42 P4 S0 ; Set GPIO pin 4 low

elif state.nextTool == 4
    M42 P2 S1 ; Set GPIO pin 2 high
    M42 P3 S1 ; Set GPIO pin 3 high
    M42 P4 S0 ; Set GPIO pin 4 low

elif state.nextTool == 5
    M42 P2 S0 ; Set GPIO pin 2 low
    M42 P3 S0 ; Set GPIO pin 3 low
    M42 P4 S1 ; Set GPIO pin 4 high

elif state.nextTool == 10
    M42 P2 S1 ; Set GPIO pin 2 high
    M42 P3 S1 ; Set GPIO pin 3 high
    M42 P4 S1 ; Set GPIO pin 4 high

else
    abort "Tool "^state.nextTool^" has not been configured. Tool change aborted."

; Only perform machine moves if we need to change the turret position
if move.axes[3].machinePosition != -tools[{state.nextTool}].offsets[3]
    G91 ; Relative Positioning

    if move.axes[2].machinePosition + 40 <= move.axes[2].max ; If we have enough room for a normal tool change Z-hop, do it.
        G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
    elif move.axes[2].machinePosition + 40 > move.axes[2].max ; If we don't have enough room...
        G90 ; Absolute Positioning
        G1 Z{move.axes[2].max} ; Move as high as we can.

    M98 P"unlock_turret.g" ; Call unlock_turret.g
    G90 ; Absolute Positioning

    G1 U{-tools[{state.nextTool}].offsets[3]} F16000 ; Rotate turret to new tool
    G4 P20 ; Dwell for 20 ms

    M98 P"lock_turret.g" ; Call lock_turret.g
