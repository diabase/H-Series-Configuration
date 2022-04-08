; testindexing.g
; Used to test spindle indexing
; Parameters:
;    H: Has Tool (H0 - No tool, H1 - Tool Loaded)
;    S: Spindle Number
; Written by Diabase Engineering
; Last Updated: April 07, 2022

M118 S{"Begin testindexing.g"} L3

if {!exists(param.H)}
    abort "Please provide an H parameter to indicate whether a tool is loaded."
if {!exists(param.S)}
    abort "Please provide an S parameter to indicate which spindle to use."

M118 S{"testindexing.g H"^param.H^" S"^param.S} L3

if param.H == 0
    M291 P"This will test spindle indexing without a tool. Is the spindle empty?" R"No Tool Loaded?" S3

elif param.H == 1
    M291 P"This will test spindle indexing with a tool. Is a tool loaded in the spindle?" R"Tool Loaded?" S3

while true
    M98 P"0:/sys/indexspindle.g" H{param.H} S{param.S}
    if global.indexSpindleComplete == 0
        M118 S{"testindexing.g: indexspindle didn't exit successfully. Aborting."} L1
        abort
    G4 P100
    M98 P"0:/sys/sys-macros/manualdbarclamp.g"
    G4 P200
    M4 S5000
    G4 P200
    M5
    if {{mod(iterations,20)} == 0}
        M291 P{"That was "^iterations^" iterations. Continue?"} R"Continue" S3

M118 S{"End testindexing.g"} L3
