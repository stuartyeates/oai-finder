#!/bin/bash 

a="int ac ad ae af ag ai al am an ao ar as at au aw ax az"
b="ba bb bd be bf bg bh bi bj bm bn bo br bs bt bv bw by"
c="ca cc cd cf cg ch ci ck cl cm cn co cr cs cu cv cw cx cy cz"
d="de dj dk dm do dz"
e="ec ee eg eh er es et eu"
f="fi fj fk fm fo fr"
g="ga gb gd ge gf gg gh gi gl gm gn gp gp gr gs gt gu gw gy "
h="hk hm hn hr ht hu"
i="id ie il im in io iq ir is it"
j="je jm jo jp"
k="ke kg kh ki km kn kp kr kw ky kz"
l="la lb lc ll lk lr ls lt lu lv ly"
m="ma mc md me mg mh mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz"
n="na nc ne nf ng ni nl no np nr nu nz"
o="om"
p="pa pe pf pg ph pk pl pm pn pr ps pt pw py"
q="qa"
r="re ro rs ru rw"
s="sa sb sc sd se sg sh si sj sk sl sm sn so sr ss st su sv sx sy sz"
t="tc td tf tg th tj tk tl tm tn to tp tr tt tv tw tz"
u="ua ug uk us uy uz"
v="va vc ve vg vi vn vu"
w="wf ws"
y="ye yt yu"
z="za zm zr zw"

COUNTRYDOMAINS="${a} ${b} ${c} ${d} ${e} ${f} ${g} ${h} ${i} ${j} ${k} ${l} ${m} ${n} ${o} ${p} ${q} ${r} ${s} ${t} ${u} ${v} ${w} ${y} ${z}"

for from in 0 50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 1000 1050 1100 1150 1200 1250 1300 1350 1400 1450 1500 1550 1600 1650 1700 1750 1800 1850 1900 1950; do
    for code in ${COUNTRYDOMAINS} ; do
	for string in  \"/islandora/object/\" \"VITAL+Repository\"  ETD-db \"free+software+developed+by+the+University+of+Southampton\" \"JOURNAL+CONTENT\"+\"issue+view\" \"Select+a+community+to+browse+its+collections\"; do 
	    echo "http://www.google.com/search?num=50&q=${string}+site%3A.${code}&start=${from}"
	done
    done
done