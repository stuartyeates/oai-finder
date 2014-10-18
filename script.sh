#!/bin/bash 

adomain="ac ad ae af ag ai al am an ao ar as at au aw ax az"
bdomain="ba bb bd be bf bg bh bi bj bm bn bo br bs bt bv bw by"
cdomain="ca cc cd cf cg ch ci ck cl cm cn co cr cs cu cv cw cx cy cz"
ddomain="de dj dk dm do dz"
edomain="ec ee eg eh er es et eu"
fdomain="fi fj fk fm fo fr"
gdomain="ga gb gd ge gf gg gh gi gl gm gn gp gp gr gs gt gu gw gy "
hdomain="hk hm hn hr ht hu"
idomain="id ie il im in io iq ir is it"
jdomain="je jm jo jp"
kdomain="ke kg kh ki km kn kp kr kw ky kz"
ldomain="la lb lc ll lk lr ls lt lu lv ly"
mdomain="ma mc md me mg mh mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz"
ndomain="na nc ne nf ng ni nl no np nr nu nz"
odomain="om"
pdomain="pa pe pf pg ph pk pl pm pn pr ps pt pw py"
qdomain="qa"
rdomain="re ro rs ru rw"
sdomain="sa sb sc sd se sg sh si sj sk sl sm sn so sr ss st su sv sx sy sz"
tdomain="tc td tf tg th tj tk tl tm tn to tp tr tt tv tw tz"
udomain="ua ug uk us uy uz"
vdomain="va vc ve vg vi vn vu"
wdomain="wf ws"
ydomain="ye yt yu"
zdomain="za zm zr zw"

COUNTRYDOMAINS="${adomain} ${bdomain} ${cdomain} ${ddomain} ${edomain} ${fdomain} ${gdomain} ${hdomain} ${idomain} ${jdomain} ${kdomain} ${ldomain} ${mdomain} ${ndomain} ${odomain} ${pdomain} ${qdomain} ${rdomain} ${sdomain} ${tdomain} ${udomain} ${vdomain} ${wdomain} ${ydomain} ${zdomain}"

OTHERDOMAINS="int com org net edu gov mil arpa"

for from in 0 50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 1000 1050 1100 1150 1200 1250 1300 1350 1400 1450 1500 1550 1600 1650 1700 1750 1800 1850 1900 1950; do
    for code in ${COUNTRYDOMAINS} ; do
	for string in  \"/islandora/object/\" \"VITAL+Repository\"  ETD-db \"free+software+developed+by+the+University+of+Southampton\" \"JOURNAL+CONTENT\"+\"issue+view\" \"Select+a+community+to+browse+its+collections\"; do 
	    echo "http://www.google.com/search?num=50&q=${string}+site%3A.${code}&start=${from}"
	done
    done
done