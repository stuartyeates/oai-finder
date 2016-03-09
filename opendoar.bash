#!/bin/bash


CACHE_DIR=./cache-dir/opendoar/
mkdir -p ${CACHE_DIR}

OPENDOARXMLFILE=${CACHE_DIR}/opendoar.xml
OPENDOARCSVFILE=${CACHE_DIR}/opendoar.csv

function opendoar () {
    #echo doing "${OPENDOARXMLFILE}"
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

PAIRSFILE=${CACHE_DIR}/pairs.csv


function find_rep_oai_pairs (){
  awk -F, '{if ( $2) { print $1, $2} }' <  ${OPENDOARCSVFILE} > ${PAIRSFILE}
}

function match_with_sed () {
    

    OLDIFS=$IFS
    IFS=' ' 

    while read rep oai 
    do
	G1=$(echo "$rep" | sed 's|$|cgi/oai2|');
	G2=$(echo "$rep" | sed 's|$|oai|');
	G3=$(echo "$rep" | sed 's|$|oai/request|');
	G4=$(echo "$rep" | sed 's|xmlui$|oai/request|');
	G5=$(echo "$rep" | sed 's|dspace/$|dspace-oai/request|');
	G6=$(echo "$rep" | sed 's|$|oai/driver|');
	G7=$(echo "$rep" | sed 's|$|do/oai/|');
	G8=$(echo "$rep" | sed 's|$|fedora/oai|');
	G9=$(echo "$rep" | sed 's|$|/oai-pmh-repository.xml|');
	
	case $oai in
	    $G1)
		((G1count++))
		;;
	    $G2)
		((G2count++))
		;;
	    $G3)
		((G3count++))
		;;
	    $G4)
		((G4count++))
		;;
	    $G5)
		((G5count++))
		;;
	    $G6)
		((G6count++))
		;;
	    $G7)
		((G7count++))
		;;
	    $G8)
		((G8count++))
		;;
	    $G9)
		((G9count++))
		;;
	    *)	
		echo $rep, $oai, $G1, $G2, $G3
		((G0count++))
 		;;
	esac
       
    done < ${PAIRSFILE}
    IFS=$OLDIFS
    echo $G1count, $G2count, $G3count, $G4count, $G5count, $G6count, $G7count, $G8count, $G9count, $G0count
    }

opendoar;
find_rep_oai_pairs;
match_with_sed;
