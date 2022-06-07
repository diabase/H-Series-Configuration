; checkbswitchtriggerposition.g
; Used to adjust the b-axis endstop location
; Written by Diabase Engineering
; Last Updated: June 06, 2022

M118 S{"Begin checkbswitchtriggerposition.g"} L3

M291 P"This macro will home all then move b to the location of its limit switch. Ready?" R"Crash Check" S3  ; Warn the user about the imminent probing move.

M98 P"0:/sys/homeall.g"

M208 B{global.bMin} S1 
if state.gpOut[global.tCToolReleaseOutNum].pwm == 1
    M42 P{global.tCToolReleaseOutNum} S0    ; Ensure the tool changer release piston is retracted
    G4 P500                                 ; Dwell 500 ms to allow time for the piston to retract

T-1 P0                                  ; Deselect the current tool, but don't run any of the tool changing files
G91                                     ; Relative positioning
G1 B-500 H1 F15000                      ; Attempt to move B axis by -500 mm, but stop when endstop is triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400                                    ; Wait for current moves to finish
G1 B2 F15000                            ; Move off the endstop
M400                                    ; Wait for current moves to finish
G1 B-5 H1 F200                          ; Attempt slow overrun move to find accurate endstop position, stopping when endstop is triggered and set axis position to axis limit as defined by previous M208 or G1 H3 special move
M400                                    ; Wait for current moves to finish
G90                                     ; Absolute positioning

M291 P"Does the B axis need to move farther to access tool 24?" R"Check T24 Position" S3
M291 P"Move the B limit switch to the right and check again." R"Move B Switch" S2

M118 S{"End checkbswitchtriggerposition.g"} L3
