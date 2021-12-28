; estop.g
; Behavior called when a voltage drop is detected during a job
; Written by Diabase Engineering
; Last Updated: July 14, 2021

M291 P"Print has been paused. After recovery, unpause from print status screen." R"Emergency Stop" S1 ; Display message with "Emergency Stop" as the message box title and display a "Close" button
M98 P"engagezbrake.g" ; Engage Z axis brake
M5 ; Turn off all spindles
