; lock_turret.g
; H5 Configuration File
; Written by Diabase Engineering
; Last Updated: May 28, 2021

if global.TLockType == 0
    ;M915 U R0 ; Configure motor stall detection - Do nothing if stall detected on U axis?
    G1 V-3 ; Move V to -3.
    ;M18 U ; Disable U-axis stepper motors
    G91 ; Set to Relative Positioning
    G1 U-0.5 V-3 ; Move U -0.5 mm and V -3 mm.
    G1 U0.5 V-3 ; Move U 0.5 mm and V -3 mm.
    G1 U-0.25 V-0.5 ; Move U -0.25 mm and V -0.5 mm.
    G1 U0.25 V-0.5 ; Move U 0.25 mm and V -0.5 mm.
    G4 P20 ; Dwell for 20 ms

if global.TLockType == 1
    M42 P5 S1
    M42 P6 S0
    G4 P100
    var Upos={move.axes[4].machinePosition}
    M18 U
    G92 U{var.Upos}
    G91
    G1 U0.01
    G1 U-0.01	;jitter U to activate motor
    G90

	