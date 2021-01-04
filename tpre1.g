; Idle all E motors and switch extruder multiplexer to Tool 1
; MOT 1 (Tool 1) - LLL
; MOT 2 (Tool 5) - LLH
; MOT 3 (Tool 4) - HHL
; MOT 4 (Tool 3) - LHL
; MOT 5 (Tool 2) - HLL
M84 E0:1:2:3 ; Idle all extruder motors
M42 P2 S0 ; Set GPIO pin 2 low
M42 P3 S0 ; Set GPIO pin 3 low
M42 P4 S0 ; Set GPIO pin 4 low

; M451 ; Switch to FFF mode (Extruder only)
M453 ; Switch to CNC mode (Spindle only)

G91 ; Set to Relative Positioning
G1 Z40 F6000 H1 ; Move Z up by 40 mm at 6000mm/min. Terminate the move if endstop switch is triggered and set axis position to axis limit.

M98 P"unlock_turret.g" ; Call unlock_turret.g
G90 ; Set to Absolute Positioning

G1 U30    F16000 ; Rotate turret (U) to 30    at 16000 mm/min
G4 P20 ; Dwell for 20 ms

M98 P"lock_turret.g" ; Call lock_turret.g
G90 ; Set to Absolute Positioning

G1 R2 X0 Y0 F6000 ; Return to X and Y coordinates stored in restore point 2 at a speed of 6000 mm/min
G1 R2 Z0 ; Return to Z coordinate stored in restore point 2

M140 S0 ; Ensure bed heater is off to protect power supply. (Spindle only)
