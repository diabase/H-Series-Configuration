; Disable E motor and select first E motor for multiplexing
; MOT 1 - LLL
; MOT 2 (5) - LLH
; MOT 3 (4) - HHL
; MOT 4 (3) - LHL
; MOT 5 (2) - HLL
M84 E0
M42 P100 S0
M42 P101 S1
M42 P102 S0

; Switch to FFF mode
M451

; disable air pressure valve
m106 P7 s0

; Move Z up and unlock the turret
G91
G1 Z40 F6000
G90
M98 P"unlock_turret.g"

; Move turret
G1 U174.3 F9900
G4 P20

; Lock the turret again
M98 P"lock_turret.g"
