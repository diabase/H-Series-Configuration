; tprime4.g
; Called to prime and clean tool 4
; Written by Diabase Engineering
; Last Updated: July 28, 2021

M118 S{"Info: Begin tprime4.g"} L2

set global.PrimeNextTC = 1  ; We want to prime as part of this tool change.
T4                          ; Select Tool

M118 S{"Info: End tprime4.g"} L2
