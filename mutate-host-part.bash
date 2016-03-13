#!/bin/bash


while read URL
do
    if [ ! -z "${URL}" ]; then
	echo $URL
	echo $URL | perl -p -e  's!(http|https)://([^/]+)/!protocol=\1 host=\2 !g'
	
	
    fi
done
