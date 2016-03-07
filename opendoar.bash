#!/bin/bash


CACHE_DIR=./cache-dir/opendoar/
mkdir -p ${CACHE_DIR}

OPENDOARXMLFILE=${CACHE_DIR}/opendoar.xml

function opendoar () {
    echo doing "${OPENDOARXMLFILE}"
    # make sure we have the xml file
    if [ ! -f "${OPENDOARXMLFILE}" ]; then
	 curl --max-time 300 --output "${OPENDOARXMLFILE}"  --referer "http://www.google.com/" --stderr "${CACHE_DIR}/main.log" --verbose  --url "http://opendoar.org/api13.php?all=y"
    fi

    #convert the XML file to a CSV, with just the URLs plus the repositry name
    xsltproc ./opendoar.xsl cache-dir/opendoar/opendoar.xml 
    }


opendoar;
