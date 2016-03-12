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
	G4=$(echo "$rep" | sed 's|[^/]*$|oai/request|');
	G5=$(echo "$rep" | sed 's|/$|-oai/request|');
	G6=$(echo "$rep" | sed 's|$|oai/driver|');
	G7=$(echo "$rep" | sed 's|$|do/oai/|');
	G8=$(echo "$rep" | sed 's|$|fedora/oai|');
	G9=$(echo "$rep" | sed 's|$|oai-pmh-repository.xml|');
	G10=$(echo "$rep" | sed 's|$|oai2d|');
	G11=$(echo "$rep" | sed 's|$|oai2.oai2.php|');
	G12=$(echo "$rep" | sed 's|$|oaicat/|');
	G13=$(echo "$rep" | sed 's|[^/]*/[^/]*$|oai/request|');
	G14=$(echo "$rep" | sed 's|$|do/oai|');
	G15=$(echo "$rep" | sed 's|$|dspace-oai/request|');
	G16=$(echo "$rep" | sed 's|$|oai2|');
	G17=$(echo "$rep" | sed 's|$|oai/oai.php|');
	G18=$(echo "$rep" | sed 's|$|oai/oai2.php|');
	G19=$(echo "$rep" | sed 's|$|oai/|');
	G20=$(echo "$rep" | sed 's|$|cgi-bin/oai.exe|');
	G21=$(echo "$rep" | sed 's|$|opac/mmd_api/oai-pmh/|');
	G22=$(echo "$rep" | sed 's|$|ws/oai|');
	G23=$(echo "$rep" | sed 's|$|greenstone/cgi-bin/oaiserver.cgi|');
	G24=$(echo "$rep" | sed 's|$|phpoai/oai2.php|');
	G25=$(echo "$rep" | sed 's|$|oai/scielo-oai.php|');
	G26=$(echo "$rep" | sed 's|$|oaiextended/request|');
	G27=$(echo "$rep" | sed 's|$|ir-oai/request|');
	G28=$(echo "$rep" | sed 's|$|sobekcm_oai.aspx|');
	G29=$(echo "$rep" | sed 's|$|casirgrid-oai/request|');

	
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
	    $G10)
		((G10count++))
		;;
	    $G11)
		((G11count++))
		;;
	    $G12)
		((G12count++))
		;;
	    $G13)
		((G13count++))
		;;
	    $G14)
		((G14count++))
		;;
	    $G15)
		((G15count++))
		;;
	    $G16)
		((G16count++))
		;;
	    $G17)
		((G18count++))
		;;
	    $G18)
		((G18count++))
		;;
	    $G19)
		((G19count++))
		;;
	    $G20)
		((G20count++))
		;;
	    $G21)
		((G21count++))
		;;
	    $G22)
		((G22count++))
		;;
	    $G23)
		((G23count++))
		;;
	    $G24)
		((G24count++))
		;;
	    $G25)
		((G25count++))
		;;
	    $G26)
		((G26count++))
		;;
	    $G27)
		((G27count++))
		;;
	    $G28)
		((G28count++))
		;;
	    $G29)
		((G29count++))
		;;
	    *)	
		echo \"$rep\", \"$oai\"
		((G0count++))
 		;;
	esac
       
    done < ${PAIRSFILE}
    IFS=$OLDIFS
    echo $G1count, $G2count, $G3count, $G4count, $G5count, $G6count, $G7count, $G8count, $G9count, $G10count,  $G11count, $G12count, $G13count, $G14count, $G15count, $G16count, $G17count, $G18count, $G19count, $G20count  $G21count, $G22count, $G23count, $G24count, $G25count, $G26count, $G27count, $G28count, $G29count, $G0count
    }

opendoar;
find_rep_oai_pairs;
match_with_sed;
