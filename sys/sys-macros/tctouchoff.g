; tctouchoff.g
; Called to touch off the current tool on the toolchanger touch off plate
; Parameters:
;    I: Wait for user confirmation that the tool is in position for touchoff? (0 - Don't wait, 1 - Wait)
; Written by Diabase Engineering
; Last Updated: April 25, 2022

M118 S{"Begin tctouchoff.g"} L3

if {global.machineModel} == "H5B"
    if sensors.gpIn[{global.airPressureInNum}].value == 0
        M291 P"Warning: Incoming air pressure low. Resolve before continuing." R"Warning" S2                        ; Display a blocking warning with no timeout.
        abort

    if state.currentTool == 2
        M291 P{"The tool changer touchoff plate can only be used with the probe or a tool changer tool."} R"Invalid Tool" S2
        abort

    elif state.currentTool == 3
        M291 P{"The tool changer touchoff plate can only be used with the probe or a tool changer tool."} R"Invalid Tool" S2
        abort

    elif state.currentTool == 4
        M291 P{"The tool changer touchoff plate can only be used with the probe or a tool changer tool."} R"Invalid Tool" S2
        abort

    elif state.currentTool == 5
        M291 P{"The tool changer touchoff plate can only be used with the probe or a tool changer tool."} R"Invalid Tool" S2
        abort

    elif state.currentTool > 24
        M291 P{"The tool changer touchoff plate can only be used with the probe or a tool changer tool."} R"Invalid Tool" S2
        abort

    else
        var zAxisIndex = -1
        while iterations < #move.axes
            if move.axes[iterations].letter == "Z"
                set var.zAxisIndex = iterations
                break

        var uAxisIndex = -1
        while iterations < #move.axes
            if move.axes[iterations].letter == "U"
                set var.uAxisIndex = iterations
                break

        if state.currentTool != global.zProbeToolNum
            if {global.probeOverTravelTCTouchOff} = -1
                M291 P{"Tool changer touch off position not yet probed. Try again with probe."} R"Probe First" S2
                abort

        if global.dontRotate != 1
            M98 P"unlock_turret.g"                                                                                      ; Unlock turret
            G90                                                                                                         ; Absolute positioning
            G53 G1 U{180 - tools[{state.currentTool}].offsets[var.uAxisIndex]} B0 Z{move.axes[var.zAxisIndex].max - 100} F30000      ; Point active tool at tool changer
            M98 P"lock_turret.g"                                                                                        ; Lock turret
        else
            G90                                                                                                         ; Absolute positioning
            G53 H2 G1 Z{move.axes[var.zAxisIndex].max - 100} F10000                                                                  ; Move Z to 100mm below ZMax quickly
            G1 B{tools[{state.currentTool}].offsets[6]} F30000                                                          ; Move tool changer to touchoff plate position
        M400                                                                                                        ; Wait for current moves to finish

        if state.currentTool == global.zProbeToolNum
            M574 Z2 S1 P{global.zSwitchPin}                                                                             ; Configure Z endstop position at high end, it's an optical interrupt on pin defined in defaultparameters.g
            M98 P"0:/sys/sys-macros/allprobeparameters.g"
            var existingProbeSpeed0 = {{sensors.probes[0].speeds[0]}*60}                                                ; Save the current probe speed in a temporary variable
            M118 S{"tctouchoff.g: existingProbeSpeed0 set to "^var.existingProbeSpeed0} L3
            var existingProbeSpeed1 = {{sensors.probes[0].speeds[1]}*60}                                                ; Save the current probe speed in a temporary variable
            M118 S{"tctouchoff.g: existingProbeSpeed1 set to "^var.existingProbeSpeed1} L3
            var lastProbingOverTravel = -1                                                                              ; Initialize lastProbingOverTravel
            var thisProbingOverTravel = -1                                                                              ; Initialize thisProbingOverTravel

            if {param.I} == 1
                M291 P{"Arm will move up. Is the probe directly below the tool changer touchoff plate?"} R"Crash Check" S3
            if sensors.probes[0].value[0] == 1000
                M291 P{"Error: Probe already triggered. Check probe and try again."} R"Probe Already Triggered" S2
                abort

            set global.keepProbeDeployed = 1                                                                            ; We don't want the probe to retract between probing attempts
            M98 P"0:/sys/sys-macros/allprobeparameters.g"
            M118 S{"tctouchoff.g: Setting probe feed rate to 1000 for initial fast probe."} L3
            M118 S{"tctouchoff.g: All parameters for this probe should follow on the next line."} L3
            M558 K0 F1000                                                               ; Override default probe parameters for initial fast probe
            M98 P"0:/sys/sys-macros/allprobeparameters.g"
            G38.2 Z{{move.axes[var.zAxisIndex].max}+40} K0                                                                           ; Attempt to probe straight up, above ZMax by 40 mm
            set var.thisProbingOverTravel = {{move.axes[var.zAxisIndex].machinePosition}-{move.axes[var.zAxisIndex].max}}                         ; Save distance traveled beyond ZMax to temporary variable
            set global.probeOverTravelTCTouchOff = var.thisProbingOverTravel                                            ; Save distance traveled beyond ZMax to global variable
            M118 S{"tctouchoff.g: Coarse probe triggered at Z"^ {move.axes[var.zAxisIndex].machinePosition} ^". Probe overtravel saved as " ^ {global.probeOverTravelTCTouchOff}} L3

            G91                                                                                                         ; Relative positioning
            G1 H2 Z-2 F10000                                                                                            ; Move down in Z quickly to prepare for second, slower, probing attempt
            G90                                                                                                         ; Absolute positioning
            
            set var.lastProbingOverTravel = var.thisProbingOverTravel                                                   ; Move previous distance traveled into temporary variable for comparison
            M118 S{"tctouchoff.g Setting probe feed rate to 150 for secondary slow probe."} L3
            M118 S{"tctouchoff.g All parameters for this probe should follow on the next line."} L3
            M558 K0 F150                                                                ; Override default probe parameters for slow, accurate probe
            M98 P"0:/sys/sys-macros/allprobeparameters.g"
            G38.2 K0 Z{{move.axes[var.zAxisIndex].max}+40}                                                                           ; Attempt to probe straight up, above ZMax by 40 mm
            set var.thisProbingOverTravel = {{move.axes[var.zAxisIndex].machinePosition}-{move.axes[var.zAxisIndex].max}}                         ; Save distance traveled beyond ZMax to temporary variable
            set global.probeOverTravelTCTouchOff = var.thisProbingOverTravel                                            ; Save distance traveled beyond ZMax to global variable
            
            M118 S{"tctouchoff.g: Fine probe triggered at Z"^ {move.axes[var.zAxisIndex].machinePosition} ^". Probe overtravel saved as " ^ {global.probeOverTravelTCTouchOff}} L3
            M118 S{"tctouchoff.g: Variance between coarse and fine probe was " ^{{var.thisProbingOverTravel}-{var.lastProbingOverTravel}}} L3
            set global.keepProbeDeployed = 0                                                                            ; Allow the probe to retract again
            M118 S{"tctouchoff.g: existingProbeSpeed0 is currently "^var.existingProbeSpeed0} L3
            M118 S{"tctouchoff.g: existingProbeSpeed1 is currently "^var.existingProbeSpeed1} L3
            M118 S{"tctouchoff.g: Returning probe feedrate to saved values."} L3
            M118 S{"tctouchoff.g: All parameters for this probe should follow on the next line."} L3
            M558 K0 F{var.existingProbeSpeed0}:{var.existingProbeSpeed1}
            M98 P"0:/sys/sys-macros/allprobeparameters.g"
            M574 Z1 S2                                                                                                  ; Set Z endstop position to low end and configure as Z probe

        else
            M98 P"0:/sys/sys-macros/allprobeparameters.g"
            var existingProbeSpeed0 = {{sensors.probes[2].speeds[0]}*60}                                                       ; Save the current probe speed in a temporary variable
            M118 S{"tctouchoff.g: existingProbeSpeed0 set to "^var.existingProbeSpeed0} L3
            var existingProbeSpeed1 = {{sensors.probes[2].speeds[1]}*60}                                                       ; Save the current probe speed in a temporary variable
            M118 S{"tctouchoff.g: existingProbeSpeed1 set to "^var.existingProbeSpeed1} L3
            var lastProbingOverTravel = -1                                                                              ; Initialize lastProbingOverTravel
            var thisProbingOverTravel = -1                                                                              ; Initialize thisProbingOverTravel
            if {param.I} == 1
                M291 P{"Arm will move up. Is the tool directly below the tool changer touchoff plate?"} R"Crash Check" S3
            if sensors.probes[2].value[0] == 1000
                M291 P{"Error: Tool changer touch off plate already triggered. Check tool changer touch off plate and try again."} R"TC TO Plate Already Triggered" S2
                abort
            set global.keepProbeDeployed = 1                                                                            ; We don't want the probe to retract between probing attempts
            M118 S{"tctouchoff.g: Setting TC touchoff plate feed rate to 1000 for initial fast touch off."} L3
            M118 S{"tctouchoff.g: All parameters for this probe should follow on the next line."} L3
            M558 K2 F1000                                                           ; Override default probe parameters for initial fast probe
            M98 P"0:/sys/sys-macros/allprobeparameters.g"
            G38.2 Z{{move.axes[var.zAxisIndex].max}+27} K2                                                                           ; Attempt to probe straight up, above ZMax by 27 mm
            set var.thisProbingOverTravel = {{move.axes[var.zAxisIndex].machinePosition}-{move.axes[var.zAxisIndex].max}}                         ; Save distance traveled beyond ZMax to temporary variable
            G10 L1 P{state.currentTool} Z{{var.thisProbingOverTravel}-{global.probeOverTravelTCTouchOff}}
            M500 P10
            M98 P"maxoffset.g"
            M118 S{"tctouchoff.g: Coarse tool touch off triggered at Z"^ {move.axes[var.zAxisIndex].machinePosition} ^". Z offset saved as " ^ {tools[{state.currentTool}].offsets[var.zAxisIndex]}} L3
            
            G91                                                                                                         ; Relative positioning
            G1 H2 Z-2 F10000                                                                                             ; Move down in Z quickly to prepare for second, slower, probing attempt
            G90                                                                                                         ; Absolute positioning

            set var.lastProbingOverTravel = var.thisProbingOverTravel                                                   ; Move previous distance traveled into temporary variable for comparison
            M118 S{"tctouchoff.g Setting TC touchoff plate feed rate to 150 for secondary slow touch off."} L3
            M118 S{"tctouchoff.g All parameters for this probe should follow on the next line."} L3
            M558 K2 F200                                                               ; Override default probe parameters for slow, accurate probe
            M98 P"0:/sys/sys-macros/allprobeparameters.g"
            ; M291 P"Ready for second probe attempt?" R"Crash Check" S3
            G38.2 K2 Z{{move.axes[var.zAxisIndex].max}+27}                                                                           ; Attempt to probe straight up, above ZMax by 27 mm
            set var.thisProbingOverTravel = {{move.axes[var.zAxisIndex].machinePosition}-{move.axes[var.zAxisIndex].max}}                         ; Save distance traveled beyond ZMax to temporary variable
            G10 L1 P{state.currentTool} Z{{var.thisProbingOverTravel}-{global.probeOverTravelTCTouchOff}}
            M500 P10
            M98 P"maxoffset.g"
            M118 S{"tctouchoff.g: Fine tool touch off triggered at Z"^ {move.axes[var.zAxisIndex].machinePosition} ^". Z offset saved as " ^ {tools[{state.currentTool}].offsets[var.zAxisIndex]}} L3
            M118 S{"tctouchoff.g: Variance between coarse and fine touch off was " ^{{var.thisProbingOverTravel}-{var.lastProbingOverTravel}}} L3
            set global.keepProbeDeployed = 0                                                                            ; Allow the probe to retract again
            M118 S{"tctouchoff.g: Returning TC touchoff plate feed rate to original values."} L3
            M118 S{"tctouchoff.g: All parameters for this probe should follow on the next line."} L3
            M558 K2 F{var.existingProbeSpeed0}:{var.existingProbeSpeed1}
            M98 P"0:/sys/sys-macros/allprobeparameters.g"

        G53 H2 G1 Z{move.axes[var.zAxisIndex].max + global.maxOffset - 5} F10000                                                     ; Move machine position to 5mm below ZMax, ignoring endstops, at 10000 mm/min
        M400                                                                                                            ; Wait for current moves to finish
        if global.dontRotate != 1
            M98 P"unlock_turret.g"                                                                                      ; Unlock turret
            G53 G1 U{0 - tools[{state.currentTool}].offsets[var.uAxisIndex]} Z{move.axes[var.zAxisIndex].max} F30000        ; Point active tool at tool changer
            M98 P"lock_turret.g"                                                                                        ; Lock turret

M118 S{"End tctouchoff.g"} L3
