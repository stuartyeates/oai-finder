#!/bin/bash

HTMLDIR=./html

IN1DIR=./search-terms
IN2DIR="./noise-terms/tlds-utf8 ./noise-terms/organisation-terms-en.utf8"
IN2DIR2="./noise-terms/organisation-terms-en.utf8"



for first in `cat ${IN1DIR}/*| sort | uniq`; do
    echo $first
    OUTPUTFILE=${HTMLDIR}/generated-${first}.html

    echo '<html><body>' > ${OUTPUTFILE}
    echo '<h1>'$first'</h1><div>' >> ${OUTPUTFILE}

    echo '<p><a href="http://www.bing.com/search?q='${first}'&filter=0&count=50">'${first}'</a></p><p>' >> ${OUTPUTFILE}
    for second in `cat ${IN2DIR}| sort| uniq`; do
	echo '<a href="http://www.bing.com/search?q='${first}+${second}'&filter=0&count=50">'${second}'</a>' >> ${OUTPUTFILE}
    done
    
    echo '</p></div><div>' >> ${OUTPUTFILE}

    echo '<p><a href="https://www.sogou.com/web?query='${first}'">'${first}'</a></p><p>' >> ${OUTPUTFILE}
    for second in `cat ${IN2DIR2}| sort| uniq`; do
	echo '<a href="https://www.sogou.com/web?query='${first}+${second}'">'${second}'</a>' >> ${OUTPUTFILE}
    done
    
    echo '</p></div><div>' >> ${OUTPUTFILE}

    echo '<p><a href="https://www.google.co.nz/search?q='${first}'+filetype:html&filter=0&num=50&">'${first}'</a></p><p>' >> ${OUTPUTFILE}
    for second in `cat ${IN2DIR}| sort| uniq`; do
	echo '<a href="https://www.google.co.nz/search?q='${first}+${second}'+filetype:html&filter=0&num=50">'${second}'</a>' >> ${OUTPUTFILE}
    done    

    echo '</p></div><div>' >> ${OUTPUTFILE}

    echo '<p><a href="https://www.yandex.com/search/?text='${first}'">'${first}'</a></p><p>' >> ${OUTPUTFILE}
    for second in `cat ${IN2DIR2}| sort| uniq`; do
	echo '<a href="https://www.yandex.com/search/?text='${first}+${second}'">'${second}'</a>' >> ${OUTPUTFILE}
    done    
    echo '</p></div></body></html>' >> ${OUTPUTFILE}
    
done


#http://www.bing.com/search?q=${1} ${2} ${3}&filter=0&count=50
