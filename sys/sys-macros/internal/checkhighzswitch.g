; checkhighzswitch.g
; Used to verify appropriate location of the high z switch
; Written by Diabase Engineering
; Last Updated: March 22, 2022

M118 S{"Begin checkhighzswitch.g"} L3

M291 P"This macro will verify the position of the high z switch. Did you just successfully run findtcput.g?" R"findtcput.g Successful?" S3
M291 P"If the tool changer jaws close, will the tool holder be appropriately captured?" R"At TC Put Position?" S3
M291 P"The jaws will now close and we'll check the high z switch position. Ready?" R"Ready for Movement?" S3


M42 P{global.tCToolReleaseOutNum} S0    ; Close the jaws on the tool changer

if sensors.gpIn[global.zHighInNum].value == 1
    M291 P"High Z Switch is currently triggered at put tool location. Now we'll check the get tool location." R"Looking Good" S3
    G53 G1 Z{move.axes[2].max} H2 F3000                                          ; Move Z beyond ZMax ignoring endstops
    G53 G1 Z{{move.axes[2].max}+{global.tCOvertravelPutTool}-0.5} H2 F3000                                          ; Move Z beyond ZMax ignoring endstops
    if sensors.gpIn[global.zHighInNum].value == 1
        M291 P"High Z Switch triggered at get tool location and likely low enough. Now we'll check if its too low." R"Looking Good" S3
        G53 G1 Z{move.axes[2].machinePosition - 2} H2 F3000
        if sensors.gpIn[global.zHighInNum].value == 0
            M291 P"High Z Switch is no longer triggered 2mm below get tool. The high z switch is correctly positioned! Ready to home all?" R"Success" S3
            M98 P"homeall.g"
        if sensors.gpIn[global.zHighInNum].value == 1
            M291 P"High Z Switch is still triggered. The location of the switch bracket probably needs to be moved up and findtcput.g should be run again." R"Failed" S3
    elif sensors.gpIn[global.zHighInNum].value == 0
        M291 P"High Z Switch is not triggered at put tool location. The location of the switch bracket probably needs to be moved down and findtcput.g should be run again." R"Failed" S3
        abort

elif sensors.gpIn[global.zHighInNum].value == 0
    M291 P"High Z Switch is not triggered. The location of the switch bracket probably needs to be moved down and findtcput.g should be run again." R"Failed" S3
    abort

M118 S{"End checkhighzswitch.g"} L3
