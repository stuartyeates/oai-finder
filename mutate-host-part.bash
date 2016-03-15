#!/bin/bash


while read URL
do
    if [ ! -z "${URL}" ]; then
	echo PASS ${URL}
	echo ${URL} | perl -p -e  's!(http|https)://([^/]+)/!protocol=\1 host=\2 !g'
	HOST=`echo ${URL} | perl -p -e  's!(http|https)://([^/]+)/.*!\2!g'`
	echo HOST="${HOST}"
	host "${HOST}"
	if [ "$?" -eq "0" ]; then
	    OUTPUT=`host ${HOST}`
	    ADDRESS=`echo ${OUTPUT} | grep 'has address' | sed 's/.* has address \([^ ]*\).*/\1/' | grep -v address| head -1 `
	    if [ ! -z "${ADDRESS}" ]; then
		IPHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${ADDRESS}"'/\3!g'`
		echo PASS $IPHOST
	    fi
	    ADDRESS=`echo ${OUTPUT} | grep 'has address' | sed 's/.* has IPv6 address \([^ ]*\).*/\1/' | grep -v addres| head -1 `
	    if [ ! -z "${ADDRESS}" ]; then
		IPHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${ADDRESS}"'/\3!g'`
		echo PASS $IPHOST
	    fi
	    ADDRESS=`echo ${OUTPUT} | grep 'has address' | sed 's/.* is an alias for \([^ ]*\).*/\1/' | grep -v addres| head -1 `
	    if [ ! -z "${ADDRESS}" ]; then
		IPHOST=`echo ${URL} | perl -p -e 's!(http|https)://([^/]+)/(.*)!\1://'"${ADDRESS}"'/\3!g'`
		echo PASS $IPHOST
	    fi
	fi
    fi
done
