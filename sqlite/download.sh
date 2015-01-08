#!/bin/bash

source ./issn.sh

BUILD=./build
mkdir -p ${BUILD}

GUESSES=./guesses
cat ../build/guesses2 | shuf | head -3 | grep -v '^VITAL' > ${GUESSES}

DB=${BUILD}/robotstxt

MAX_FILE_LENGTH=50000

if [ ! -e "${DB}" ]; 
then
    sqlite3 ${DB} "create table downloads (key INTEGER PRIMARY KEY, url TEXT, time INTEGER, status INTEGER, page TEXT);" 
fi

NOW=`date +%s%N`
URL="http://www.victoria.ac.nz/robots.txt"
PAGE=$(curl --fail --max-time 20 ${URL})
STATUS=$?
sqlite3 ${DB} "insert into downloads (url, time, status, page) values ('${URL//\'/''}', '${NOW}', '${STATUS}', '${PAGE//\'/''}' );"
sqlite3 ${DB} "select time, status, url from  downloads;"
sqlite3 ${DB} "delete  from downloads where url = '${URL}';"


for URL in `cat ${GUESSES} | sort | uniq | shuf`; do
    echo ${URL}
    PAGE=$(curl --fail ${URL})
    STATUS=$?
    PAGE2=`echo ${PAGE} |cut -c 1-${MAX_FILE_LENGTH}`
    sqlite3 ${DB} "insert into downloads (url, time, status, page) values ('${URL//\'/''}', '${NOW}', '${STATUS}', '${PAGE2//\'/''}' );"
done
