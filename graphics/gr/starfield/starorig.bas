10 GR:DEFFNR(S)=INT(RND(1)*S)+1
20 FOR P=0 TO 9:GOSUB 100:NEXT
30 FOR P=0 TO 9:COLOR=0
40 X=A(P)/Z(P)+20:Y=B(P)/Z(P)+20
50 IF X<0 OR X>39 OR Y<0 OR Y>39 THEN 95
70 PLOT O(P),Q(P):COLOR=15-5*(Z(P)>10):PLOT X,Y:O(P)=X:Q(P)=Y
80 Z(P)=Z(P)-1:IF Z(P)<=0 THEN 95
90 NEXT:GOTO 30
95 GOSUB 100:GOTO 90
100 A(P)=FNR(256)-127:B(P)=FNR(256)-127:Z(P)=FNR(48):RETURN
