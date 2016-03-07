#!/bin/bash


CACHE_DIR=./cache-dir/opendoar/
mkdir -p ${CACHE_DIR}

OPENDOARXMLFILE=${CACHE_DIR}/opendoar.xml
OPENDOARCSVFILE=${CACHE_DIR}/opendoar.csv

function opendoar () {
    echo doing "${OPENDOARXMLFILE}"
    # make sure we have the xml file
    if [ ! -f "${OPENDOARXMLFILE}" ]; then
	 curl --max-time 300 --output "${OPENDOARXMLFILE}"  --referer "http://www.google.com/" --stderr "${CACHE_DIR}/main.log" --verbose  --url "http://opendoar.org/api13.php?all=y"
    fi

    #convert the XML file to a CSV, with just the URLs plus the repositry name
    xsltproc ./opendoar.xsl cache-dir/opendoar/opendoar.xml > ${OPENDOARCSVFILE}
    
    #split the lines into feeds and hints

    #first nuke the old ones
    rm -f ${CACHE_DIR}/probably_oai_feeds ${CACHE_DIR}/oai_feed_hints ${CACHE_DIR}/oai_feed_domains
    
    OLDIFS=$IFS
    IFS=,

    while read rUrl rOaiBaseUrl oUrl 
    do
	if [ ! -z "${rOaiBaseUrl}" ]; then
	    echo "${rOaiBaseUrl}" >> ${CACHE_DIR}/probable_oai_feeds
	else
	    if [ ! -z "${rUrl}" ]; then
		echo "${rUrl}" >> ${CACHE_DIR}/oai_feed_hints
	    else
		if [ ! -z "${oUrl}" ]; then
		    echo "${oUrl}" >> ${CACHE_DIR}/oai_feed_domains
		fi
	    fi
	fi
    done < ${OPENDOARCSVFILE}
    IFS=$OLDIFS
}


opendoar;
