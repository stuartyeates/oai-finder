#!/bin/bash

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

#takes an eight digit number and returns 0 if the checksum confirms it
#as a valid ISSN returns zero on validity
function checksum_is_valid {
    #do some basic data normalisation
    N=`echo $1 | tr 'x' 'X' | tr -cd '0-9X'`
    #calculate the sum
    SUM=`expr \( ${N:6:1} \* 2 \) +    \
              \( ${N:5:1} \* 3 \) +    \
              \( ${N:4:1} \* 4 \) +    \
              \( ${N:3:1} \* 5 \) +    \
              \( ${N:2:1} \* 6 \) +    \
              \( ${N:1:1} \* 7 \) +    \
              \( ${N:0:1} \* 8 \) `
    #calculate the modulus
    MOD=`expr  11 - \( ${SUM} % 11 \)`
    #handle the X case
    if [ "${MOD}" = "10" ] 
    then
	MOD="X"
    fi
    #echo  $N $SUM $MOD  ${N:7:1}
    #return the result
    return `expr ${MOD} != ${N:7:1} `
    
}           


CALC_ISSN_CHECKSUM_BAD_ISSN=XXXXXXXX
CALC_ISSN_CHECKSUM_RESULT=
function calc_issn_checksum {
    #do some basic data normalisation
    N=`echo $1 | tr 'x' 'X' | tr -cd '0-9X'`
    #calculate the sum
    SUM=`expr \( ${N:6:1} \* 2 \) +    \
              \( ${N:5:1} \* 3 \) +    \
              \( ${N:4:1} \* 4 \) +    \
              \( ${N:3:1} \* 5 \) +    \
              \( ${N:2:1} \* 6 \) +    \
              \( ${N:1:1} \* 7 \) +    \
              \( ${N:0:1} \* 8 \) `
    #calculate the modulus
    MOD=`expr  11 - \( ${SUM} % 11 \)`
    #handle the X case
    if [ "${MOD}" = "10" ] 
    then
	MOD="X"
    fi
    CALC_ISSN_CHECKSUM_RESULT="${N}${MOD}"
    return 0
}

echo 
echo valid ISSNs:
checksum_is_valid 0378-5955
echo $? 0378-5955

checksum_is_valid 14485052
echo $? 14485052

checksum_is_valid 2327-770X
echo $? 2327-770X
checksum_is_valid 2327770X
echo $? 2327770X

checksum_is_valid 1996918X
echo $? 1996918X
checksum_is_valid 1996-918X
echo $? 1996-918X

echo 
echo invalid ISSNs:
checksum_is_valid 14485051
echo $? 14485051

checksum_is_valid 14485053
echo $? 14485053

checksum_is_valid 1448505X
echo $? 1448505X

