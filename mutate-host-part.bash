#!/bin/bash


while read URL
do
    if [ ! -z "${URL}" ]; then
	echo ${URL}
	echo ${URL} | perl -p -e  's!(http|https)://([^/]+)/!protocol=\1 host=\2 !g'
	HOST=`echo ${URL} | perl -p -e  's!(http|https)://([^/]+)/.*!\2!g'`
	echo HOST="${HOST}"
	host "${HOST}"
	if [ "$?" -eq "0" ]; then
	    echo host 
	fi
    fi
done
