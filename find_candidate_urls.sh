#!/bin/bash

find build*/downloads/ cache*/google/ cache*/bing/ cache*/sogou/ -type f -exec /bin/cat \{\} \;  |  tr '"<>()%, ' '\012' | sed 's/http/\nhttp/' |sed 's/=related:/\n/' | grep '^\(http\|[a-z]+\.[a-z]+/\)' | grep -v 'google.com' | grep -v 'msn.com' | grep -v 'ae.webradar.me' | grep -v 'ameinfo.com' | grep -v 'http://arab.jinbo.net/' | grep -v 'sogou.com' |grep -v 'live.com' | grep -v googleusercontent.com |grep -v google.co.nz  |sort | uniq > build/raw_urls

wc build/raw_urls