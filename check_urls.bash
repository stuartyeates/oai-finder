#!/bin/bash

mkdir -p ./logs
mkdir -p ./tmp

while read url
do
    dir=$(mktemp --directory ./tmp/wget-XXXXXXXXX)
    #mkdir -p ${dir}
    
    output=${dir}/output
    log=${dir}/logs
    result=${dir}/result
    success=./logs/successes-$$
    failure=./logs/failures-$$
    
    echo ${url}
    echo ${url} > ${result}
    wget ${url} --output-file=${log} --verbose --output-document=${output} --timeout=10 --tries=3  --no-check-certificate
    RESULT=$?
    echo ${RESULT} >> ${result}

    grep '\(<OAI-PMH\|http://www.openarchives.org/OAI/2.0/\|<baseURL\)' ${output} >> /dev/null
    GREP1=$?
    
    if [ "${GREP1}" -eq "0"  ]
    then
	echo ${url} >> ${success}
	firefox "https://web.archive.org/save/${url}" &
    else
	echo ${url} >> ${failure}
    fi
done
