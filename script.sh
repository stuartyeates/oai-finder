#!/bin/bash 

COUNTRYDOMAINS=`cat country-domains.utf8`

OTHERDOMAINS="int com org net edu gov mil arpa"

for from in 0 50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 1000 1050 1100 1150 1200 1250 1300 1350 1400 1450 1500 1550 1600 1650 1700 1750 1800 1850 1900 1950; do
    for code in ${COUNTRYDOMAINS} ; do
	for string in  \"/islandora/object/\" \"VITAL+Repository\"  ETD-db \"free+software+developed+by+the+University+of+Southampton\" \"JOURNAL+CONTENT\"+\"issue+view\" \"Select+a+community+to+browse+its+collections\"; do 
	    echo "http://www.google.com/search?num=50&q=${string}+site%3A.${code}&start=${from}"
	done
    done
done