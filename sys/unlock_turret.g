; unlock_turret.g
; Called to release the turret latch
; Written by Diabase Engineering
; Last Updated: February 01, 2022

M118 S{"Debug: Begin unlock_turret.g"} L3

M400                                                                ; Wait for any current moves to finish
if {global.machineModel} == "H4" || {global.machineModel} == "H5A"
    ; Find axisIndex for V axis
    var axisIndex = -1
    while iterations < #move.axes
        if move.axes[iterations].letter == "V"
            set var.axisIndex = iterations
            break

    M400 ; Wait for current moves to finish
    while sensors.endstops[var.axisIndex].triggered == false
        G91                                                         ; Set to Relative Positioning
        G1 U-0.2 V3 H1                                              ; Move U -0.2mm and V 3mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
        G1 U0.4 V3 H1                                               ; Move U 0.4mm and V 3mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
        G1 U-0.2 V3 H1                                              ; Move U -0.2mm and V 3mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
        G92 V0                                                      ; Assign current V position to 0
        if sensors.endstops[var.axisIndex].triggered == true
            M118 S{"Debug: Turret unlatched after " ^ {iterations +1} ^ " attempt(s)"} L3
            break
        if iterations > 0
            if {{mod(iterations,10)} == 0}
                ; abort "After ten attempts, the turret latch has not released. Please resolve and restart the job."
                M291 P"Unlatch attempted " ^ {iterations +1} ^ " times. Try another 10?" R"Keep unlatching?" S3
        ;G1 U-0.5 V50 H1 ; Move U -0.5mm and V 50 mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
        ;G92 V0 ; Assign current V position to 0
    M400 ; Wait for current moves to finish
    ;M915 U S10 H20 R2 ; Configure U-axis stall detection. Threshold 10, Minimum motor steps 20, and Pause Print if detected

elif {global.machineModel} == "H5B"
    M400                            ; Wait for current moves to finish
    M17 U                           ; Enable the u-axis motor
    G4 P50                          ; Dwell for 50 ms
    M42 P{global.tUnlockOutNum} S1  ; Activate the turret unlock solenoid valve
    G4 P200                         ; Dwell for 200 ms

M118 S{"Debug: End unlock_turret.g"} L3