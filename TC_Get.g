if tools[{state.currentTool}].spindle>-1
  G90
  G1 B0 F8000						    ;move gantry o tool position
  M400							        ;wait for movement to complete
  M98 P"unlock_turret.g"    ;unlock turret before movement
  M400
  G1 U180							      ;move to vertical position (into tool cradle)
  M106 P4 S1						    ;release tool collet
  M400
  M208 S0 Z{move.axes[2].max+(global.TCZ-move.axes[2].max+12)} ; add extra movement above limit switch, defined as 12mm above toolsetter stud location
  T-1 P0                      ;release tool to remove tool offsets
  G1 Z{move.axes[2].max} 		;move to Zmax
  M400
  M106 P4 S0						    ;close tool collet
  M400
  T{state.previousTool} P0  ;recover tool   
  G1 D40							      ;open tool cradle clamp
  M400
  G1 U178                   ;rotate turret slightly to avoid any scratching of TC
  G91
  G1 Z{tools[{state.currentTool}].offsets[2]-10}        ;move down by tool length plus 10mm
  G90    
  M400
  M98 P"homed.g"					  ;close tool cradle clamp
  ;G1 U180                   ;return to vertical tool orientation
  M501                      ;recover machine Zmax
  set global.TCin=1         ;set tool load variable to 1
  
else								;no tool selected when this was called
	M291 P"No valid tool selected" R"TC Error 1" T-1
  