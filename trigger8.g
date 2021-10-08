; trigger8.g
; Activates when incoming air pressure drops below set point
; Written by Diabase Engineering
; Last Updated: October 8, 2021

M118 S{"Debug: Begin trigger8.g"} L3

M291 P"Incoming air pressure low." R"Crash Detected" S3  

M118 S{"Debug: End trigger8.g"} L3
