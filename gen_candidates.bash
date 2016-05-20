#!/bin/bash

FILES=~/cache*/*

BUILD=./build
OLD=./old-$$/

mv ${BUILD} ${OLD}
mkdir -p ${BUILD}

find ${FILES} -type f -exec cat \{\} \; | tr ' <>()"' '\012' | sed 's/http/ http/g'| sed 's/%253A/:/g' | sed 's|%25253A|:|g' | sed 's|%25252F|/|g' | sed 's|%2f|/|g' | sed 's|%252F|/|g' | sed 's|%2F|/|g' | sed 's|%3f|?|g' | sed 's|%3F|?|g' | sed 's|%3D|=|g' | sed 's|%3d|=|g' | sed 's|%3a|:|g' |sed 's|%3A|:|g' | tr " '" '\012' | grep 'http:' |sort | uniq > ${BUILD}/raw_urls
cp ./raw_urls ${BUILD}
wc  ${BUILD}/raw_urls
cat  ${BUILD}/raw_urls | grep -v '\(msn\.com\|bingj\.com\|wikipedia\.org\|\.live\.com\|twitter.com\|google\.com\|google\.co\.nz\|googleusercontent\.com\|\.blogspot\.\|clickserve\.dartsearch\.net\|ebsco\.com\|baiducontent\.com\|doubleclick\|.net\|\.doaj\.org\|.\thomsonreuters\.com\|baidu\.com\|youtube\.com\|www\.worldcat\.org\|jobs\.code4lib\.org\|www\.mail-archive\.com\|libguides\.\|/pipermail/\|www\.nla\.gov\.au\|pkp\.sfu\.ca\|localhost\|\.about\.com\|127\.0\.0\.1/\|//example\.com/\|googleapis\.com\|www.googleadservices\.com\|google\.de/\|/scholar\.google\.\|googlecode\.com\|bing\.com/\|flagcounter\.com\|ubuntuforums\.org\|stackoverflow\.com\|wholinkstome\.com\|academia\.edu\|http://earthengine\.google\.org/\|/pc\.tantin\.jp/tamori/\|mirror\.swem\.wm\.edu\|mydomain\.com\|http://myhost/\|http://my.ojs/\|puj-portal\.javeriana\.edu\.co\|crossref\.org/\|imagemagick\.org/\|http://go\.microsoft\.com\|http://goo\.gl/\|alle-domeinnamen\.xyz/\|/redir\.php\|/wp-content/\|archive\.org\|http://dromosfm\.alfanews\.com\.cy/\|http://answers\.microsoft\.com/\|rssing\.com/\|http://.*readthedocs\.org/\|http://politube\.upv\.es/\|sport-widgets\.snd\.no\|http://www\.albertalakehomes\.ca/\|http://www\.dtic\.mil/\|http://www\.ebay\.\|http://www\.nzdl\.org/\|www\.pantarhei\.ba\|http://zoot\.li/\|http://www\.hermpac\.co\.nz/\|http://osdir\.com\|alibaba\.com/\|http://trac\.\|http://www.dafiti.cl/\|http://www\.emeraldinsight\.com/\|http://www\.google\.\|http://archive-org-2013\.com/\|http://archive-it\.org/\|http://archive\.apache\.org/\|http://archive\.li/\)' | grep -iv '\(\.js$\|\.css$\|\.gif$\|\.jpg$\|\.rss$\|\.atom$\|\.rss2$\|\.png$\)' > ${BUILD}/filtered_urls
wc  ${BUILD}/filtered_urls
cat ${BUILD}/filtered_urls | sed 's|/article/view/.*|/|' |sed 's|/issue/view/.*|/|' | sed 's|/handle/.*|/|' |  sed 's|/exhibits/show/.*|/|' | sed 's|/islandora/object/.*|/islandora/object/|' | sed 's|/browse?.*|/browse?|'  | sed 's|/items/.*||'  | sed 's|/file/.*|/file/|' | sed 's|search.*||' |sed 's|/[^/]+\.pdf||' | sed 's|/help/.*|/|' | sed 's|/gateway/plugin/.*|/|' | sed 's|/article/.*|/article/|' | sed 's|/\([0-9]\)*/\([0-9]\).*|/|g' | sed 's|/\([0-9]\)*/$|/|g' |sed 's|/bitstream/.*|/|' | sed 's|/browse.*|/|' | sed 's|/items/.*|/|' | sed 's|/issue/current.*|/|'| sed 's|/user/register.*|/|' | sed 's|/pages/view/.*|/|'| sed 's|/submission/.*|/|'| sed 's|/user/setLocale/.*|/|'| sed 's|/themes/.*|/|'| sed 's|/[^/]*\.pdf|/|'| sed 's|/[^/]*\.css|/|' | sed 's|/view/author/.*|/|' | sed 's|/cdm/.*|/cdm/|' | sed 's|/results.php.*|/|' | sed 's|/login/.*|/|' | sed 's|/utils/ajaxhelper/.*|/|' | sed 's|/ui/custom/default/collection/.*|/|' | sed 's|/view/.*|/view/|' |sed 's|/library.cgi.*|/library.cgi|' | sed 's|/item/.*|/item/|' | sed 's|/node/.*|/node/|' | sed 's|/cgi-bin/library.*|/cgi-bin/library|' | sed 's|/utils/getstaticcontent/.*|/|' | sed 's|/cdmcustom/.*|/cdmcustom/|' | sed 's|/about/.*|/|'| sed 's|/vital/access/manager/.*|/vital/access/manager/|' | sed 's|/phpdoc/.*|/|' | sed 's|/forums/.*|/|' | sed 's|/CollectionViewPage.external.*|/|' | sed 's|VODID=.*||' | sed 's|.$||' | sort | uniq > ${BUILD}/trimmed_urls
wc  ${BUILD}/trimmed_urls

