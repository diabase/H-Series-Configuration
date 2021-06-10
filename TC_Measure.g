if tools[{state.currentTool}].spindle>-1
    G90
    G10 P{state.currentTool} Z0 B0;  set Z and B offset to 0
    G1 B0 F8000						;move to original position
    M400							;wait for movement to complete
    M208 S0 Z{move.axes[2].max+(global.TCZ+12)} ;; add extra movement above limit switch, defined as 12mm above toolsetter stud location  G1 Z{move.axes[2].max} 		;move to Zmax
    G1 U{global.TCUpos}							;move to vertical position (into tool cradle)
    M400
    M558 K2 F800 
    G38.2 P2 Z{move.axes[2].max} ;  probe upwards to Zmax
    M400
    var Zoffset = {move.axes[2].userPosition} ;save Z offset
    M400
    G91
    G1 Z-20
    M501    ; recover tool offsets
    G10 P{state.currentTool} Z{var.Zoffset-(global.TCZ+move.axes[2].max)} ; save Zoffset to Tool offsets
    M500  ; write Tool offsets to file
    M98 P"tc_max.g"

else								;no tool selected when this was called
    echo "no tool selected"
  