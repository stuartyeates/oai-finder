#!/bin/bash

mkdir -p ./logs
mkdir -p ./tmp

while read url
do
    if [ -n "${url}" ] ;
    then
	dir2=$(mktemp --directory ./tmp/tmp-XXXX)
	dir1=$(mktemp --directory ${dir2}/XXXX)
	dir=$(mktemp --directory ${dir1}/XXXX)
	#    mkdir -p ${dir}
	
	output=${dir}/output
	log=${dir}/logs
	result=${dir}/result
	success=./logs/successes-$$
	error=./logs/errors-$$
	failure=./logs/failures-$$
    
	echo ${url}
	echo ${url} > ${result}
	wget ${url} --output-file=${log} --verbose --output-document=${output} --timeout=10 --tries=3  --no-check-certificate
	RESULT=$?
	echo ${RESULT} >> ${result}
	
	grep '\(<OAI-PMH\|http://www.openarchives.org/OAI/2.0/\|<baseURL\)' ${output} >> /dev/null
	GREP1=$?
	
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
    fi
	
done
