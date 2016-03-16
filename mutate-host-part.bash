#!/bin/bash
#script to create variants of he host part of the URL

while read URL
do
    if [ ! -z "${URL}" ]; then
	echo ${URL}
	HOST=`echo ${URL} | perl -p -e  's!(http|https)://([^/]+)/.*!\2!g'`
	if [ "$?" -eq "0" ]; then
	    OUTPUT=`host ${HOST}`
	    ADDRESS=`echo ${OUTPUT} | grep 'has address' | sed 's/.* has address \([^ ]*\).*/\1/' | grep -v address| head -1 `
	    if [ ! -z "${ADDRESS}" ]; then
		IPHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${ADDRESS}"'/\3!g'`
		echo $IPHOST
	    fi
	    ADDRESS=`echo ${OUTPUT} | grep 'has address' | sed 's/.* has IPv6 address \([^ ]*\).*/\1/' | grep -v addres| head -1 `
	    if [ ! -z "${ADDRESS}" ]; then
		IPHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${ADDRESS}"'/\3!g'`
		echo $IPHOST
	    fi
	    ADDRESS=`echo ${OUTPUT} | grep 'has address' | sed 's/.* is an alias for \([^ ]*\).*/\1/' | grep -v addres| head -1 `
	    if [ ! -z "${ADDRESS}" ]; then
		ALIASHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${ADDRESS}"'/\3!g'`
		echo $ALIASHOST
	    fi
	fi
	
	OAIHOST=`echo oai.${HOST}`
	echo $OAIHOST
	host ${OAIHOST} 1>&2 > /dev/null
	if [ "$?" -eq "0" ]; then
	    ALIASHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${OAIHOST}"'/\3!g'`
	    echo $ALIASHOST
	fi
	
	OAIHOST=`echo ${HOST} | sed 's/^www.//'`
	echo $OAIHOST
	host ${OAIHOST} 1>&2 > /dev/null
	if [ "$?" -eq "0" ]; then
	    ALIASHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${OAIHOST}"'/\3!g'`
	    echo $ALIASHOST
	fi
	
	OAIHOST=`echo ${HOST} | sed 's/^www./oai./'`
	echo $OAIHOST
	host ${OAIHOST} 1>&2 > /dev/null
	if [ "$?" -eq "0" ]; then
	    ALIASHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${OAIHOST}"'/\3!g'`
	    echo $ALIASHOST
	fi
	
	OAIHOST=`echo ${HOST} | sed 's/^[^\.]\+\.//'`
	echo $OAIHOST
	host ${OAIHOST} 1>&2 > /dev/null
	if [ "$?" -eq "0" ]; then
	    ALIASHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${OAIHOST}"'/\3!g'`
	    echo $ALIASHOST
	fi
	
    fi
done
