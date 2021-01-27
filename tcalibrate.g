M291 P"Bed will now move. Is Probe inside cavity?" R"Crash Check" S3

M561

M574 X1 Y1 S2 ; configured to use Probe

if sensors.probes[0].value[0]==0
	M675 X F100 R0.1; Find center of cavity on the X axis
	M675 Y F100 R0.1; Find center of cavity on the Y axis
	M675 X F100 R0.1; Find center of cavity on the X axis
	M675 Y F100 R0.1; Find center of cavity on the Y axis
else
	M291 P"PROBE ALREADY ENGAGED, ABORTING" S1
	abort

M574 X1 S1 P"xstop"
M574 Y1 S1 P"ystop"

G29 S1 ; reload mesh compensation