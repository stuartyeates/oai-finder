#!/bin/bash


BUILD=./build
OLD=./old-$$/

mv ${BUILD} ${OLD}
mkdir -p ${BUILD}

touch ${BUILD}/starting

for dir in ~/cache* ./cache*; do
    find ${dir} -type f -exec cat \{\} \;
done | tr ' <>()"\000\r\n' '\012' | tr " '" '\012' | grep '^\(https:\|http:\)//[-A-Z0-9a-z]*.[-A-Z0-9a-z.]*/' | grep -v '/?[A-Z][^/=]*$' |sort | uniq > ${BUILD}/raw_urls

wc  ${BUILD}/raw_urls

cat  ${BUILD}/raw_urls | grep -a -v '\(msn\.com\|bingj\.com\|wikipedia\.org\|\.live\.com\|twitter.com\|google\.com\|google\.co\.nz\|googleusercontent\.com\|\.blogspot\.\|clickserve\.dartsearch\.net\|ebsco\.com\|baiducontent\.com\|doubleclick\|.net\|\.doaj\.org\|.\thomsonreuters\.com\|baidu\.com\|youtube\.com\|www\.worldcat\.org\|jobs\.code4lib\.org\|www\.mail-archive\.com\|libguides\.\|/pipermail/\|www\.nla\.gov\.au\|pkp\.sfu\.ca\|localhost\|\.about\.com\|127\.0\.0\.1/\|//example\.com/\|googleapis\.com\|www.googleadservices\.com\|google\.de/\|/scholar\.google\.\|googlecode\.com\|bing\.com/\|flagcounter\.com\|ubuntuforums\.org\|stackoverflow\.com\|wholinkstome\.com\|academia\.edu\|http://earthengine\.google\.org/\|/pc\.tantin\.jp/tamori/\|mirror\.swem\.wm\.edu\|mydomain\.com\|http://myhost/\|http://my.ojs/\|puj-portal\.javeriana\.edu\.co\|crossref\.org/\|imagemagick\.org/\|http://go\.microsoft\.com\|http://goo\.gl/\|alle-domeinnamen\.xyz/\|/redir\.php\|/wp-content/\|archive\.org\|http://dromosfm\.alfanews\.com\.cy/\|http://answers\.microsoft\.com/\|rssing\.com/\|http://.*readthedocs\.org/\|http://politube\.upv\.es/\|sport-widgets\.snd\.no\|http://www\.albertalakehomes\.ca/\|http://www\.dtic\.mil/\|http://www\.ebay\.\|http://www\.nzdl\.org/\|www\.pantarhei\.ba\|http://zoot\.li/\|http://www\.hermpac\.co\.nz/\|http://osdir\.com\|alibaba\.com/\|http://trac\.\|http://www.dafiti.cl/\|http://www\.emeraldinsight\.com/\|http://www\.google\.\|http://archive-org-2013\.com/\|http://archive-it\.org/\|http://archive\.apache\.org/\|http://archive\.li/\|webofknowledge\.com/\|/archive\.is/\|/atmire\.com/\|/citeseerx\.ist\.psu\.edu/\|/doaj\.org/\|\.nabble\.com/\|microsofttranslator\.com\|http://atlantisonline\.smfforfree2\.com/\|basilicasanclemente\.com/\|//blog\.\|//blogs\.\|//boardnation\.com/\|/boards\.straightdope\.com/\|/chmod666\.org/\|/clubsearay\.com/\|/imgur\.com/\|/hal\.archives-ouvertes\.fr/\|github\.com\|moodkick\.ning\.com\|wiki\.duraspace\.org\|www\.facebook\.com\|www\.linkedin\.com\|www\.pinterest\.com\|www\.super\.kg\|www\.ana\.rs\|/www\.wpi\.edu/\|phpforum\.su\|issuu\.com\|www\.rootschat\.com\|joomlaforum\.ru\|www\.ffhockey\.org\|www.ppsystems.com\|www.frontierleague.com\|gist.github.com\|linuxforums.org.uk\|ww.preceptministries.ca\|msdn.microsoft.com\|joomlaforum.kz\|forums.modx.com\|forums.malwarebytes.org\|forum.pfsense.org\|www.avforums.co.za\|forum.avast.com\|http://forums\.\|http://forum\.\|//booking\.\|ad\.itweb\.co\.za\|allmusic\.com/\|beverageindustrynews.com.ng\|be-zet.ning.com\|blagodiynist.com.ua\|/brokencontrollers.com/\|/ebookinga.com/\/fisherpub.sjfc.edu/\|/hal-emse.ccsd.cnrs.fr/\|/ha.shsps.kh.edu.tw/\|/hcmc.uvic.ca\|/hfboards.hockeysfuture.com/\|/hub.hku.hk/\|scholar.lib.vt.edu\|www.howtobuildsoftware.com\|www.intechopen.com\|rcin.org.pl\|www.applyabroad.org\|www.oclc.org\|wiki.lib.sun.ac.za\|www.lastminutetraining.ca\|hankstruckforum.com\|bitcointalk.org\|www.bcgcertification.org\|www.littlepriest.edu\|www.steadishots.org\|www.yesnany.com\|oaklandparkboulevardtransitstudy.com\|cialis.alcohol.interaction.viagrawithoutadoctorprescription.top\|www.wow.com/\|/adultoffline.com/\|/www.audio-forums.com/\|/www.hotporno.tv/\|/waitrose.pornblink.com/\|/broker39.ru/\|https://secure.gravatar.com/\|nordstromimage\.com/\|nordstrom\.com/\|\.scribd\.com/\|\.scribdassets\.com\|/itunes.apple.com/\|/plus.google.com/\|\.stackexchange\.com\|\.wordpress\.com/\)' > ${BUILD}/filtered_urls

