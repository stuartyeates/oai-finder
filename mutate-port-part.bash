#!/bin/bash
#script to create variants of he host part of the URL

while read URL
do
    if [ ! -z "${URL}" ]; then
	echo ${URL}
	echo ${URL} | perl -p -e  's!(http|https)://([^/]+):?([0-9]*)?/(.*)!protocol=\1 host=\2 port=\3 rest=\4!g'
	HOST=`echo ${URL} | perl -p -e  's!(http|https)://([^/]+):?([0-9]*)?/(.*)!\2!g'`
	REST=`echo ${URL} | perl -p -e  's!(http|https)://([^/]+):?([0-9]*)?/(.*)!\4!g'`
	echo https://${HOST}:443/${REST}
	echo https://${HOST}:8443/${REST}
	echo http://${HOST}:80/${REST}
	echo http://${HOST}:8080/${REST}
	echo http://${HOST}:8081/${REST}
	echo http://${HOST}:8082/${REST}
	echo http://${HOST}:8084/${REST}
	echo http://${HOST}:8085/${REST}
	echo http://${HOST}:8888/${REST}
	
    fi
done
