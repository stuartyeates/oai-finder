
#!/bin/bash

# global options
export CACHEDIR=./cache
export BUILDDIR=./build
INTERSEARCHPAUSE=1600
INTRASEARCHPAUSE=60

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

USERAGENT=
COOKIEJAR=

#assign a random user agent and associated cookie jar
user_agent () {
    NUM1=${RANDOM}
    let "NUM1 %=2"
    NUM2=${RANDOM}
    let "NUM2 %=10"
    FULL="USERAGENT${NUM1}${NUM2}"
    
    USERAGENT="${!FULL}"
    COOKIEJAR="${BUILDDIR}"/cookiejar${NUM1}${NUM2}.${1}.cookie

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

#perform a google search with 1-4 argument strings
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
    
    user_agent "google"
#    echo searching "${BASEURL}"

    #check to make sure we've not done this one before.
    if [ -f "${CACHEBASE}.0.result" ];
    then
	echo "File "${CACHEBASE}.0.result" exists."
    else
	for n in 0 50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 ; do
	    sleep $INTRASEARCHPAUSE
	    echo doing "${BASEURL}" ${n}
	    curl --max-time 30  --cookie-jar "${COOKIEJAR}.google" --dump-header "${CACHEBASE}.${n}.header" --output "${CACHEBASE}.${n}.result" --stderr "${CACHEBASE}.${n}.logging" --referer "http://www.google.com/" --verbose -A "${USERAGENT}" --url "${BASEURL}&start=${n}"
	done;
    fi
}

test_google_search() {

    google_search "\"JOURNAL+CONTENT\"" "\"OPEN+JOURNAL+SYSTEMS\"" 
    google_search "\"JOURNAL+CONTENT\"" "\"OPEN+JOURNAL+SYSTEMS\"" "TEI"

    #google_search 
    
}

#test_google_search

bing_search () {
    #make sure our cache directory is created
    mkdir -p "${CACHEDIR}/bing/"

    if [  "$1" ]
    then
	if [  "$2" ]
	then
	    if [  "$3" ]
	    then
		if [  "$4" ]
		then
		    BASEURL="http://www.bing.com/search?q=${1} ${2} ${3} ${4}&filter=0&count=50"
		    CACHEBASE="${CACHEDIR}/bing/${1}+${2}+${3}+${4}"
		else
		    BASEURL="http://www.bing.com/search?q=${1} ${2} ${3}&filter=0&count=50"
		    CACHEBASE="${CACHEDIR}/bing/${1}+${2}+${3}"
		fi
	    else
		BASEURL="http://www.bing.com/search?q=${1} ${2}&filter=0&count=50"
		CACHEBASE="${CACHEDIR}/bing/${1}+${2}"
	    fi
	else
	    BASEURL="http://www.bing.com/search?q=${1}&filter=0&count=50"
	    CACHEBASE="${CACHEDIR}/bing/${1}"
	fi
    else
	echo "Error: bing_search called without args"
	exit 1;
    fi
 
    user_agent "bing"
#    echo searching "${BASEURL}"

    #check to make sure we've not done this one before.
    if [ -f "${CACHEBASE}.1.result" ];
    then
	echo "File "${CACHEBASE}.1.result" exists."
    else
	for n in 1 51 101 151 201 251 301 351 401 451 501 551 601 651 701 751 801 851 901 951 ; do
	    sleep $INTRASEARCHPAUSE
	    echo doing "${BASEURL}" ${n}
	    curl --max-time 30  --cookie-jar "${COOKIEJAR}.bing" --dump-header "${CACHEBASE}.${n}.header" --output "${CACHEBASE}.${n}.result" --stderr "${CACHEBASE}.${n}.logging" --referer "http://www.bing.com/" --verbose -A "${USERAGENT}" --url "${BASEURL}&first=${n}"
	done;
    fi
}


