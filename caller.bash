#!/bin/bash

DAEMONNAME="oaifinder"

PREFIX=$PWD/oaifinder-files/
DATADIR=${PREFIX}/var/lib/${DAEMONNAME}
RUNDIR=""
SEEDONLY=""
SINGLE=""

FIRST=""
SECOND=""
THIRD=""

ENGINE=""
ALGO="DEFAULT"


while getopts "a:e:1:2:3:r:d:f:" opt; do
    case $opt in
	a)
	    ALGO=$OPTARG
	    echo ALGO=$ALGO
	    ;;
	e)
	    ENGINE=$OPTARG
	    ;;
	1)
	    FIRST=$OPTARG
	    ;;
	2)
	    SECOND=$OPTARG
	    ;;
	3)
	    THIRD=$OPTARG
	    ;;
	s)
	    SINGLE="TRUE"
	    ;;
	S)
	    SEEDONLY="TRUE"
	    ;;
	r)
	    RUNDIR=$OPTARG
	    ;;
	d)
	    DATADIR=$OPTARG
	    ;;
	\?)
	    echo "Invalid option: -$OPTARG" >&2
	    exit 1
	    ;;
	:)
	    echo "Option -$OPTARG requires an argument." >&2
	    exit 1
	    ;;
    esac
done

if [[ "" == $RUNDIR ]] ; then
    mkdir -p $DATADIR/runs/
    RUNDIR=`mktemp -d ${DATADIR}/runs/run.XXXXXXXXXXXXXXXX` || die "cannot create RUNDIR in ${DATADIR}"
fi

CACHEDIR=${DATADIR}/cache
mkdir -p ${CACHEDIR}

echo DATADIR=${DATADIR}
echo RUNDIR=${RUNDIR}
echo CACHEDIR=${CACHEDIR}


#create USERAGENT string and a cookiejar for this run.
USERAGENT=
COOKIEJAR=

#create a cookie jar
user_agent_and_cookie_jar () {
    NUM1=${RANDOM}
    let "NUM1 %=2"
    NUM2=${RANDOM}
    let "NUM2 %=10"
    FULL="USERAGENT${NUM1}${NUM2}"
    
    USERAGENT="`shuf USERAGENTS | head -1`"
    COOKIEJAR="${BUILDDIR}"/cookiejar${RANDOM}.$$.cookie

}


INTRASEARCHPAUSE=40

engine_google () {
    #make sure our cache directory is created
    mkdir -p "${CACHEDIR}/google/"

    # create a persona
    user_agent_and_cookie_jar

    if [  "$FIRST" ]
    then
	if [  "$SECOND" ]
	then
	    if [  "$THIRD" ]
	    then
		BASEURL="https://www.google.co.nz/search?q=${1}+${2}+${3}&filter=0&num=50"
		CACHEBASE="${CACHEDIR}/google/${1}+${2}+${3}"
	    else
		BASEURL="https://www.google.co.nz/search?q=${1}+${2}&filter=0&num=50"
		CACHEBASE="${CACHEDIR}/google/${1}+${2}"
	    fi
	else
	    BASEURL="https://www.google.co.nz/search?q=${1}&filter=0&num=50"
	    CACHEBASE="${CACHEDIR}/google/${1}"
	fi
    else
	echo "Error: google_search called without args"
	exit 1;
    fi

    #check to make sure we've not done this one before.
    if [ -f "${CACHEBASE}.0.result" ];
    then	echo "File "${CACHEBASE}.0.result" exists."
    else
	for n in 0 50 ; do
	#for n in 0 50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 ; do
	    sleep $INTRASEARCHPAUSE
	    echo doing "${BASEURL}" ${n}
	    curl --max-time 30  --cookie-jar "${COOKIEJAR}.google" --dump-header "${CACHEBASE}.${n}.header" --output "${CACHEBASE}.${n}.result" --stderr "${CACHEBASE}.${n}.logging" --referer "http://www.google.com/" --verbose -A "${USERAGENT}" --url "${BASEURL}&start=${n}"
	done;
    fi
    
}

