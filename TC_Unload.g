; TC_unload.g
; Written by Diabase Engineering
; Last Updated: May 15, 2021

if global.TCload>-1
  M291 P"Tool unloading will begin" R"Tool Unload Confirmation" S3 ;blocking confirmation window
  T{global.TCload} P0       ;activate desired tool, do not move turret
  M98 P"TC_get.g"           ;get selected tool
  G1 U90                    ;move to user-facing position
  M400
  M106 P4 S1						    ;release tool collet
  M291 P"Click OK when tool has been removed" R"Tool Unload Confirmation" S2 ;blocking confirmation window
  T-1
  M106 P4 S0						    ;close tool collet
  M291 P"Tool unloading complete. Continue by unloading more tools, selecting tool for use, or homing machine" R"Tool Load Confirmation" ;non-blocking confirmation window
  
  
else								;no tool selected from UI
	M291 P"No valid tool selected" R"TC Error 1" T-1
  