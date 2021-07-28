; tprime1.g
; Called to prime and clean tool 1
; Written by Diabase Engineering
; Last Updated: July 28, 2021

M118 S{"Info: Begin tprime1.g"} L2

set global.PrimeNextTC = 1  ; We want to prime as part of this tool change.
T1                          ; Select Tool

M118 S{"Info: End tprime1.g"} L2
