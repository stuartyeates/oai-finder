#!/bin/bash


CACHE_DIR=./cache-dir/oai-registery/
mkdir -p ${CACHE_DIR}

OPENDOARJSONFILE=${CACHE_DIR}/oai-registry.html

function oai-registry () {
 
    curl -X GET "https://www.openarchives.org/Register/BrowseSites"

}


oai-registry;
