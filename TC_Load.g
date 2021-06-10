; TC_load.g
; Written by Diabase Engineering
; Last Updated: May, 2021

if global.TCload>0
    M291 P"Tool loading will begin" R"Tool Load Confirmation" S3 ;blocking confirmation window
    T{global.TCload} P0       ;activate desired tool, do not move turret
    M98 P"unlock_turret.g"    ;unlock turret before movement
    G90
    M400
    G1 U90							      ;move to user-facing position
    M106 P4 S1						    ;release tool collet
    M400
    M291 P"Click OK when tool has been loaded" R"Tool Load Confirmation" S3 ;blocking confirmation window
    set global.TCin=1         ;set tool loaded variable to 1
    M106 P4 S0						    ;close tool collet
    M400
    G1 B0 F8000						    ;move to original position
    M400							        ;wait for movement to complete
    M208 S0 Z{move.axes[2].max+(global.TCZ+10)} ;; add extra movement above limit switch, defined as 12mm above toolsetter stud location
    G10 P{state.currentTool} Z0   ; set Z offset to 0 for toolchange operation
    G1 U170                   ;rotate to near gripper position
    G1 D40							      ;open tool cradle clamp
    G1 Z{move.axes[2].max} 		;move to Zmax
    M400
    G1 U{global.TCUpos}							      ;move to vertical position (no tool selected)
    M400
    M98 P"homed.g"				    ;close tool cradle clamp
    M400
    M106 P4 S1						    ;release tool collet
    G4 P500
    G91
    G1 Z-60                   ;move down to safe position
    G90
    M400
    M106 P4 S0                ;close tool collet
    M501                      ;recover machine Zmax and Z Tool offset
    M400
    set global.TCin=0         ;set tool loaded variable to 0
    set global.TCactive=1     ;toolchange is active
    set global.TCload=-1      ;set TCload variable to non-defined
    G1 U90                    ;return to user-facing position
    T-1 P0
    M291 P"Tool loading complete. Continue by loading more tools, selecting tool for use, or homing machine" R"Tool Load Confirmation" ;non-blocking confirmation window

else								;no tool selected from UI
    M291 P"No valid tool selected" R"TC Error 1" T-1  