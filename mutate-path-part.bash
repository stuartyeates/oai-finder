#!/bin/bash
#script to create variants of the port part of the URL

while read URL
do
    if [ ! -z "${URL}" ]; then
	echo ${URL}

	while [[ "${URL}" =~ "://[^/]+/" ]]
	do
	    URL=`echo $URL | sed 's!/.*!!'`
	    echo ** ${URL}
	done
		
    fi
done
