#!/bin/bash

# global options
CACHEDIR=./cache
BUILDDIR=./build

##################################################
#USERAGENT string and cookie jat randomisation
##################################################

#various user agents
USERAGENT00="Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+"
USERAGENT01="Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5"
USERAGENT02="Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25"
USERAGENT03="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/537.13+ (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2"
USERAGENT04="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/534.55.3 (KHTML, like Gecko) Version/5.1.3 Safari/534.53.10"
USERAGENT05="Mozilla/5.0 (iPad; CPU OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko ) Version/5.1 Mobile/9B176 Safari/7534.48.3"
USERAGENT06="Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_8; de-at) AppleWebKit/533.21.1 (KHTML, like Gecko) Version/5.0.5 Safari/533.21.1"
USERAGENT07="Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_7; da-dk) AppleWebKit/533.21.1 (KHTML, like Gecko) Version/5.0.5 Safari/533.21.1"
USERAGENT08="Mozilla/5.0 (Linux; U; Android 4.0.3; ko-kr; LG-L160L Build/IML74K) AppleWebkit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"
USERAGENT09="Mozilla/5.0 (Linux; U; Android 4.0.3; de-ch; HTC Sensation Build/IML74K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"
USERAGENT10="Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko"
USERAGENT11="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; ARM; Trident/6.0; Touch)"
USERAGENT12="Mozilla/5.0 (Windows NT 6.2; rv:10.0) Gecko/20100101 Firefox/10.0"
USERAGENT13="Mozilla/5.0 (Windows NT 6.2) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.12 Safari/535.11"
USERAGENT14="Mozilla/5.0 (Windows NT 6.2) AppleWebKit/534.51.22 (KHTML, like Gecko) Version/5.1 Safari/534.50"
USERAGENT15="Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; NOKIA; Lumia 810)"
USERAGENT16="Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch)"
USERAGENT17="Mozilla/5.0 (X11; FreeBSD amd64; rv:5.0) Gecko/20100101 Firefox/5.0"
USERAGENT18=""
USERAGENT19="Opera/12.02 (Android 4.1; Linux; Opera Mobi/ADR-1111101157; U; en-US) Presto/2.9.201 Version/12.02"

COOKIEJAR=

user_agent () {
    NUM1=${RANDOM}
    let "NUM1 %=2"
    NUM2=${RANDOM}
    let "NUM2 %=10"
    FULL="USERAGENT${NUM1}${NUM2}"
    
    USERAGENT="${!FULL}"
    COOKIEJAR="${BUILDDIR}"/cookiejar${NUM1}${NUM2}.cookie

}

test_user_agent () {

    user_agent ;
    echo USERAGENT="${USERAGENT}"
    echo COOKIEJAR="${COOKIEJAR}"
    user_agent ;
    echo USERAGENT="${USERAGENT}"
    echo COOKIEJAR="${COOKIEJAR}"
    user_agent ;
    echo USERAGENT="${USERAGENT}"
    echo COOKIEJAR="${COOKIEJAR}"
    user_agent ;
    echo USERAGENT="${USERAGENT}"
    echo COOKIEJAR="${COOKIEJAR}"

}

#test_user_agent 


google_search () {
    #make sure our cache directory is created
    mkdir -p "${CACHEDIR}/google/"

    if [  "$1" ]
    then
	if [  "$2" ]
	then
	    if [  "$3" ]
	    then
		if [  "$4" ]
		then
		    BASEURL="http://www.google.co.nz/search?q=${1}+${2}+${3}+${4}&filter=0&num=50"
		    CACHEBASE="${CACHEDIR}/google/${1}+${2}+${3}+${4}"
		else
		    BASEURL="http://www.google.co.nz/search?q=${1}+${2}+${3}&filter=0&num=50"
		    CACHEBASE="${CACHEDIR}/google/${1}+${2}+${3}"
		fi
	    else
		BASEURL="http://www.google.co.nz/search?q=${1}+${2}&filter=0&num=50"
		CACHEBASE="${CACHEDIR}/google/${1}+${2}"
	    fi
	else
	    BASEURL="http://www.google.co.nz/search?q=${1}&filter=0&num=50"
	    CACHEBASE="${CACHEDIR}/google/${1}"
	fi
    else
	echo "Error: google_search called without args"
	exit 1;
    fi
    
    echo BASEURL="${BASEURL}"
    echo CACHEBASE="${CACHEBASE}"

    #check to make sure we've not done this one before.
    if [ -f "${CACHEBASE}.0.result" ];
    then
	echo "File "${CACHEBASE}.0.result" exists."
    else
	
	for n in 0 50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 ; do
	    sleep 120
	    echo doing "${BASEURL}" ${n}
	    curl --max-time 30 --dump-header "${CACHEBASE}.${n}.header" --output "${CACHEBASE}.${n}.result" --stderr "${CACHEBASE}.${n}.logging" --referer "http://www.google.com/" --verbose -A "${USERAGENT}" --url "${BASEURL}&start=${n}"
	done;
    fi


}

test_google_search() {

    google_search "\"JOURNAL+CONTENT\"" "\"OPEN+JOURNAL+SYSTEMS\"" 
    google_search "\"JOURNAL+CONTENT\"" "\"OPEN+JOURNAL+SYSTEMS\"" "TEI"

    #google_search 
    
}



#test_google_search

