#!/bin/bash
#script to create variants of he host part of the URL

while read URL
do
    if [ ! -z "${URL}" ]; then
	echo ${URL}
	HOST=`echo ${URL} | perl -p -e  's!(http|https)://([^/]+)/.*!\2!g'`

	OAIHOST=`echo oai.${HOST}`
	host ${OAIHOST} 1>&2 > /dev/null
	if [ "$?" -eq "0" ]; then
	    ALIASHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${OAIHOST}"'/\3!g'`
	    echo $ALIASHOST
	fi
	
	OAIHOST=`echo ${HOST} | sed 's/^www.//'`
	host ${OAIHOST} 1>&2 > /dev/null
	if [ "$?" -eq "0" ]; then
	    ALIASHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${OAIHOST}"'/\3!g'`
	    echo $ALIASHOST
	fi
	
	OAIHOST=`echo ${HOST} | sed 's/^www./oai./'`
	host ${OAIHOST} 1>&2 > /dev/null
	if [ "$?" -eq "0" ]; then
	    ALIASHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${OAIHOST}"'/\3!g'`
	    echo $ALIASHOST
	fi
	
	OAIHOST=`echo ${HOST} | sed 's/^[^\.]\+\.//'`
	host ${OAIHOST} 1>&2 > /dev/null
	if [ "$?" -eq "0" ]; then
	    ALIASHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${OAIHOST}"'/\3!g'`
	    echo $ALIASHOST
	fi

	#special for openrepository.org hosted sites
	ALIASHOST=`echo ${URL} | sed 's|http://\([^\.]*\)\.\([^/]*\)/.*|http://\1.\2/\1/oai/request|'`
	echo $ALIASHOST
		
    fi
done
