; loadedtoolrecovery.g
; Check and handle the case of a tool unexpectedly in the spindle 
; Written by Diabase Engineering
; Last Updated: April 07, 2022
; TODO: Dynamically identify spindle. Currently we assume spindle[0]. - RT 12/21/2021

M118 S{"Begin loadedtoolrecovery.g"} L3

if {global.machineModel} == "H5B"
    M291 P"Is there a tool in the spindle?" R"Spindle Check" S3                                                    ; Get user input

    M291 P"Place the cup directly under the arm." R"Place Cup" S3
    ; What if the arm is too low to accomplish this? - RT 12/21/2021

    M291 P"The machine will now attempt to index the spindle and release the tool. Select OK to proceed." R"Ready?" S3
    M98 P"indexspindle.g" H1 S0
    if global.indexSpindleComplete == 0
        M118 S{"loadedtoolrecovery.g: indexspindle didn't exit successfully. Aborting."} L1
        abort
    if state.gpOut[global.dbarOutNum].pwm == 1
        M42 P{global.spindleIndexOutNum} S1                                                                                 ; Toggle Drawbar Release Pressure High
    else
        abort "Error: Drawbar clamping pressure not released. Contact Diabase Support."

    M291 P"Is the tool clear?" R"Tool clear?" S3

    T-1 P0

    if {sensors.endstops[2].triggered}
        M291 P"The machine will now attempt to move the arm down off the z-axis end stop. Select OK to proceed." R"Ready?" S3
        G91 ; Relative Positioning
        G1 H1 Z0.5 F6000 ; Move Z +0.5mm at 6000 mm/min
        M98 P"disengagezbrake.g" H1      ; Disengage Z brake
        G4 P300         ; Wait 300 ms
        while iterations < 5
            G1 H1 Z-10 F6000 ; Move Z +0.5mm at 6000 mm/min
            if !{sensors.endstops[2].triggered}
                break
            if iterations == 4
                M291 P"We have attempted to move off the z-axis endstop several times and have been unsuccessful. Do you want to proceed anyway?" R"Ready?" S3

    M291 P"Are you ready to home all?" R"Home All?" S3
    M98 P"homeall.g"
    M291 P"Replace the tool in the tool changer and select OK to proceed." R"Tool replaced?" S3

M118 S{"End loadedtoolrecovery.g"} L3
