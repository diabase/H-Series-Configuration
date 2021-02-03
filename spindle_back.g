if #tools[{state.currentTool}].name == 9 ; If this tool is a spindle...
    while iterations <= 3
        if state.currentTool == spindles[{iterations}].tool
            M4 P{iterations} S800
