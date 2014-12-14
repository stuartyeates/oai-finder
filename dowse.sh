#!/bin/bash
CACHEDIR=./cache
BUILDDIR=./build

GUESSES=${BUILDDIR}/round1
EXPLORE=${BUILDDIR}/explore

rm ${GUESSES} ${EXPLORE}

#cat downloads/*/* | tr ' "' '\012' |tr "'()<>" '\012' | grep // | grep '^http'| grep -v google | sort | uniq > ./raw.urls


for url in `cat ${BUILDDIR}/raw_urls`; do 

    if [[ $url == *verb\=Identify ]]
    then
	echo "${url}" >>  ${GUESSES}
    fi

    if [[ $url == */oai ]]
    then
	echo "${url}?verb=Identify" >>  ${GUESSES}
	echo "${url}/request?verb=Identify" >>  ${GUESSES}
    fi

    if [[ $url == */oai/request ]]
    then
	echo "${url}?verb=Identify" >>  ${GUESSES}
    fi

    if [[ $url =~ .*/index.php/[^/]+/journal=.* ]]
    then
	echo OJSRAW  ${url} | sed 's|\(/index.php/[^/]*/\)journal=\([^\&]\)|\1?journal=\1\&page=oai?verb=Identify|' 
	echo ${url} | sed 's|\(/index.php/[^/]*/\)journal=\([^\&]\)|\1?journal=\1\&page=oai?verb=Identify|' >>   ${GUESSES}
	echo ${url} | sed 's|\(/index.php/\).*|\1|' >>  ${EXPLORE}
    else
    if [[ $url =~ .*/index.php/[^/]+/.* ]]
    then
	echo ${url} | sed 's|\(/index.php/[^/]*/\).*|\1oai?verb=Identify|' >>   ${GUESSES}
	echo ${url} | sed 's|\(/index.php/\).*|\1|' >>  ${EXPLORE}
    else
	if [[ $url =~ .*/[oO][Jj][Ss]/.* ]]
	then
	    echo ${url} | sed 's|\(/[oO][Jj][Ss]/\).*|\1|' >>   ${EXPLORE}
	    echo ${url} | sed 's|\(/[oO][Jj][Ss]\).*|\1|' >>   ${GUESSES}
	else 
	    if [[ $url =~ .*/cgi-bin/.* ]]
	    then
		echo ${url}
		echo GSDL ${url} | sed 's|\(.*/cgi-bin\).*|\1/oaiserver.cgi?verb=Identify|'
		echo ${url} | sed 's|\(.*/cgi-bin\).*|\1/oaiserver.cgi?verb=Identify|' >>   ${GUESSES}
		
	    else 
		if [[ $url =~ .*/handle/[0-9]+/[0-9].* ||  $url =~ .*/xmlui.* || $url =~ .*/advanced-search.* || $url =~ .*/community-list.*  || $url =~ .*/jspui.*  || $url =~ .*/browse.* ]]
		then
		    echo ${url}
		    echo DSPACE ${url} | sed 's@/\(handle\|xmlui\|advanced-search\|community-list\|browse\|jspui\).*@/oai/request?verb=Identify@'
		    echo DSPACE ${url} | sed 's@/\(handle\|xmlui\|advanced-search\|community-list\|browse\|jspui\).*@/dspace-oai/request?verb=Identify@' >>   ${GUESSES}
		    echo ${url} | sed 's@/\(handle\|xmlui\|advanced-search\|community-list\|browse\|jspui\).*@/oai/request?verb=Identify@' >>   ${GUESSES}
		    echo ${url} | sed 's@/\(handle\|xmlui\|advanced-search\|community-list\|browse\|jspui\).*@/dspace-oai/request?verb=Identify@' >>   ${GUESSES}
		    
		    
		else 
		    if [[ $url =~ .*/[oO][Jj][Ss].* ]]
		    then
			echo ${url} | sed 's|\(/[oO][Jj][Ss]\).*|\1|' >>   ${GUESSES}
		    else
			echo ${url}
		    fi
		    
		fi
		
	    fi
	    fi
	    
	fi
    fi
    
    
done
