; replicatexyoffsets.g
; Called to copy the x and y tool offsets from the current tool to all tool changer tools
; Written by Diabase Engineering
; Last Updated: March 25, 2022

M118 S{"Begin replicatexyoffsets.g"} L3

var xOffset = tools[state.currentTool].offsets[0]
var yOffset = tools[state.currentTool].offsets[1]

M291 P{"The current (x,y) offsets for this tool are ("^var.xOffset^","^var.yOffset^")."} R"Current XY Offsets" S2
M291 P{"Do you want to set the (x,y) offsets for all tool changer tools to ("^var.xOffset^","^var.yOffset^")?"} R"Copy XY Offsets?" S3

while iterations < #tools
    if iterations <= 10
        continue
    else
        M118 S{"(x,y) offsets for tool "^iterations^" were ("^tools[iterations].offsets[0]^","^tools[iterations].offsets[1]^")."} L3
        G10 L1 P{iterations} X{var.xOffset} Y{var.yOffset}
        M118 S{"(x,y) offsets for tool "^iterations^" are now ("^tools[iterations].offsets[0]^","^tools[iterations].offsets[1]^")."} L3

M500 P10

M118 S{"End replicatexyoffsets.g"} L3
