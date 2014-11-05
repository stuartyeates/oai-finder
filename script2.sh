#!/bin/bash

LANGUAGES=en

#turns out not to be very helpful
#for l in ${LANGUAGES}; do
#    for t1 in `cat topic-terms.en.utf8`; do
#	for t2 in `cat general-tech-terms.en.utf8 dspace-terms.en.utf8 eprints-terms.en.utf8`; do
#	    for n in 0 20 40 80 100 120 140 160 180 200 220 240 260 280; do
#		echo "http://scholar.google.co.nz/scholar?q=${t1}+${t2}&num=20&start=${n}&as_sdt=0,5" >> scholar.urls.en
#		echo "http://scholar.google.co.nz/scholar?q=${t1}&num=20&start=${n}&as_sdt=0,5" >> scholar.urls.en
#		echo "http://scholar.google.co.nz/scholar?q=${t2}&num=20&start=${n}&as_sdt=0,5" >> scholar.urls.en
#	    done;
#	done;
#    done;
#done

rm  google.urls

DOMAINS=`cat country-domains.utf8`
OAITERMS=`cat oai-terms.utf8`


for from in 0 50; do
    for domain in ${DOMAINS} ; do
	for t1 in  ${OAITERMS}; do 
	    echo "https://www.google.co.nz/search?start=${n}&num=50&filter=0&q=${t1}+site%3A.${domain}" >> google.urls
	done
    done
done

for language in ${LANGUAGES}; do
    for t1 in `cat ojs-terms.en.utf8 islandora-terms.en.utf8 etd-db-terms.en.utf8 vital-terms.en.utf8 dspace-terms.${language}.utf8 eprints-terms.${language}.utf8`; do
	for n in 0 50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000 1050  ; do
	    echo "https://www.google.co.nz/search?start=${n}&num=50&filter=0&q=${t1}" >> google.urls
	done;
    done;
done

#ONEHUNDRED="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 2 526 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99"
#
#for n in ${ONEHUNDRED}; do
#    for t2 in `cat dspace-terms.en.utf8 eprints-terms.en.utf8 ojs-terms.en.utf8`; do
#	echo "https://www.yandex.com/yandsearch?lr=87&text=${t2}&p=${n}" >> yandex.urls
#    done
#done