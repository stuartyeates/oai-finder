#!/bin/bash
#script to create variants of the port part of the URL

while read URL
do
    if [ ! -z "${URL}" ]; then
	while [[ "${URL}" =~  ^https?://[a-z0-9.]*/  ]]
	do
	    echo ${URL}
	    if [[ "${URL}" =~  /$  ]]; then
		echo ${URL} | sed 's|$|cgi/oai2|'
	    fi
	    URL=`echo $URL | sed 's![^/]*.$!!'`



	    
	done
		
    fi
done
