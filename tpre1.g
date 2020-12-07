; Disable E motor and select first E motor for multiplexing
; MOT 1 - LLL
; MOT 2 (5) - LLH
; MOT 3 (4) - HHL
; MOT 4 (3) - LHL
; MOT 5 (2) - HLL
M84 E0
M42 P2 S0
M42 P3 S0
M42 P4 S0

; Switch to FFF mode
M453

; Move Z up and unlock the turret
G91
G1 Z25 F6000 H1
G90
M98 P"unlock_turret.g"

; Move turret
G1 U30 F16000
G4 P20

; Lock the turret again
M98 P"lock_turret.g"

;G92 U30
