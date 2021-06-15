; stop.g
; If the axes are homed and if a print is being cancelled (M25), cancel.g is called when M0 is sent. 
; If M0 is sent at any other time, stop.g is called.

G60 S0  ;   save current tool information

G91 ; Relative Positioning
M574 Z2 S1 P"io4.in" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
if move.axes[2].machinePosition + 40 <= move.axes[2].max ; If we have enough room for a normal tool change Z-hop, do it.
    G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
elif move.axes[2].machinePosition + 40 > move.axes[2].max ; If we don't have enough room, move as high as we can.
    M574 Z2 S1 P"io4.in" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
    M400 ; Wait for all moves to finish
    M913 Z50; Reduce Z-axis motor current to 50%
    G1 Z40 F1000 H3 ; Attempt to move Z +40mm at 1000 mm/min, but halt if endstop triggered and set axis limit current position, overriding value set by previous M208 or G1 H3 special move
    M400 ; Wait for all moves to finish
    M913 Z100 ; Restore Z-axis motor current to 100%

G90 ; Set to Absolute Positioning
G1 Y85 F6000 ; Move Y to 85 mm at 6000 mm/min

if state.machineMode="CNC"
    M5 ; Turn off all spindles

M400 ; Wait for current moves to finish

; Turn off all extruder heaters
G10 P1 R0 S0 ; Set Tool 1 active and standby temperatures to 0C
G10 P2 R0 S0 ; Set Tool 2 active and standby temperatures to 0C
G10 P3 R0 S0 ; Set Tool 3 active and standby temperatures to 0C
G10 P4 R0 S0 ; Set Tool 4 active and standby temperatures to 0C
G10 P5 R0 S0 ; Set Tool 5 active and standby temperatures to 0C

; Put all the tools into standby mode and leave no tool selected
T1 P0
T2 P0
T3 P0
T4 P0
T5 P0
T10 P0
T{state.restorePoints[0].toolNumber} P0

if heat.heaters[0] != null ; If we have defined a bed heater...
    if heat.heaters[0].state != "fault" ; ...and it's not in a fault state...
        M140 H0 S-273.15 ; ...turn it off.
