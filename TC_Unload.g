; TC_unload.g
; Written by Diabase Engineering
; Last Updated: May 15, 2021

if global.TCload>-1
  M291 P"Tool unloading will begin" R"Tool Unload Confirmation" S3 ;blocking confirmation window
  T{global.TCload} P0       ;activate desired tool, do not move turret
  G90
  G1 B0 F8000						    ;move gantry o tool position
  M400							        ;wait for movement to complete
  M98 P"unlock_turret.g"    ;unlock turret before movement
  M400
  G1 U180							      ;move to vertical position (into tool cradle)
  M106 P4 S1						    ;release tool collet
  M400
  M208 S0 Z{move.axes[2].max+(global.TCZ-move.axes[2].max+10)} ; add extra movement above limit switch, defined as 12mm above toolsetter stud location
  var Zoffset=tools[state.currentTool].offsets[2] ;save tool offset
  G10 P{state.currentTool} Z0  ;set tool offset to 0
  G1 Z{move.axes[2].max} 		;move to Zmax
  M400
  M106 P4 S0						    ;close tool collet
  M400
  G10 P{state.currentTool} Z{var.Zoffset}  ;recover tool offset
  G1 D40							      ;open tool cradle clamp
  M400
  G1 U170                   ;rotate turret slightly to avoid any scratching of TC
  G91
  G1 Z-60                   ;move down by 60mm - CHANGE TO MIN OF CLEARANCE OR MAX TOOL LENGTH?
  G90    
  M400
  M98 P"homed.g"					  ;close tool cradle clamp
  ;G1 U180                   ;return to vertical tool orientation
  M501                      ;recover machine Zmax
  G1 U90                    ;move to user-facing position
  M400
  M106 P4 S1						    ;release tool collet
  M291 P"Click OK when tool has been removed" R"Tool Unload Confirmation" S2 ;blocking confirmation window
  T-1 P0
  M106 P4 S0						    ;close tool collet
  set global.TCin=0         ;set tool loaded variable to 0
  set global.TCactive=0     ;toolchange is active
  set global.TCload=-1      ;set TCload variable to non-defined
  M291 P"Tool unloading complete. Continue by unloading more tools, selecting tool for use, or homing machine" R"Tool Load Confirmation" ;non-blocking confirmation window
  
  
else								;no tool selected from UI
  M291 P"No valid tool selected" R"TC Error 1" T-1
  