#!/bin/bash

HTMLDIR=./html

mv ${HTMLDIR} ${HTMLDIR}-old-$$
mkdir -p  ${HTMLDIR}

IN1DIR=./search-terms
IN2DIR="./noise-terms/tlds-utf8 ./noise-terms/organisation-terms-en.utf8"
IN2DIR2="./noise-terms/organisation-terms-en.utf8"

BINGOUT=${HTMLDIR}/bing_urls

for first in `cat ${IN1DIR}/*`; do
    echo $first
    OUTPUTFILE=${HTMLDIR}/generated-${first}.html

    echo '<html><body>' > ${OUTPUTFILE}
    echo '<h1>'$first'</h1><div>' >> ${OUTPUTFILE}

    echo '<p><a href="http://www.bing.com/search?q='${first}'&filter=0&count=50">'${first} bing'</a></p><p>' >> ${OUTPUTFILE}
    for second in `cat ${IN2DIR}`; do
	echo '<a href="http://www.bing.com/search?q='${first}+${second}'&filter=0&count=50">'${second}'</a>' >> ${OUTPUTFILE}
    done

    #sneaky sideline, since bing has lots of hits and doesn't seem to mind log-rate automated queries
    for second in `cat ./noise-terms/en-subjects-wordlist ./noise-terms/research-terms-en.utf8  | sort | uniq`; do
	echo 'http://www.bing.com/search?q='${first}'+'${second}'&filter=0&count=50' >> ${BINGOUT}
    done
    
    echo '</p></div><div>' >> ${OUTPUTFILE}

    echo '<p><a href="https://www.google.co.nz/search?q='${first}'&filter=0&num=50&">'${first}' google</a></p><p>' >> ${OUTPUTFILE}
    for second in `cat ${IN2DIR}`; do
	echo '<a href="https://www.google.co.nz/search?q='${first}+${second}'&filter=0&num=50">'${second}'</a>' >> ${OUTPUTFILE}
    done    

    echo '</p></div><div>' >> ${OUTPUTFILE}

    echo '<p><a href="https://www.sogou.com/web?query='${first}'">'${first}'</a></p><p>' >> ${OUTPUTFILE}
    for second in `cat ${IN2DIR2}| sort| uniq`; do
	echo '<a href="https://www.sogou.com/web?query='${first}+${second}'">'${second}' sogou</a>' >> ${OUTPUTFILE}
    done
    
    echo '</p></div><div>' >> ${OUTPUTFILE}

    echo '<p><a href="https://www.yandex.com/search/?text='${first}'">'${first}'</a></p><p>' >> ${OUTPUTFILE}
    for second in `cat ${IN2DIR2}| sort| uniq`; do
	echo '<a href="https://www.yandex.com/search/?text='${first}+${second}'">'${second}' yandex</a>' >> ${OUTPUTFILE}
    done    
    echo '</p></div></body></html>' >> ${OUTPUTFILE}
    
done


#http://www.bing.com/search?q=${1} ${2} ${3}&filter=0&count=50


#for i in {15000..21000}; do echo http://cdm$i.contentdm.oclc.org/; done > html/cdm_urls
# wget --input-file=html/cdm_urls --force-directories --directory-prefix=./cache-cdm-brute-force/ --wait=10 --convert-links --tries=2 --timeout=5

cat  ${BINGOUT} | sort | uniq | shuf  |sed 's|&quot;|"|g'| head -10000 > ${BINGOUT}-shuf
#cat  ${BINGOUT} | sort | uniq |sed 's|&quot;||g' | shuf > ${BINGOUT}-shuf
wget --user-agent="Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.108 Safari/537.36" --no-clobber  --wait=4 --restrict-file-names=windows  --directory-prefix=./cache-bing-wget/ --force-directories  --no-check-certificate --input-file=${BINGOUT}-shuf &

#for url in `cat ${BINGOUT}-shuf`; do
#    echo DOING "${url}"
#    firefox "${url}";
#    sleep 2
#done
