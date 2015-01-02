#!/bin/bash
CACHEDIR=./cache
BUILDDIR=./build

GUESSES=${BUILDDIR}/guesses1
GUESSES2=${BUILDDIR}/guesses2
EXPLORE=${BUILDDIR}/explore

if [ -f ./${GUESSES} ]; then
    mv ./${GUESSES} ./${GUESSES}-$(date -d "today" +"%Y%m%d%H%M%s")
fi

if [ -f ./${GUESSES2} ]; then
    mv ./${GUESSES2} ./${GUESSES2}-$(date -d "today" +"%Y%m%d%H%M%s")
fi

if [ -f ./${EXPLORE} ]; then
    mv ./${EXPLORE} ./${EXPLORE}-$(date -d "today" +"%Y%m%d%H%M%s")
fi


for url in `cat ${BUILDDIR}/raw_urls`; do 

    #basic OAI options:
    if [[ $url == *verb\=Identify ]];  
    then
	echo "${url}" >>  ${GUESSES}
    elif [[ $url == */oai ]]; 
    then
	echo "${url}?verb=Identify" >>  ${GUESSES}
	echo "${url}/request?verb=Identify" >>  ${GUESSES}
    fi
    
    # OJS options
    if [[ $url == */oai/request ]]
    then
	echo "${url}?verb=Identify" >>  ${GUESSES}
    elif [[ $url =~ .*/index.php/[^/]+/journal=.* ]]
    then
	echo OJSRAW  ${url} | sed 's|\(/index.php/[^/]*/\)journal=\([^\&]\)|\1?journal=\1\&page=oai?verb=Identify|' 
	echo ${url} | sed 's|\(/index.php/[^/]*/\)journal=\([^\&]\)|\1?journal=\1\&page=oai?verb=Identify|' >>   ${GUESSES}
	echo ${url} | sed 's|\(/index.php/\).*|\1|' >>  ${EXPLORE}
    elif [[ $url =~ .*/index.php/[^/]+/.* ]]
    then
	echo ${url} | sed 's|\(/index.php/[^/]*/\).*|\1oai?verb=Identify|' >>   ${GUESSES}
	echo ${url} | sed 's|\(/index.php/\).*|\1|' >>  ${EXPLORE}
    elif [[ $url =~ .*/[oO][Jj][Ss]/.* ]]
    then
	echo ${url} | sed 's|\(/[oO][Jj][Ss]/\).*|\1|' >>   ${EXPLORE}

    #Greenstone options
    elif [[ $url =~ .*/cgi-bin/.* ]]
    then
	echo ${url}
	echo GSDL ${url} | sed 's|\(.*/cgi-bin\).*|\1/oaiserver.cgi?verb=Identify|'
	echo GSDL ${url} | sed 's|\(.*/cgi-bin\).*|\1/oaiserver?verb=Identify|'
	echo ${url} | sed 's|\(.*/cgi-bin\).*|\1/oaiserver.cgi?verb=Identify|' >>   ${GUESSES}
	echo ${url} | sed 's|\(.*/cgi-bin\).*|\1/oaiserver?verb=Identify|' >>   ${GUESSES}
	
    elif [[ $url =~ .*/gsdl/.* ]]
    then
	echo ${url}
	echo GSDL ${url} | sed 's|\(.*/gsdl\).*|\1/cgi-bin/oaiserver.cgi?verb=Identify|'
	echo GSDL ${url} | sed 's|\(.*/gsdl\).*|\1/cgi-bin/oaiserver?verb=Identify|'
	echo ${url} | sed 's|\(.*/gsdl\).*|\1/cgi-bin/oaiserver.cgi?verb=Identify|' >>   ${GUESSES}
	echo ${url} | sed 's|\(.*/gsdl\).*|\1/cgi-bin/oaiserver?verb=Identify|' >>   ${GUESSES}
	

    #dspace options
    elif [[ $url =~ .*/handle/[0-9]+/[0-9].* ||  $url =~ .*/xmlui.* || $url =~ .*/advanced-search.* || $url =~ .*/community-list.*  || $url =~ .*/jspui.*  || $url =~ .*/browse.* ]]
    then
	echo ${url}
	echo DSPACE ${url} | sed 's@/\(handle\|xmlui\|advanced-search\|community-list\|browse\|jspui\).*@/oai/request?verb=Identify@'
	echo DSPACE ${url} | sed 's@/\(handle\|xmlui\|advanced-search\|community-list\|browse\|jspui\).*@/dspace-oai/request?verb=Identify@'
	echo ${url} | sed 's@/\(handle\|xmlui\|advanced-search\|community-list\|browse\|jspui\).*@/oai/request?verb=Identify@' >>   ${GUESSES}
	echo ${url} | sed 's@/\(handle\|xmlui\|advanced-search\|community-list\|browse\|jspui\).*@/dspace-oai/request?verb=Identify@' >>   ${GUESSES}
	
    #vital options
    elif [[ $url =~ .*/vital/.* ]]
    then
	echo ${url}
	echo VITAL ${url} | sed 's|\(/vital\).*|\1/oai/provider?verb=Identify|'
	echo VITAL ${url} | sed 's|\(/vital\).*|\1/oai/provider?verb=Identify|' >>   ${GUESSES}

    #etd-db options
    elif [[ $url =~ .*/[Ee][Tt][dD]-[Dd][Bb]/.* ]]
    then
	echo ${url}
	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/NDLTD-OAI/oai.pl?verb=Identify|'
	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/ETD-oai/oai.pl?verb=Identify|'
	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/oai/oai.pl?verb=Identify|'
	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/OAI/oai.pl?verb=Identify|'
	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/etddb/oai.pl?verb=Identify|'
	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/ETD-OAI/etddb/oai.pl?verb=Identify|'

	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/NDLTD-OAI/oai.pl?verb=Identify|' >>   ${GUESSES}
	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/ETD-oai/oai.pl?verb=Identify|' >>   ${GUESSES}
	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/oai/oai.pl?verb=Identify|' >>   ${GUESSES}
	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/OAI/oai.pl?verb=Identify|' >>   ${GUESSES}
	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/etddb/oai.pl?verb=Identify|' >>   ${GUESSES}
	echo VITAL ${url} | sed 's|\(/[Ee][Tt][dD]-[Dd][Bb]\).*|\1/ETD-OAI/etddb/oai.pl?verb=Identify|' >>   ${GUESSES}

    else
	echo UNCLAIMED: ${url}
	base=`echo  ${url} | sed 's|/[^/]*$|/|' | sed 's|\?.*||'`
	echo BASE ${base}
	while [[ $base =~ http://[^/]+/.* ]]; do	    
	    echo BASE ${base}
	    echo GUESS ${base} | sed 's|$|?verb=Identify|'
	    echo ${base} | sed 's|$|?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|/?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|oai?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|oai2?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|oai.php?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|oai2.php?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|OAI2.0?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|cgi/oai2?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|perl/oai2?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|OAI?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|servlets/OAIDataProvider?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|oaiprovider?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|provider?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|oai.aspx?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|sobekcm_oai.aspx?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|oai2d.py/?verb=Identify|' >>   ${GUESSES}
	    echo ${base} | sed 's|$|infolib/oai_repository/repository?verb=Identify|' >>   ${GUESSES}

	    newbase=`echo  ${base} | sed 's|/[^/]*/$|/|'`
	    base=$newbase
	done


    #eprints options
    #I'm struggling to find eprint-specific URL patterns
        
   fi

done


cat ${GUESSES} | sort | uniq -c > ${GUESSES2}

wc ${GUESSES} ${GUESSES2}