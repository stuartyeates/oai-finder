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

while getopts ":sSr:d:" opt; do
    case $opt in
	e)
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

user_agent_and_cookie_jar;

echo ${RANDOM}
echo $USERAGENT
echo ${RANDOM}
echo ${COOKIEJAR}




