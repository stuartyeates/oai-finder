#!/bin/bash
#script to create variants of he host part of the URL

while read URL
do
    if [ ! -z "${URL}" ]; then
	echo ${URL}
	HOST=`echo ${URL} | perl -p -e  's!(http|https)://([^/]+)/.*!\2!g'`

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
done
