; loadedtoolrecovery.g
; Check and handle the case of a tool unexpectedly in the spindle 
; Written by Diabase Engineering
; Last Updated: December 21, 2021
; TODO: Dynamically identify spindle. Currently we assume spindle[0]. - RT 12/21/2021

M118 S{"Debug: Begin loadedtoolrecovery.g"} L3

if {global.machineModel} == "H5B"
    M291 P"Is there a tool in the spindle?" R"Spindle Tool Check" S3                                                    ; Get user input

    M291 P"Place the cup directly under the arm." R"Place Cup" S3
    ; What if the arm is too low to accomplish this? - RT 12/21/2021

    M98 P"unlock_turret.g"
    M291 U1 P"Jog the U axis to point the spindle at the cup." R"Jog U" S3
    ; What if the arm is too low to accomplish this? - RT 12/21/2021

    M291 P"The machine will now attempt to index the spindle and release the tool. Select OK to proceed." R"Ready?" S3
    M98 P"indexspindle.g" H1 S0
    M42 P{global.spindleIndexOutNum} S0                                                                                 ; Toggle Drawbar Release Pressure High

    M291 P"Is the tool clear?" R"Tool clear?" S3

    M291 P"Are you ready to home the U axis?" R"Home U?" S3
    M98 P"homeu.g"

M118 S{"Debug: End loadedtoolrecovery.g"} L3
