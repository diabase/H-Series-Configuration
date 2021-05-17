; TC_max.g
; Written by Diabase Engineering
; Last Updated: May 15, 2021
; Calculates longest tool

set global.TClength=0
while iterations<#tools
	if tools[iterations] !=null
		set global.TClength={max(-tools[iterations].offsets[2],global.TClength)}
echo global.TClength
  