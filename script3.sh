#!/bin/bash

LANGUAGES=en
#if [ -d ./build ]; then
#    mv build build-$(date -d "today" +"%Y%m%d%H%M%s")
#fi
#mkdir build
rm -f build/*urls

#create a list of all domains, so that we can search them separately
if [ ! -f ./all-domains ]; then
    wget http://data.iana.org/TLD/tlds-alpha-by-domain.txt
    cat tlds-alpha-by-domain.txt | tr 'A-Z' 'a-z' | grep -v \# > all-domains
    rm tlds-alpha-by-domain.txt
fi

######### Google 

## check for human-language-independent OAI-terms in every possible internet top level domain
DOMAINS=`cat all-domains`
OAITERMS=`cat oai-terms.utf8`
if [ false ] 
then
for from in 0 50; do
    for domain in ${DOMAINS} ; do
	for t1 in  ${OAITERMS}; do 
	    echo "https://www.google.co.nz/search?start=${n}&num=50&filter=0&q=${t1}+site%3A.${domain}" >> build/google.urls
	done
    done
done
fi

##check for repository-software-specific search terms in great depth, out to the max 1000 results, for each language we're working in
if [ false ] 
then
for language in ${LANGUAGES}; do
    for t1 in `cat  oai-terms.utf8 ojs-terms.${language}.utf8 islandora-terms.${language}.utf8 etd-db-terms.${language}.utf8 vital-terms.${language}.utf8 dspace-terms.${language}.utf8 eprints-terms.${language}.utf8`; do
	for n in 0 50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 ; do
	    echo "https://www.google.co.nz/search?start=${n}&num=50&filter=0&q=${t1}" >> build/google.urls
	done;
    done;
done
fi 

## check for a combination of repository-software-specific search terms and academic-field-specific search terms, shallowly, for each language we're working in
if [ true ] 
then
for language in ${LANGUAGES}; do
    for t1 in `cat ojs-terms.${language}.utf8 islandora-terms.${language}.utf8 etd-db-terms.${language}.utf8 vital-terms.${language}.utf8 dspace-terms.${language}.utf8 eprints-terms.${language}.utf8`; do
	for t2 in `cat academic-disciplines.${language}.utf8`; do
	    for n in 0; do
		echo "https://www.google.co.nz/search?start=${n}&num=50&filter=0&q=${t1} ${t2}" >> build/google.urls
	    done;
	done;
    done;
done
fi

######### Yandex
#Yandex has a maximum 100 pages of results at ten per page. 
#Yandex is proving very proficent at blocking 
TEN="1 2 3 4 5 6 7 8 9 10"
ONEHUNDRED="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 2 526 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99"
#
if [ false ] 
then
for language in ${LANGUAGES}; do
    for t1 in `cat  oai-terms.utf8 ojs-terms.${language}.utf8 islandora-terms.${language}.utf8 etd-db-terms.${language}.utf8 vital-terms.${language}.utf8 dspace-terms.${language}.utf8 eprints-terms.${language}.utf8`; do
	for n in ${TEN}; do
	    echo "https://www.yandex.com/yandsearch?lr=87&text=${t1}&p=${n}" >> build/yandex.urls
	done
    done
done
fi

######### Microsoft
# oai-specific results
for n in 1 51 101 151 201 251 301 351 401 451 501 551 601 651 701 751 801 851 901 951 ; do
    for t1 in  ${OAITERMS}; do 
	for t2 in `cat  academic-disciplines.${language}.utf8`; do
	echo "https://www.bing.com/search?q=${t1} ${t2}&count=50&first=${n}"  >> build/microsoft.urls
	done;
    done;
done;

#check for repository-specific search terms in great depth
for language in ${LANGUAGES}; do
    for t1 in `cat  oai-terms.utf8 ojs-terms.${language}.utf8 islandora-terms.${language}.utf8 etd-db-terms.${language}.utf8 vital-terms.${language}.utf8 dspace-terms.${language}.utf8 eprints-terms.${language}.utf8`; do
	for n in 1 51 101 151 201 251 301 351 401 451 501 551 601 651 701 751 801 851 901 951 ; do
	    echo "https://www.bing.com/search?q=${t1}&count=50&first=${n}"  >> build/microsoft.urls
	done;
    done;
done




######### Sogou

for n in 1 2 3 4 5 6 7 8 9 ; do
    for t2 in ${OAITERMS}; do
	echo "http://www.sogou.com/web?query=${t2}&page=${n}" >> build/sogou.urls
    done;
done;

#check for repository-specific search terms in great depth
for language in ${LANGUAGES}; do
    for t1 in `cat  oai-terms.utf8 ojs-terms.${language}.utf8 islandora-terms.${language}.utf8 etd-db-terms.${language}.utf8 vital-terms.${language}.utf8 dspace-terms.${language}.utf8 eprints-terms.${language}.utf8`; do
	for t2 in `cat academic-disciplines.${language}.utf8`; do
	    for n in 1 2 3 ; do
		echo "http://www.sogou.com/web?query=${t1} ${t2}&page=${n}" >> build/sogou.urls
	    done;
	done;
    done;
done

./google.sh &
./microsoft.sh &
#./yandex.sh & #blocked
./sogou.sh &
