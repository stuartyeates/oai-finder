#!/bin/bash

FILES=~/cache*/*

BUILD=./build
OLD=./old-$$/

mv ${BUILD} ${OLD}

mkdir -p ${BUILD}

find ${FILES} -type f -exec cat \{\} \; | tr ' <>"' '\012' | sed 's/http/ http/g'| sed 's/%253A/:/g' | sed 's|%25253A|:|g' | sed 's|%25252F|/|g' | sed 's|%2f|/|g' | sed 's|%252F|/|g' | sed 's|%2F|/|g' | sed 's|%3f|?|g' | sed 's|%3F|?|g' | sed 's|%3D|=|g' | sed 's|%3d|=|g' | sed 's|%3a|:|g' |sed 's|%3A|:|g' | tr " '" '\012' | grep http |sort | uniq > ${BUILD}/raw_urls
wc  ${BUILD}/raw_urls
cat  ${BUILD}/raw_urls | grep -v '\(msn\.com\|bingj\.com\|wikipedia\.org\|\.live\.com\|twitter.com\|google\.com\|google\.co\.nz\|googleusercontent\.com\|\.blogspot\.\|clickserve\.dartsearch\.net\)' | grep -iv '\(\.js$\|\.css$\|\.gif$\|\.jpg$\|\.rss$\|\.atom$\|\.rss2$\)' > ${BUILD}/filtered_urls
wc  ${BUILD}/filtered_urls
cat ${BUILD}/filtered_urls | sed 's|/article/view/.*|/|' | sed 's|/handle/*|/|' | sed 's|/items/show/.*|/|' | sed 's|/exhibits/show/.*|/|' | sed 's|/islandora/object/.*|/islandora/object/|' | sed 's|/browse?.*|/browse?|'  | sed 's|/items/.*|/items/|'  | sed 's|/file/.*|/file/|' | sort | uniq > ${BUILD}/trimmed_urls
wc  ${BUILD}/trimmed_urls

cat  ${BUILD}/trimmed_urls | grep '/index.php' | sed 's|/index.php.*|/index.php|' | sort | uniq > ${BUILD}/ojs_installs
wc ${BUILD}/ojs_installs
#wget --force-directories --input-file=build/ojs_installs --directory-prefix=~/cache-ojs


