#!/bin/bash

find build*/downloads/ cache*/google/ cache*/bing/ cache*/sogou/ -type f -exec /bin/cat \{\} \;  |  tr '"<>()%, ' '\012' | sed 's/http/\nhttp/' |sed 's/=related:/\n/' | grep '^\(http\|[a-z]+\.[a-z]+/\)' | grep -Ev 'google.com|msn.com|ae.webradar.me|ameinfo.com|arab.jinbo.net|sogou.com|live.com|googleusercontent.com|google.co.nz'  |sort | uniq > build/raw_urls

wc build/raw_urls