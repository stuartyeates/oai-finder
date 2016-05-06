#!/bin/bash

FILES=~/cache*/*

BUILD=./build
OLD=./old-$$/

mv ${BUILD} ${OLD}

mkdir -p ${BUILD}

find ${FILES} -type f -exec cat \{\} \; | tr ' <>"' '\012' | sed 's/http/ http/g'| sed 's/%253A/:/g' | sed 's|%25253A|:|g' | sed 's|%25252F|/|g' | sed 's|%2f|/|g' | sed 's|%252F|/|g' | sed 's|%2F|/|g' | sed 's|%3f|?|g' | sed 's|%3F|?|g' | sed 's|%3D|=|g' | sed 's|%3d|=|g' | sed 's|%3a|:|g' |sed 's|%3A|:|g' | tr " '" '\012' | grep 'http:' |sort | uniq > ${BUILD}/raw_urls
cp ./raw_urls ${BUILD}
wc  ${BUILD}/raw_urls
cat  ${BUILD}/raw_urls | grep -v '\(msn\.com\|bingj\.com\|wikipedia\.org\|\.live\.com\|twitter.com\|google\.com\|google\.co\.nz\|googleusercontent\.com\|\.blogspot\.\|clickserve\.dartsearch\.net\|ebsco\.com\|baiducontent\.com\|doubleclick\|.net\|\.doaj\.org\|.\thomsonreuters\.com\|baidu\.com\|youtube\.com\|www\.worldcat\.org\|jobs\.code4lib\.org\|www\.mail-archive\.com\|libguides\.\|/pipermail/\)' | grep -iv '\(\.js$\|\.css$\|\.gif$\|\.jpg$\|\.rss$\|\.atom$\|\.rss2$\|\.png$\)' > ${BUILD}/filtered_urls
wc  ${BUILD}/filtered_urls
cat ${BUILD}/filtered_urls | sed 's|/article/view/.*|/|' |sed 's|/issue/view/.*|/|' | sed 's|/handle/*|/|' |  sed 's|/exhibits/show/.*|/|' | sed 's|/islandora/object/.*|/islandora/object/|' | sed 's|/browse?.*|/browse?|'  | sed 's|/items/.*|/items/|'  | sed 's|/file/.*|/file/|' | sed 's|search.*||' |sed 's|/[^/]+\.pdf||' | sed 's|/help/.*|/|' | sed 's|/gateway/plugin/.*|/|' | sed 's|/article/.*|/article/|' | sed 's|/\([0-9]\)+/\([0-9]\)+|/|g' |sed 's|/bitstream/.*|/|' | sed 's|/browse.*|/|' | sed 's|/items/|/|' | sed 's|/issue/current|/|'| sed 's|/user/register|/|' | sort | uniq > ${BUILD}/trimmed_urls
wc  ${BUILD}/trimmed_urls

cat  ${BUILD}/trimmed_urls | grep '/index.php' | sed 's|/index.php.*|/index.php|' | sort | uniq > ${BUILD}/ojs_installs
wc ${BUILD}/ojs_installs
#wget --force-directories --input-file=build/ojs_installs --directory-prefix=~/cache-ojs

cat  ${BUILD}/trimmed_urls | shuf |head -1000 | ../oai-union-list/mutate-path-part.bash | sort | uniq > ${BUILD}/expanded
cat  ${BUILD}/trimmed_urls | ../oai-union-list/mutate-path-part.bash | sort | uniq > ./expanded &
wc  ${BUILD}/expanded

cat  ${BUILD}/expanded | shuf > ${BUILD}/shuffled
cat  ${BUILD}/shuffled | head -1000 | tail -100 >  ${BUILD}/shuffled-01
cat  ${BUILD}/shuffled | head -900 | tail -100 >  ${BUILD}/shuffled-02
cat  ${BUILD}/shuffled | head -800 | tail -100 >  ${BUILD}/shuffled-03
cat  ${BUILD}/shuffled | head -700 | tail -100 >  ${BUILD}/shuffled-04
cat  ${BUILD}/shuffled | head -600 | tail -100 >  ${BUILD}/shuffled-05
cat  ${BUILD}/shuffled | head -500 | tail -100 >  ${BUILD}/shuffled-06
cat  ${BUILD}/shuffled | head -400 | tail -100 >  ${BUILD}/shuffled-07
cat  ${BUILD}/shuffled | head -300 | tail -100 >  ${BUILD}/shuffled-08
cat  ${BUILD}/shuffled | head -200 | tail -100 >  ${BUILD}/shuffled-09
cat  ${BUILD}/shuffled | head -100 | tail -100 >  ${BUILD}/shuffled-10





