#!/bin/bash

LANGUAGES=en

for l in ${LANGUAGES}; do
    for t1 in `cat topic-terms.en.utf8`; do
	for t2 in `cat general-tech-terms.en.utf8 dspace-terms.en.utf8 eprints-terms.en.utf8`; do
	    for n in 0 20 40 80 100 120 140 160 180 200 220 240 260 280; do
		echo "http://scholar.google.co.nz/scholar?q=${t1}+${t2}&num=20&start=${n}&as_sdt=0,5" >> scholar.urls.en
		echo "http://scholar.google.co.nz/scholar?q=${t1}&num=20&start=${n}&as_sdt=0,5" >> scholar.urls.en
		echo "http://scholar.google.co.nz/scholar?q=${t2}&num=20&start=${n}&as_sdt=0,5" >> scholar.urls.en
	    done;
	done;
    done;
done

for l in ${LANGUAGES}; do
    for t1 in `cat topic-terms.en.utf8`; do
	for t2 in `cat general-tech-terms.en.utf8 dspace-terms.en.utf8 eprints-terms.en.utf8`; do
	    for n in 0 50 100 150 200 250 300 350 400 450 500 550 600 650 ; do
		echo "https://www.google.co.nz/search?num=${n}&start=50&q=${t1}" >> google.urls.en
		echo "https://www.google.co.nz/search?num=${n}&start=50&q=${t2}" >> google.urls.en
		echo "https://www.google.co.nz/search?num=${n}&start=50&q=${t1}+${t2}" >> google.urls.en
	    done;
	done;
    done;
done
