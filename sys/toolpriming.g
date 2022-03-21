if !{exists(global.t3AdditionalRetraction)}
	global t3AdditionalRetraction = 0;
else
	set global.t3AdditionalRetraction = 0;
M207 P3 S15 F3600 T240 R-7
if !{exists(global.t4AdditionalRetraction)}
	global t4AdditionalRetraction = 0;
else
	set global.t4AdditionalRetraction = 0;
M207 P4 S8 F3600 T240 R0
if !{exists(global.t5AdditionalRetraction)}
	global t5AdditionalRetraction = 0;
else
	set global.t5AdditionalRetraction = 0;
M207 P5 S15 F3600 T300 R-7
