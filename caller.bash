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
    echo rundir not set
    mkdir -p $DATADIR/runs/
    RUNDIR=`mktemp -d ${DATADIR}/runs/run.XXXXXXX` || die "cannot create RUNDIR in ${DATADIR}"
fi

echo DATADIR=$DATADIR
echo RUNDIR=$RUNDIR



CACHEDIR=${DATADIR}/cache

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

#user_agent_and_cookie_jar;

engine_google2 () {
    #make sure our cache directory is created
    mkdir -p "${CACHEDIR}/google/"
    
    if [  "$FIRST" ]
    then
	if [  "$SECOND" ]
	then
	    if [  "$THIRD" ]
	    then
		BASEURL="http://www.google.co.nz/search?q=${1}+${2}+${3}&filter=0&num=50"
		CACHEBASE="${CACHEDIR}/google/${1}+${2}+${3}"
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

 seed_files () {
     echo "seed files;"
     }

 
 search_by_field () {
     echo "searching by field ";
 }

 search_by_software () {
     echo "searching by software";
 }

 search_from_url () {
     echo "searching from url";
 }
 
  search_from_previous () {
      echo "searching from prevoious";
 }

main() {
    case "${ALGO}" in
        SEED) seed_files
              ;;
        FIELD_SEARCH) search_by_field
	      ;;
        SOFTWARE_SEARCH) search_by_software
	      ;;
        URL_SEARCH) search_from_url
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
 
