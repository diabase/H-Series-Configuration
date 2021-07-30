; unlock_turret.g
; Called to release the turret latch
; Written by Diabase Engineering
; Last Updated: July 30, 2021

M118 S{"Info: Begin unlock_turret.g"} L2

G91 ; Set to Relative Positioning

var AxisIndex = -1

while iterations < #move.axes
    if move.axes[iterations].letter == "V"
        set var.AxisIndex = iterations
        break

while sensors.endstops[var.AxisIndex].triggered == false
    G1 U-0.2 V3 H1 ; Move U -0.2mm and V 3mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
    G1 U0.4 V3 H1 ; Move U 0.4mm and V 3mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
    G1 U-0.2 V3 H1 ; Move U -0.2mm and V 3mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
    G92 V0 ; Assign current V position to 0
    ;if iterations == 10
    if sensors.endstops[var.AxisIndex].triggered == true
        M118 S{"Info: Turret unlatched after " ^ {iterations +1} ^ " attempt(s)"} L2
        break
    if {{mod(iterations,10)} == 0}
        ; abort "After ten attempts, the turret latch has not released. Please resolve and restart the job."
        M291 P"Unlatch attempted " ^ {iterations +1} ^ " times. Try another 10?" R"Keep unlatching?" S3
    ;G1 U-0.5 V50 H1 ; Move U -0.5mm and V 50 mm. Terminate the move if endstop switch is triggered and set axis position to axis limit.
    ;G92 V0 ; Assign current V position to 0

M400 ; Wait for current moves to finish
;M915 U S10 H20 R2 ; Configure U-axis stall detection. Threshold 10, Minimum motor steps 20, and Pause Print if detected

M118 S{"Info: End unlock_turret.g"} L2
