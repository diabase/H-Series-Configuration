; Idle all E motors and switch extruder multiplexer to Tool 5
; MOT 1 (Tool 1) - LLL
; MOT 2 (Tool 5) - LLH
; MOT 3 (Tool 4) - HHL
; MOT 4 (Tool 3) - LHL
; MOT 5 (Tool 2) - HLL
M84 E0:1:2:3 ; Idle all extruder motors
M42 P2 S0 ; Set GPIO pin 2 low
M42 P3 S0 ; Set GPIO pin 3 low
M42 P4 S1 ; Set GPIO pin 4 high

M453 ; Switch to CNC mode

G91 ; Relative Positioning

if move.axes[2].machinePosition + 40 <= move.axes[2].max
    G1 Z40 F6000 ; Move Z +40mm at 6000 mm/min
elif move.axes[2].machinePosition + 40 > move.axes[2].max
    M574 Z2 S1 P"zstop" ; Configure Z endstop position at high end, it's a microswitch on pin "zstop"
    G1 Z40 F6000 H3 ; Attempt to move Z +40mm at 6000 mm/min, but halt when endstop triggered and set axis limit current position, overriding value set by M208 in config.g

M98 P"unlock_turret.g" ; Call unlock_turret.g
G90 ; Absolute Positioning

G1 U318.3 F16000 ; Rotate turret (U) to 318.3 at 16000 mm/min
G4 P20 ; Dwell for 20 ms

M98 P"lock_turret.g" ; Call lock_turret.g