wc  ${BUILD}/filtered_urls

cat ${BUILD}/filtered_urls | sed 's|/article/view/.*|/|' |sed 's|/issue/view/.*|/|' | sed 's|/handle/.*|/|' |  sed 's|/exhibits/show/.*|/|' | sed 's|/islandora/object/.*|/islandora/object/|' | sed 's|/browse?.*|/browse?|'  | sed 's|/items/.*||'  | sed 's|/file/.*|/file/|' | sed 's|search.*||'  | sed 's|/help/.*|/|' | sed 's|/gateway/plugin/.*|/|' | sed 's|/article/.*|/article/|' | sed 's|/\([0-9]\)*/\([0-9]\).*|/|g' | sed 's|/\([0-9]\)*/$|/|g' |sed 's|/bitstream/.*|/|' | sed 's|/browse.*|/|' | sed 's|/items/.*|/|' | sed 's|/issue/current.*|/|'| sed 's|/user/register.*|/|' | sed 's|/pages/view/.*|/|'| sed 's|/submission/.*|/|'| sed 's|/user/setLocale/.*|/|'| sed 's|/themes/.*|/|'| sed 's!/[^/]*\(\.js$\|\.css$\|\.gif$\|\.jpg$\|\.rss$\|\.atom$\|\.rss2$\|\.png$\|\.pdf\)!/!'| sed 's|/[^/]*\.css|/|' | sed 's|/view/author/.*|/|' | sed 's|/cdm/.*|/cdm/|' | sed 's|/results.php.*|/|' | sed 's|/login/.*|/|' | sed 's|/utils/ajaxhelper/.*|/|' | sed 's|/ui/custom/default/collection/.*|/|' | sed 's|/view/.*|/view/|' |sed 's|/library.cgi.*|/library.cgi|' | sed 's|/item/.*|/item/|' | sed 's|/node/.*|/node/|' | sed 's|/cgi-bin/library.*|/cgi-bin/library|' | sed 's|/utils/getstaticcontent/.*|/|' | sed 's|/cdmcustom/.*|/cdmcustom/|' | sed 's|/about/.*|/|'| sed 's|/vital/access/manager/.*|/vital/access/manager/|' | sed 's|/phpdoc/.*|/|' | sed 's|/forums/.*|/|' | sed 's|/CollectionViewPage.external.*|/|' | sed 's|VODID=.*||' | sed 's|\?verb=.*||' | sed 's|\.$||' | sed 's|/datastream/.*|/|' |  sed 's|/lib/pkp/|/|' | sed 's|/[0-9]*$|/|' | sed 's|/js/.*|/|' | sed 's|/plugins/.*|/|' | sed 's|/wp-.*|/|' |  sed 's|/dlibra.*|/dlibra|' | sed 's|/ETD-db/.*|/ETD-db/|' | sed 's|/etd-[-0-9/]*$||'|  sort | uniq > ${BUILD}/trimmed_urls

