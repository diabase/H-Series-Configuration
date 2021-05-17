; TC_load.g
; Written by Diabase Engineering
; Last Updated: May 15, 2021

if global.TCload>-1
  M291 P"Tool loading will begin" R"Tool Load Confirmation" S3 ;blocking confirmation window
  T{global.TCload} P0       ;activate desired tool, do not move turret
  G90
  M98 P"unlock_turret.g"    ;unlock turret before movement
  M400
  G1 U90							      ;move to user-facing position
  M106 P4 S1						    ;release tool collet
  M400
  M291 P"Click OK when tool has been loaded" R"Tool Load Confirmation" S2 ;blocking confirmation window
  M106 P4 S0						    ;close tool collet
  M98 P"TCReturn.g"         ;run return tool macro
  G1 U90                    ;return to user-facing position
  T-1
  M291 P"Tool loading complete. Continue by loading more tools, selecting tool for use, or homing machine" R"Tool Load Confirmation" ;non-blocking confirmation window
  
  
else								;no tool selected from UI
	M291 P"No valid tool selected" R"TC Error 1" T-1
  