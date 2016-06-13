#!/bin/bash

mkdir -p ./logs
mkdir -p ./tmp

while read url
do
    if [ -n "${url}" ] ;
    then
	dir=$(mktemp --directory /tmp/tmp-XXXXXXXXXXXXXXXX)
		
	output=${dir}/output
	log=${dir}/logs
	result=${dir}/result
	success=./logs/successes-$$
	error=./logs/errors-$$
	failure=./logs/failures-$$
	moreurls=./logs/urls-$$
    
	echo ${url}
	echo ${url} > ${result}
	wget ${url} --output-file=${log} --verbose --output-document=${output} --timeout=40 --tries=1  --no-check-certificate --user-agent="oai-finder https://github.com/stuartyeates/oai-finder"
	RESULT=$?
	echo ${RESULT} >> ${result}
	
	grep -i '\(<OAI-PMH\|http://www.openarchives.org/OAI/2.0/\|<baseURL\)' ${output} >> /dev/null
	GREP1=$?

	cat ${output} | tr ' <>()"\000\r\n' '\012' | tr " '" '\012' | grep '^\(https:\|http:\)//[-A-Z0-9a-z]*.[-A-Z0-9a-z.]*/' | sort | uniq >> ${moreurls}
	
	if [ "${RESULT}" -eq "4"  ]
	then
		echo ${url} >> ${error}	    
	else
	    if [ "${GREP1}" -eq "0"  ]
	    then
		echo ${url} >> ${success}
		#firefox "https://web.archive.org/save/${url}" &
	    else
		echo ${url} >> ${failure}
	    fi
	fi
	rm -rf ${dir}
    fi	
done