wc  ${BUILD}/trimmed_urls

cat  ${BUILD}/trimmed_urls | grep -a '/index.php' | sed 's|/index.php.*|/index.php|' | sort | uniq > ${BUILD}/ojs_installs
wc ${BUILD}/ojs_installs
#wget --force-directories --input-file=build/ojs_installs --directory-prefix=./cache-ojs4 --tries=1 --timeout=20

cat  ${BUILD}/trimmed_urls | grep -a contentdm.oclc.org/ |sed  's|$|/oai/oai.php?verb=Identify|' > ${BUILD}/contentdm_candidate_urls

cat  ${BUILD}/trimmed_urls |  ../oai-union-list/mutate-path-part.bash | sort | uniq >> ${BUILD}/expanded

#cat  ${BUILD}/trimmed_urls |  ../oai-union-list/mutate-path-part.bash | sort | uniq > ${BUILD}/normal_candidate_urls
#cp ${BUILD}/normal_candidate_urls ./expanded

cat logs*/succ* logs*/fail* logs*/error*  | sort | uniq > ${BUILD}/tried_urls
comm -13 ${BUILD}/tried_urls ${BUILD}/expanded > ${BUILD}/untried_urls

cat  ${BUILD}/untried_urls  > ${BUILD}/shuffled

cat  ${BUILD}/shuffled | head -4000000 | tail -100000 | shuf >  ${BUILD}/shuffled-40
cat  ${BUILD}/shuffled | head -3900000 | tail -100000 | shuf >  ${BUILD}/shuffled-39
cat  ${BUILD}/shuffled | head -3800000 | tail -100000 | shuf >  ${BUILD}/shuffled-38
cat  ${BUILD}/shuffled | head -3700000 | tail -100000 | shuf >  ${BUILD}/shuffled-37
cat  ${BUILD}/shuffled | head -3600000 | tail -100000 | shuf >  ${BUILD}/shuffled-36
cat  ${BUILD}/shuffled | head -3500000 | tail -100000 | shuf >  ${BUILD}/shuffled-35
cat  ${BUILD}/shuffled | head -3400000 | tail -100000 | shuf >  ${BUILD}/shuffled-34
cat  ${BUILD}/shuffled | head -3300000 | tail -100000 | shuf >  ${BUILD}/shuffled-33
cat  ${BUILD}/shuffled | head -3200000 | tail -100000 | shuf >  ${BUILD}/shuffled-32
cat  ${BUILD}/shuffled | head -3100000 | tail -100000 | shuf >  ${BUILD}/shuffled-31
cat  ${BUILD}/shuffled | head -3000000 | tail -100000 | shuf >  ${BUILD}/shuffled-30
cat  ${BUILD}/shuffled | head -2900000 | tail -100000 | shuf >  ${BUILD}/shuffled-29
cat  ${BUILD}/shuffled | head -2800000 | tail -100000 | shuf >  ${BUILD}/shuffled-28
cat  ${BUILD}/shuffled | head -2700000 | tail -100000 | shuf >  ${BUILD}/shuffled-27
cat  ${BUILD}/shuffled | head -2600000 | tail -100000 | shuf >  ${BUILD}/shuffled-26
cat  ${BUILD}/shuffled | head -2500000 | tail -100000 | shuf >  ${BUILD}/shuffled-25
cat  ${BUILD}/shuffled | head -2400000 | tail -100000 | shuf >  ${BUILD}/shuffled-24
cat  ${BUILD}/shuffled | head -2300000 | tail -100000 | shuf >  ${BUILD}/shuffled-23
cat  ${BUILD}/shuffled | head -2200000 | tail -100000 | shuf >  ${BUILD}/shuffled-22
cat  ${BUILD}/shuffled | head -2100000 | tail -100000 | shuf >  ${BUILD}/shuffled-21
cat  ${BUILD}/shuffled | head -2000000 | tail -100000 | shuf >  ${BUILD}/shuffled-20
cat  ${BUILD}/shuffled | head -1900000 | tail -100000 | shuf >  ${BUILD}/shuffled-19
cat  ${BUILD}/shuffled | head -1800000 | tail -100000 | shuf >  ${BUILD}/shuffled-18
cat  ${BUILD}/shuffled | head -1700000 | tail -100000 | shuf >  ${BUILD}/shuffled-17
cat  ${BUILD}/shuffled | head -1600000 | tail -100000 | shuf >  ${BUILD}/shuffled-16
cat  ${BUILD}/shuffled | head -1500000 | tail -100000 | shuf >  ${BUILD}/shuffled-15
cat  ${BUILD}/shuffled | head -1400000 | tail -100000 | shuf >  ${BUILD}/shuffled-14
cat  ${BUILD}/shuffled | head -1300000 | tail -100000 | shuf >  ${BUILD}/shuffled-13
cat  ${BUILD}/shuffled | head -1200000 | tail -100000 | shuf >  ${BUILD}/shuffled-12
cat  ${BUILD}/shuffled | head -1100000 | tail -100000 | shuf >  ${BUILD}/shuffled-11
cat  ${BUILD}/shuffled | head -1000000 | tail -100000 | shuf >  ${BUILD}/shuffled-10
cat  ${BUILD}/shuffled | head -900000 | tail -100000 | shuf >  ${BUILD}/shuffled-09
cat  ${BUILD}/shuffled | head -800000 | tail -100000 | shuf >  ${BUILD}/shuffled-08
cat  ${BUILD}/shuffled | head -700000 | tail -100000 | shuf >  ${BUILD}/shuffled-07
cat  ${BUILD}/shuffled | head -600000 | tail -100000 | shuf >  ${BUILD}/shuffled-06
cat  ${BUILD}/shuffled | head -500000 | tail -100000 | shuf >  ${BUILD}/shuffled-05
cat  ${BUILD}/shuffled | head -400000 | tail -100000 | shuf >  ${BUILD}/shuffled-04
cat  ${BUILD}/shuffled | head -300000 | tail -100000 | shuf >  ${BUILD}/shuffled-03
cat  ${BUILD}/shuffled | head -200000 | tail -100000 | shuf >  ${BUILD}/shuffled-02
cat  ${BUILD}/shuffled | head -100000 | tail -100000 | shuf >  ${BUILD}/shuffled-01

#cat ${BUILD}/contentdm_candidate_urls | shuf   >  ${BUILD}/shuffled-cdm

wc  ${BUILD}/*


#exit 1;

for file in ${BUILD}/shuffled-*; do
    ./check_urls.bash < $file &
    sleep 1
done

cat logs*/s* | sort | uniq | shuf > ${BUILD}/good_repositories_so_far
#wget --force-directories --input-file=${BUILD}/good_repositories_so_far --directory-prefix=./good_repos --tries=1 --timeout=20

rm ./tmp_urls
for file in logs/urls-*; do echo $file; cat $file | sort | uniq >> ./tmp_urls ; done
cat  ./tmp_urls | sort | uniq > ./tmp_urls_sorted

# Wait for all parallel jobs to finish
while [ 1 ]; do fg 2> /dev/null; [ $? == 1 ] && break; done

touch ${BUILD}/done




