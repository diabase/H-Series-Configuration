; unlock_turret.g
; H5 Configuration File
; Written by Diabase Engineering
; Last Updated: May 28, 2021

if TLockType == 0
    G91 ; Set to Relative Positioning
    G1 U-0.2 V3 H1 ; Move U -0.2mm and V 3mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
    G1 U0.4 V3 H1 ; Move U 0.4mm and V 3mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
    G1 U-0.2 V3 H1 ; Move U -0.2mm and V 3mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
    G92 V0 ; Assign current V position to 0
    ;G1 U-0.5 V50 H1 ; Move U -0.5mm and V 50 mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
    ;G92 V0 ; Assign current V position to 0
    
    M400 ; Wait for current moves to finish
    ;M915 U S10 H20 R2 ; Configure U-axis stall detection. Threshold 10, Minimum motor steps 20, and Pause Print if detected

if TLockType == 1
    M42 P5 S1
    M42 P6 S0

