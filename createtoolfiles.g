; createtoolfiles.g
; Create tfree.g, tpre.g, and tpost.g for each tool as necessary
; Parameters
;    T: Tool number
; Written by Diabase Engineering
; Last Updated: December 14, 2021

M118 S{"Info: Begin createtoolfiles.g with parameter T"^{param.T}} L2

if {param.T} == 1
    M28 "0:/sys/tfree1.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 2
    M28 "0:/sys/tfree2.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 3
    M28 "0:/sys/tfree3.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 4
    M28 "0:/sys/tfree4.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 5
    M28 "0:/sys/tfree5.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 6
    M28 "0:/sys/tfree6.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 7
    M28 "0:/sys/tfree7.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 8
    M28 "0:/sys/tfree8.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 9
    M28 "0:/sys/tfree9.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 10
    M28 "0:/sys/tfree10.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 11
    M28 "0:/sys/tfree11.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 12
    M28 "0:/sys/tfree12.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 13
    M28 "0:/sys/tfree13.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 14
    M28 "0:/sys/tfree14.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 15
    M28 "0:/sys/tfree15.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 16
    M28 "0:/sys/tfree16.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 17
    M28 "0:/sys/tfree17.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 18
    M28 "0:/sys/tfree18.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 19
    M28 "0:/sys/tfree19.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 20
    M28 "0:/sys/tfree20.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 21
    M28 "0:/sys/tfree21.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 22
    M28 "0:/sys/tfree22.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 23
    M28 "0:/sys/tfree23.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 24
    M28 "0:/sys/tfree24.g"
    M98 P"tfree-universal.g"
    M29
elif {param.T} == 25
    M28 "0:/sys/tfree25.g"
    M98 P"tfree-universal.g"
    M29

if {param.T} == 1
    M28 "0:/sys/tpre1.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 2
    M28 "0:/sys/tpre2.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 3
    M28 "0:/sys/tpre3.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 4
    M28 "0:/sys/tpre4.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 5
    M28 "0:/sys/tpre5.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 6
    M28 "0:/sys/tpre6.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 7
    M28 "0:/sys/tpre7.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 8
    M28 "0:/sys/tpre8.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 9
    M28 "0:/sys/tpre9.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 10
    M28 "0:/sys/tpre10.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 11
    M28 "0:/sys/tpre11.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 12
    M28 "0:/sys/tpre12.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 13
    M28 "0:/sys/tpre13.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 14
    M28 "0:/sys/tpre14.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 15
    M28 "0:/sys/tpre15.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 16
    M28 "0:/sys/tpre16.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 17
    M28 "0:/sys/tpre17.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 18
    M28 "0:/sys/tpre18.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 19
    M28 "0:/sys/tpre19.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 20
    M28 "0:/sys/tpre20.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 21
    M28 "0:/sys/tpre21.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 22
    M28 "0:/sys/tpre22.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 23
    M28 "0:/sys/tpre23.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 24
    M28 "0:/sys/tpre24.g"
    M98 P"tpre-universal.g"
    M29
elif {param.T} == 25
    M28 "0:/sys/tpre25.g"
    M98 P"tpre-universal.g"
    M29

if {param.T} == 1
    M28 "0:/sys/tpost1.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 2
    M28 "0:/sys/tpost2.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 3
    M28 "0:/sys/tpost3.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 4
    M28 "0:/sys/tpost4.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 5
    M28 "0:/sys/tpost5.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 6
    M28 "0:/sys/tpost6.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 7
    M28 "0:/sys/tpost7.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 8
    M28 "0:/sys/tpost8.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 9
    M28 "0:/sys/tpost9.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 10
    M28 "0:/sys/tpost10.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 11
    M28 "0:/sys/tpost11.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 12
    M28 "0:/sys/tpost12.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 13
    M28 "0:/sys/tpost13.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 14
    M28 "0:/sys/tpost14.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 15
    M28 "0:/sys/tpost15.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 16
    M28 "0:/sys/tpost16.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 17
    M28 "0:/sys/tpost17.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 18
    M28 "0:/sys/tpost18.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 19
    M28 "0:/sys/tpost19.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 20
    M28 "0:/sys/tpost20.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 21
    M28 "0:/sys/tpost21.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 22
    M28 "0:/sys/tpost22.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 23
    M28 "0:/sys/tpost23.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 24
    M28 "0:/sys/tpost24.g"
    M98 P"tpost-universal.g"
    M29
elif {param.T} == 25
    M28 "0:/sys/tpost25.g"
    M98 P"tpost-universal.g"
    M29

M118 S{"Info: End createtoolfiles.g with parameter T"^{param.T}} L2