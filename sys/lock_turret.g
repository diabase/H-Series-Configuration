; lock_turret.g
; Called to engage the turret latch
; Written by Diabase Engineering
; Last Updated: April 16, 2022

M118 S{"Debug: Begin lock_turret.g"} L3

M400                                                                ; Wait for any current moves to finish
if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    G92 V0                                                          ; Assign current V position to 0
    G91                                                             ; Set to Relative Positioning
    G1 V-3.0                                                        ; Move V -3.0 mm
    G1 U-0.5 V-2.0                                                  ; Move U -0.5 mm  (to -0.50 mm absolute) and V -2.0 mm
    G1 U1.0 V-2.0                                                   ; Move U 1.0 mm   (to  0.50 mm absolute) and V -2.0 mm
    G1 U-0.75 V-0.5                                                 ; Move U -0.75 mm (to -0.25 mm absolute) and V -0.5 mm
    G1 U0.5 V-0.5                                                   ; Move U 0.5 mm   (to  0.25 mm absolute) and V -0.5 mm
    G1 U-0.4 V-0.5                                                  ; Move U -0.4 mm  (to -0.15 mm absolute) and V -0.5 mm
    G1 U0.3 V-0.5                                                   ; Move U 0.30 mm  (to  0.15 mm absolute) and V -0.5 mm
    G1 U-0.15 V-0.5                                                 ; Move U -0.15 mm (to  0.00 mm absolute) and V -0.5 mm
    G4 P20                                                          ; Dwell for 20 ms

elif {global.machineModel} == "H5B"
    M42 P{global.tUnlockOutNum} S0                                ; Deactivate the turret unlock solenoid valve
    G4 P500                                                         ; Dwell 500ms
    G91                                                             ; Relative positioning
    M913 U50                                                        ; Reduce u-axis motor current to 50% of normal
    G1 U-0.5                                                        ; Attempt to rotate u-axis counterclockwise by 0.5mm
    G1 U1.0                                                         ; Attempt to rotate u-axis clockwise by 1.0mm
    G1 U-0.5                                                        ; Attempt to rotate u-axis counterclockwise by 0.5mm
    M400                                                            ; Wait for current moves to finish
    M913 U100                                                       ; Return u-axis motor current to 100%
    G90                                                             ; Absolute positioning

M118 S{"Debug: End lock_turret.g"} L3