engine_bing () {
    #make sure our cache directory is created
    mkdir -p "${CACHEDIR}/bing/"

    # create a persona
    user_agent_and_cookie_jar

    if [  "$1" ]
    then
	if [  "$2" ]
	then
	    if [  "$3" ]
	    then
		BASEURL="http://www.bing.com/search?q=${1} ${2} ${3}&filter=0&count=50"
		CACHEBASE="${CACHEDIR}/bing/${1}+${2}+${3}"
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
    
    
    #check to make sure we've not done this one before.
    if [ -f "${CACHEBASE}.1.result" ];
    then
	echo "File "${CACHEBASE}.1.result" exists."
    else
	#for n in 1 51 101 151 201 251 301 351 401 451 501 551 601 651 701 751 801 851 901 951 ; do
	for n in 1 51
	    sleep $INTRASEARCHPAUSE
	    echo doing "${BASEURL}" ${n}
	    curl --max-time 30  --cookie-jar "${COOKIEJAR}.bing" --dump-header "${CACHEBASE}.${n}.header" --output "${CACHEBASE}.${n}.result" --stderr "${CACHEBASE}.${n}.logging" --referer "http://www.bing.com/" --verbose -A "${USERAGENT}" --url "${BASEURL}&first=${n}"
	done;
    fi
}


engine_sogou () {
    #make sure our cache directory is created
    mkdir -p "${CACHEDIR}/sogou/"

    # create a persona
    user_agent_and_cookie_jar

    if [  "$1" ]
    then
	if [  "$2" ]
	then
	    if [  "$3" ]
	    then
		BASEURL="http://www.sogou.com/search?q=${1} ${2} ${3}"
		CACHEBASE="${CACHEDIR}/sogou/${1}+${2}+${3}"
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
    
    #check to make sure we've not done this one before.
    if [ -f "${CACHEBASE}.1.result" ];
    then
	echo "File "${CACHEBASE}.1.result" exists."
    else
	for n in 1 2 ; do
	#for n in 1 2 3 4 5 6 7 8 9  ; do
	    sleep $INTRASEARCHPAUSE
	    echo doing "${BASEURL}" ${n}
	    curl --max-time 30  --cookie-jar "${COOKIEJAR}.sogou" --dump-header "${CACHEBASE}.${n}.header" --output "${CACHEBASE}.${n}.result" --stderr "${CACHEBASE
}.${n}.logging" --referer "http://www.sogou.com/" --verbose -A "${USERAGENT}" --url "${BASEURL}&page=${n}"
	done;
    fi
}



seed_files () {
     echo "seeding files;"

     #create a list of all domains, so that we can search them separately
    if [ ! -f "${CACHEDIR}/all-domains" ]; then
	curl http://data.iana.org/TLD/tlds-alpha-by-domain.txt --output  "${CACHEDIR}/all-domains"
	cat "${CACHEDIR}/all-domains" | tr 'A-Z' 'a-z' | grep -v \# > "${CACHEDIR}/all-domains-normalised"	
    fi
    
    if [ ! -f "${CACHEDIR}/en-subjects-wordlist" ]; then
	curl "https://en.wikipedia.org/wiki/Outline_of_academic_disciplines"  --output "${CACHEDIR}/en-subjects"
	cat "${CACHEDIR}/en-subjects" | sed 's|<[^>]*>||g' |tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '....' >  "${CACHEDIR}/en-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/fr-subjects-wordlist" ]; then
	curl "https://fr.wikipedia.org/wiki/Liste_des_disciplines_scientifiques"  --output "${CACHEDIR}/fr-subjects"
	cat "${CACHEDIR}/fr-subjects" | sed 's|<[^>]*>||g' |tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012'| tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '....' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist" >  "${CACHEDIR}/fr-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/ar-subjects-wordlist" ]; then
	curl "https://ar.wikipedia.org/wiki/%D9%85%D9%84%D8%AD%D9%82:%D9%82%D8%A7%D8%A6%D9%85%D8%A9_%D8%A7%D9%84%D8%AA%D8%AE%D8%B5%D8%B5%D8%A7%D8%AA_%D8%A7%D9%84%D8%A3%D9%83%D8%A7%D8%AF%D9%8A%D9%85%D9%8A%D8%A9"  --output "${CACHEDIR}/ar-subjects"
	cat "${CACHEDIR}/ar-subjects" | sed 's|<[^>]*>||g' |tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' |tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '....' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist">  "${CACHEDIR}/ar-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/ja-subjects-wordlist" ]; then
	curl "https://ja.wikipedia.org/wiki/%E5%AD%A6%E5%95%8F%E3%81%AE%E4%B8%80%E8%A6%A7"  --output "${CACHEDIR}/ja-subjects"
	cat "${CACHEDIR}/ja-subjects" | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist">  "${CACHEDIR}/ja-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/zh-subjects-wordlist" ]; then
	curl "https://zh.wikipedia.org/wiki/%E5%AD%B8%E7%A7%91%E5%88%97%E8%A1%A8"  --output "${CACHEDIR}/zh-subjects"
	cat "${CACHEDIR}/zh-subjects" | sed 's|<script>[^<]*</script>||g' | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist">  "${CACHEDIR}/zh-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/pt-subjects-wordlist" ]; then
	curl "https://pt.wikipedia.org/wiki/Lista_de_disciplinas_acad%C3%AAmicas"  --output "${CACHEDIR}/pt-subjects"
	cat "${CACHEDIR}/pt-subjects" | tr '\012' ' ' | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist" >  "${CACHEDIR}/pt-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/tl-subjects-wordlist" ]; then
	curl "https://tl.wikipedia.org/wiki/Talaan_ng_mga_disiplinang_pang-akademiya"  --output "${CACHEDIR}/tl-subjects"
	cat "${CACHEDIR}/tl-subjects" | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist" >  "${CACHEDIR}/tl-subjects-wordlist"
    fi

    if [ ! -f "${CACHEDIR}/es-subjects-wordlist" ]; then
	curl "https://es.wikipedia.org/wiki/Anexo:Disciplinas_acad%C3%A9micas"  --output "${CACHEDIR}/es-subjects"
	cat "${CACHEDIR}/es-subjects" | sed 's|<[^>]*>||g' | tr '[:punct:][:space:][:digit:][:cntrl:]' '\012' | tr ' -"()\[\],.?!:\t|^<>/*;$\\{}' '\012' | tr "'" "\012" |  tr 'A-Z' 'a-z' |  sort | uniq | grep -v '[0-9]' | grep '..' | grep -F -x -v -f "${CACHEDIR}/en-subjects-wordlist" >  "${CACHEDIR}/es-subjects-wordlist"
    fi
    
 }
 
 
 search_by_field () {
     echo "searching by field ";
 }
 
