; Disable E motor and select first E motor for multiplexing
; MOT 1 - LLL
; MOT 2 - HLL
; MOT 3 - LHL
; MOT 4 - HHL
; MOT 5 - LLH
M84 E0
M42 P100 S1
M42 P101 S1
M42 P102 S0

; Switch to FFF mode
M451

; Move Z up and unlock the turret
G91
G1 Z15 F6000
G90
M98 P"unlock_turret.g"

; Move turret
G1 U246 F9900
G4 P20

; Lock the turret again
M98 P"lock_turret.g"