sogou_search () {
    #make sure our cache directory is created
    mkdir -p "${CACHEDIR}/sogou/"

    if [  "$1" ]
    then
	if [  "$2" ]
	then
	    if [  "$3" ]
	    then
		if [  "$4" ]
		then
		    BASEURL="http://www.sogou.com/search?q=${1} ${2} ${3} ${4}"
		    CACHEBASE="${CACHEDIR}/sogou/${1}+${2}+${3}+${4}"
		else
		    BASEURL="http://www.sogou.com/search?q=${1} ${2} ${3}"
		    CACHEBASE="${CACHEDIR}/sogou/${1}+${2}+${3}"
		fi
	    else
		BASEURL="http://www.sogou.com/search?q=${1} ${2}"
		CACHEBASE="${CACHEDIR}/sogou/${1}+${2}"
	    fi
	else
	    BASEURL="http://www.sogou.com/search?q=${1}"
	    CACHEBASE="${CACHEDIR}/sogou/${1}"
	fi
    else
	echo "Error: sogou_search called without args"
	exit 1;
    fi
    
    user_agent "sogou"
#    echo searching "${BASEURL}"

    #check to make sure we've not done this one before.
    if [ -f "${CACHEBASE}.1.result" ];
    then
	echo "File "${CACHEBASE}.1.result" exists."
    else
	for n in 1 2 3 4 5 6 7 8 9  ; do
	    sleep $INTRASEARCHPAUSE
	    echo doing "${BASEURL}" ${n}
	    curl --max-time 30  --cookie-jar "${COOKIEJAR}.sogou" --dump-header "${CACHEBASE}.${n}.header" --output "${CACHEBASE}.${n}.result" --stderr "${CACHEBASE}.${n}.logging" --referer "http://www.sogou.com/" --verbose -A "${USERAGENT}" --url "${BASEURL}&page=${n}"
	done;
    fi
}


download_seeds() {
#create a list of all domains, so that we can search them separately
    if [ ! -f "${CACHEDIR}/all-domains" ]; then
	curl http://data.iana.org/TLD/tlds-alpha-by-domain.txt --output  "${CACHEDIR}/all-domains"
	cat "${CACHEDIR}/all-domains" | tr 'A-Z' 'a-z' | grep -v \# > "${CACHEDIR}/all-domains-normalised"	
    fi
    
    if [ ! -f "${CACHEDIR}/en-subjects-wordlist" ]; then
	curl "http://en.wikipedia.org/wiki/Outline_of_academic_disciplines"  --output "${CACHEDIR}/en-subjects"
	cat "${CACHEDIR}/en-subjects" | sed 's|<[^>]*>||g' |tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '....' >  "${CACHEDIR}/en-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/fr-subjects-wordlist" ]; then
	curl "http://fr.wikipedia.org/wiki/Liste_des_disciplines_scientifiques"  --output "${CACHEDIR}/fr-subjects"
	cat "${CACHEDIR}/fr-subjects" | sed 's|<[^>]*>||g' |tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012'| tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '....' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist" >  "${CACHEDIR}/fr-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/ar-subjects-wordlist" ]; then
	curl "http://ar.wikipedia.org/wiki/%D9%85%D9%84%D8%AD%D9%82:%D9%82%D8%A7%D8%A6%D9%85%D8%A9_%D8%A7%D9%84%D8%AA%D8%AE%D8%B5%D8%B5%D8%A7%D8%AA_%D8%A7%D9%84%D8%A3%D9%83%D8%A7%D8%AF%D9%8A%D9%85%D9%8A%D8%A9"  --output "${CACHEDIR}/ar-subjects"
	cat "${CACHEDIR}/ar-subjects" | sed 's|<[^>]*>||g' |tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' |tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '....' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist">  "${CACHEDIR}/ar-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/ja-subjects-wordlist" ]; then
	curl "http://ja.wikipedia.org/wiki/%E5%AD%A6%E5%95%8F%E3%81%AE%E4%B8%80%E8%A6%A7"  --output "${CACHEDIR}/ja-subjects"
	cat "${CACHEDIR}/ja-subjects" | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist">  "${CACHEDIR}/ja-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/zh-subjects-wordlist" ]; then
	curl "http://zh.wikipedia.org/wiki/%E5%AD%B8%E7%A7%91%E5%88%97%E8%A1%A8"  --output "${CACHEDIR}/zh-subjects"
	cat "${CACHEDIR}/zh-subjects" | sed 's|<script>[^<]*</script>||g' | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist">  "${CACHEDIR}/zh-subjects-wordlist"
    fi

