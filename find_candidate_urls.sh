#!/bin/bash

find build*/downloads/ cache/google/ cache/bing/ cache/sogou/ -type f -exec /bin/cat \{\} \; |  tr '"<>()%,; ' '\012' | sed 's/http/\nhttp/' | grep http | grep -v 'google' | uniq | sort | uniq > build/raw_urls