cat  ${BUILD}/trimmed_urls | grep '/index.php' | sed 's|/index.php.*|/index.php|' | sort | uniq > ${BUILD}/ojs_installs
wc ${BUILD}/ojs_installs
#wget --force-directories --input-file=build/ojs_installs --directory-prefix=~/cache-ojs
#wget --force-directories --input-file=build/ojs_installs --directory-prefix=./cache-ojs2 --tries=3 --timeout=10

cat  ${BUILD}/trimmed_urls | grep contentdm.oclc.org/ |sed  's|$|/oai/oai.php?verb=Identify|' > ${BUILD}/contentdm_candidate_urls

cat  ${BUILD}/trimmed_urls | grep -v contentdm.oclc.org/ | shuf |head -1000 | ../oai-union-list/mutate-path-part.bash | sort | uniq >> ${BUILD}/expanded
(cat  ${BUILD}/trimmed_urls | grep -v contentdm.oclc.org/ | ../oai-union-list/mutate-path-part.bash | sort | uniq > ${BUILD}/normal_candidate_urls; cp ${BUILD}/normal_candidate_urls ./expanded) &

cat logs/successes-* logs/* | sort | uniq > ${BUILD}/tried_urls
comm -13 ${BUILD}/tried_urls ./expanded > ${BUILD}/untried_urls

cat  ${BUILD}/untried_urls | shuf > ${BUILD}/shuffled


cat  ${BUILD}/shuffled | head -100000 | tail -10000 >  ${BUILD}/shuffled-01
cat  ${BUILD}/shuffled | head -90000 | tail -10000 >  ${BUILD}/shuffled-02
cat  ${BUILD}/shuffled | head -80000 | tail -10000 >  ${BUILD}/shuffled-03
cat  ${BUILD}/shuffled | head -70000 | tail -10000 >  ${BUILD}/shuffled-04
cat  ${BUILD}/shuffled | head -60000 | tail -10000 >  ${BUILD}/shuffled-05
cat  ${BUILD}/shuffled | head -50000 | tail -10000 >  ${BUILD}/shuffled-06
cat  ${BUILD}/shuffled | head -40000 | tail -10000 >  ${BUILD}/shuffled-07
cat  ${BUILD}/shuffled | head -30000 | tail -10000 >  ${BUILD}/shuffled-08
cat  ${BUILD}/shuffled | head -20000 | tail -10000 >  ${BUILD}/shuffled-09
cat  ${BUILD}/shuffled | head -10000 | tail -10000 >  ${BUILD}/shuffled-10

cat ${BUILD}/contentdm_candidate_urls | shuf   >  ${BUILD}/shuffled-cdm

wc  ${BUILD}/*

for file in ${BUILD}/shuffled-*; do
    (./check_urls.bash < $file &);
done

# Wait for all parallel jobs to finish
while [ 1 ]; do fg 2> /dev/null; [ $? == 1 ] && break; done