#    if [ ! -f "${CACHEDIR}/ko-subjects-wordlist" ]; then
#	curl "http://ko.wikipedia.org/wiki/%ED%95%99%EB%AC%B8_%EB%B6%84%EC%95%BC_%EB%AA%A9%EB%A1%9D"  --output "${CACHEDIR}/ko-subjects"
#	cat "${CACHEDIR}/ko-subjects" | tr '\012' ' ' | sed 's|<script>[^<]*</script>||g' | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' >  "${CACHEDIR}/ko-subjects-wordlist"
#    fi


    if [ ! -f "${CACHEDIR}/pt-subjects-wordlist" ]; then
	curl "http://pt.wikipedia.org/wiki/Lista_de_disciplinas_acad%C3%AAmicas"  --output "${CACHEDIR}/pt-subjects"
	cat "${CACHEDIR}/pt-subjects" | tr '\012' ' ' | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist" >  "${CACHEDIR}/pt-subjects-wordlist"
    fi


    if [ ! -f "${CACHEDIR}/hi-subjects-wordlist" ]; then
	curl "http://hi.wikipedia.org/wiki/%E0%A4%B6%E0%A5%88%E0%A4%95%E0%A5%8D%E0%A4%B7%E0%A4%A3%E0%A4%BF%E0%A4%95_%E0%A4%B5%E0%A4%BF%E0%A4%B7%E0%A4%AF%E0%A5%8B%E0%A4%82_%E0%A4%95%E0%A5%80_%E0%A4%B8%E0%A5%82%E0%A4%9A%E0%A5%80"  --output "${CACHEDIR}/hi-subjects"
	cat "${CACHEDIR}/hi-subjects" | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist" >  "${CACHEDIR}/hi-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/tl-subjects-wordlist" ]; then
	curl "http://tl.wikipedia.org/wiki/Talaan_ng_mga_disiplinang_pang-akademiya"  --output "${CACHEDIR}/tl-subjects"
	cat "${CACHEDIR}/tl-subjects" | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist" >  "${CACHEDIR}/tl-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/th-subjects-wordlist" ]; then
	curl "http://th.wikipedia.org/wiki/%E0%B8%A3%E0%B8%B2%E0%B8%A2%E0%B8%8A%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B8%AA%E0%B8%B2%E0%B8%82%E0%B8%B2%E0%B8%A7%E0%B8%B4%E0%B8%8A%E0%B8%B2"  --output "${CACHEDIR}/th-subjects"
	cat "${CACHEDIR}/th-subjects" | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist" >  "${CACHEDIR}/th-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/es-subjects-wordlist" ]; then
	curl "http://es.wikipedia.org/wiki/Anexo:Disciplinas_acad%C3%A9micas"  --output "${CACHEDIR}/es-subjects"
	cat "${CACHEDIR}/es-subjects" | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist" >  "${CACHEDIR}/es-subjects-wordlist"
    fi

}

search_for_urls () {

    for url in `cat urls.utf| sort | uniq`; do 
	(bing_search "${url}" &)
	(google_search "${url}" &)
	(sogou_search  "${url}" &)

	for word in `cat ${CACHEDIR}/*-subjects-wordlist| sort | uniq| shuf | tail -10`; do 
	    sleep $INTERSEARCHPAUSE
	    (bing_search "${url}" "${word}" &)	
	    (google_search "${url}" "${word}" &)			
	    (sogou_search  "${url}" "${word}" &)
	done
    done
}


search_for_oai () {

    for url in `cat oai-terms.utf8| sort | uniq`; do 
	(bing_search "${url}" &)
	(google_search "${url}" &)
	(sogou_search  "${url}" &)

	for word in `cat ${CACHEDIR}/*-subjects-wordlist| sort | uniq| shuf | tail -20`; do 
	    sleep $INTERSEARCHPAUSE
	    (bing_search "${url}" "${word}" &)	
	    (google_search "${url}" "${word}" &)			
	    (sogou_search  "${url}" "${word}" &)
	done
    done
}


search_for_software () {

    for url in `cat ojs-terms.*.utf8 islandora-terms.*.utf8 etd-db-terms.*.utf8 vital-terms.*.utf8 dspace-terms.*.utf8 eprints-terms.*.utf8| sort | uniq`; do 
	(bing_search "${url}" &)
	(google_search "${url}" &)
	(sogou_search  "${url}" &)

	for word in `cat ${CACHEDIR}/*-subjects-wordlist| sort | uniq| shuf | tail -20`; do 
	    sleep $INTERSEARCHPAUSE
	    (bing_search "${url}" "${word}" &)	
	    (google_search "${url}" "${word}" &)			
	    (sogou_search  "${url}" "${word}" &)
	done
    done
}

download_seeds

(search_for_urls&)
sleep $INTRASEARCHPAUSE
(search_for_oai &)
sleep $INTRASEARCHPAUSE
(search_for_software &)