if tools[{state.currentTool}].spindle>-1
  G90
  G1 B0 F8000						    ;move to original position
  M400							        ;wait for movement to complete
  G1 D40							      ;open tool cradle clamp
  M208 S0 Z{move.axes[2].max+(global.TCZ-move.axes[2].max+12)} ;; add extra movement above limit switch, defined as 12mm above toolsetter stud location
  T-1 P0                       ;release tool in firmware to remove Z offset
  M98 P"unlock_turret.g"    ;unlock turret before movement
  M400
  G1 U344                   ;rotate to near gripper position (no tool selected)
  G1 Z{move.axes[2].max} 		;move to Zmax
  M400
  G1 U354							      ;move to vertical position (no tool selected)
  M400
  M98 P"homed.g"				    ;close tool cradle clamp
  M106 P4 S1						    ;release tool collet
  G4 P500

  G91
  G1 Z-40                   ;move down to safe position
  M400
  M106 P4 S0                ;close tool collet
  M501                      ;recover machine Zmax
  set global.TCin=0         ;set tool loaded variable to 0
  
else								        ;no spindle tool selected when this was called
	M291 P"No valid tool selected" R"TC Error 1" T-1
  