; Maxoffset.g
; Written by Diabase Engineering
; Last Updated: May 15, 2021
; Calculates longest tool

set global.maxoffset=0
while iterations<#tools
	if tools[iterations] !=null
		set global.maxoffset={max(-tools[iterations].offsets[2],global.maxoffset)}