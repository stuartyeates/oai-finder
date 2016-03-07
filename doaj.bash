#!/bin/bash


CACHE_DIR=./cache-dir/opendoaj/
mkdir -p ${CACHE_DIR}

OPENDOARJSONFILE=${CACHE_DIR}/opendoaj.xml

function doaj () {
    END=200
    
    for count in $(seq 1 $END); do

	sleep 2
	echo $i;
	curl -X GET --header "Accept: application/json" "https://doaj.org/api/v1/search/journals/http?page=${count}&pageSize=100" --output "${OPENDOARJSONFILE}.${count}"
	if [ $? -ne 0 ]
	then
	    break;
	fi	
    done
   
}


doaj;
