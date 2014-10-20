#!/bin/bash

LANGUAGES=en

for l in ${LANGUAGES}; do
    for t1 in `cat topic-terms.en.utf8`; do
	for t2 in `cat general-tech-terms.en.utf8`; do
	    echo wget --restrict-file-names=windows  --default-page=index.php --user-agent="" --ignore-length   "http://scholar.google.co.nz/scholar?q=${t1}+${t2}&num=20&start=80&as_sdt=0,5"
	done;
    done;
done