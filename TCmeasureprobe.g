;measures TC location relative to probe, saves to TCZ variable
T0
M98 p"unlock_turret.g"
G90
G1 B0 F8000						;move to original position
M400							;wait for movement to complete
G1 Z{move.axes[2].max-10} F2000       ;move up quickly
M208 S0 Z{move.axes[2].max+16} ;; add extra movement above limit switch, defined as 12mm above toolsetter stud location  G1 Z{move.axes[2].max} 		;move to Zmax
G1 U{global.TCUpos}							;move to vertical position (into tool cradle)
M400
G38.2 P0 Z{move.axes[2].max} 
set global.TCZ = {move.axes[2].userPosition-move.axes[2].max+16}
G91
G1 Z-20
M501