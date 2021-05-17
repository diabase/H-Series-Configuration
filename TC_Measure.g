if tools[{state.currentTool}].spindle>-1
  G90
  G1 B0 F8000						;move to original position
  M400							;wait for movement to complete
  G1 D40							;open tool cradle clamp
  M208 S0 Z{move.axes[2].max-(move.axes[2].max-global.ToolSetPos)+12} ; add extra movement above limit switch, defined as 12mm above toolsetter stud location
  G1 Z{move.axes[2].max} 		;move to Zmax
  M400
  G1 U180							;move to vertical position (into tool cradle)
  M400
  M98 P"homed.g"					;close tool cradle clamp
  M106 P4 S1						;release tool collet
  G4 P500

  G91
  G1 Z-40
  
else								;no tool selected when this was called
	echo "no tool selected"
  