PERTURB1=2
PERTURB2=2
INTRAPAUSE=6600

 search_by_software () {
     echo "searching by software";
     for FIRST1 in `cat search-terms/ojs-terms.*.utf8 search-terms/islandora-terms.*.utf8 search-terms/etd-db-terms.*.utf8 search-terms/vital-terms.*.utf8 search-terms/dspace-terms.*.utf8 search-terms/eprints-terms.*.utf8 search-terms/greenstone-terms.*.utf8| sort | uniq| shuf`; do
	 echo $FIRST1
	 FIRST=${FIRST1}
	 (engine_google ${FIRST}&)
	 (engine_bing ${FIRST}&)
	 (engine_sogou ${FIRST}&)
	 
	for SECOND2 in `cat ${CACHEDIR}/*-subjects-wordlist| sort | uniq| shuf | tail  -${PERTURB1}`; do 
	    sleep $INTRAPAUSE
	    echo $FIRST1 -- $SECOND2
	    SECOND=${SECOND2}
	    (engine_google ${FIRST} ${SECOND} &)
	    (engine_bing ${FIRST} ${SECOND}&)
	    (engine_sogou ${FIRST} ${SECOND}&) 

	    for THIRD3 in `cat ${CACHEDIR}/*-subjects-wordlist| sort | uniq| shuf | tail  -${PERTURB2}`; do 
	    sleep $INTRAPAUSE
	    THIRD=${THIRD3}
	    echo $FIRST1 -- $SECOND2 -- ${THIRD3}

	    (engine_google ${FIRST} ${SECOND} ${THIRD} &)
	    (engine_bing ${FIRST} ${SECOND} ${THIRD} &)
	    (engine_sogou ${FIRST} ${SECOND} ${THIRD} &) 

	    done
	done
     done
     
 }

 search_from_url () {
     echo "searching from url";
 }
 
  search_from_previous () {
      echo "searching from prevoious";
 }

  main() {
      user_agent_and_cookie_jar
      seed_files

      case "${ALGO}" in
          FIELD_SEARCH) search_by_field
			;;
          SOFTWARE_SEARCH) search_by_software
			   ;;
          URL_SEARCH) search_from_url
		      ;;
	  SPECIAL_SEARCHES) search_reverse
			;;
	  MIRROR_SPECIALS) mirror
			   ;;
          EXTEND) search_from_previous
		  ;;
	DEFAULT) search_by_software
		 ;;
        *) exit 1;
	   ;;
      esac
      exit 0;
  }

main
 
