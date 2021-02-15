M291 P"Turret will now move. Is a tool above the touch-off pin?" R"Crash Check" S3
G10 P{state.currentTool} Z0
G38.2 Z{move.axes[2].userPosition - 8} P1