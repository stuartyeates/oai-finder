#!/bin/bash

RAW=build/raw_urls

if [ -f ./${RAW} ]; then
    mv ./${RAW} ./${RAW}-$(date -d "today" +"%Y%m%d%H%M%s")
fi

find build*/downloads/ build*/ojs cache*/google/ cache*/bing/ cache*/sogou/ -type f -exec /bin/cat \{\} \;  |  tr '"<>()%, ' '\012' | tr "'" '\012' | sed 's/http/\nhttp/' |sed 's/=related:/\n/' | grep '^\(http\|[a-z]+\.[a-z]+/\)' | grep -Ev 'google.com|msn.com|ae.webradar.me|ameinfo.com|arab.jinbo.net|sogou.com|live.com|googleusercontent.com|google.co.nz'  |sort | uniq > $RAW

wc $RAW