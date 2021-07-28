; tprime2.g
; Called to prime and clean tool 2
; Written by Diabase Engineering
; Last Updated: July 28, 2021

M118 S{"Info: Begin tprime2.g"} L2

set global.PrimeNextTC = 1  ; We want to prime as part of this tool change.
T2                          ; Select Tool

M118 S{"Info: End tprime2.g"} L2
