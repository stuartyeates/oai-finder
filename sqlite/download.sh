#!/bin/bash

source ./issn.sh

BUILD=../build
mkdir -p ${BUILD}

cat ../build/guesses2 | shuf | head -100 > ./guesses

DB=${BUILD}/robotstxt
rm -f ${DB}

sqlite3 ${DB} "create table downloads (key INTEGER PRIMARY KEY, url TEXT, time INTEGER, status INTEGER, page TEXT);"

NOW=`date +%s`
URL="http://www.victoria.ac.nz/robots.txt"
PAGE=$(curl --fail ${URL})
STATUS=$?
sqlite3 ${DB} "insert into downloads (url, time, status, page) values ('${URL//\'/''}', '${NOW}', '${STATUS}', '${PAGE//\'/''}' );"

sqlite3 ${DB} "select * from  downloads;"

# function e {
#     echo $1 
# }  
# e Hello
