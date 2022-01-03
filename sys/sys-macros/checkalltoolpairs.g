; checkalltoolpairs.g
; Try to change between all pairs of tools whose number is between bounds defined below
; Written by Diabase Engineering
; Last Updated: December 10, 2021

M118 S{"Debug: Begin checkalltoolpairs.g"} L3

if {global.machineModel} == "H5B"
    var toolsLowerBound = 11
    var toolsUpperBound = 25
    var totalTools = {{var.toolsUpperBound} - {var.toolsLowerBound}}

    while iterations < {var.totalTools}
            T{var.toolsLowerBound+iterations}
            ;G4 P1000
            while iterations < {var.totalTools}
                if state.currentTool != {var.toolsLowerBound+iterations}
                    T{var.toolsLowerBound+iterations}
                    ;G4 P1000
                    T{state.previousTool}
                    ;G4 P1000

M118 S{"Debug: End  checkalltoolpairs.g"} L3
