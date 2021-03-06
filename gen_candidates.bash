#!/bin/bash


BUILD=./build
OLD=./old-$$/

mv ${BUILD} ${OLD}
mkdir -p ${BUILD}

touch ${BUILD}/starting

for dir in ~/cache* ./cache*  ; do
    find ${dir} -type f -exec cat \{\} \;
done | ./text_to_urls.bash | uniq  |sort | uniq > ${BUILD}/raw_urls

#cat ./oai-found/0.0.1/raw | ./text_to_urls.bash | uniq  |sort | uniq > ${BUILD}/raw_urls

cat  ${BUILD}/raw_urls | ./filter_urls.bash > ${BUILD}/filtered_urls

cat ${BUILD}/filtered_urls | ./trim_urls.bash | uniq | sort | uniq > ${BUILD}/trimmed_urls

cat  ${BUILD}/trimmed_urls |  ./mutate-path-part.bash |  sed 's^\([^:]\)//^\1/^' | uniq | sort | uniq > ${BUILD}/expanded

cat logs*/succ* logs*/fail* logs*/error*  | sort | uniq > ${BUILD}/tried_urls
comm -13 ${BUILD}/tried_urls ${BUILD}/expanded > ${BUILD}/untried_urls

cat  ${BUILD}/untried_urls  | head -10000000 | shuf > ${BUILD}/shuffled

split -da 3 -l $((`wc -l < ${BUILD}/shuffled`/50)) ${BUILD}/shuffled ${BUILD}/shuffled-n-

for file in ${BUILD}/shuffled-n-*; do
    ./check_urls.bash < $file &
done

#cat  ${BUILD}/trimmed_urls | grep -a '/index.php' | sed 's|/index.php.*|/index.php|' | sort | uniq > ${BUILD}/ojs_installs
#wget --force-directories --input-file=build/ojs_installs --directory-prefix=./cache-ojs4 --tries=1 --timeout=20

#cat  ${BUILD}/trimmed_urls | grep -a contentdm.oclc.org/ |sed  's|$|/oai/oai.php?verb=Identify|' > ${BUILD}/contentdm_candidate_urls
#cat ${BUILD}/contentdm_candidate_urls | shuf   >  ${BUILD}/shuffled-cdm

#cat logs*/s* | tr ' <>()"\000\r\n' '\012' | tr " '" '\012' | sort | uniq > ${BUILD}/good_repositories_so_far
#cat ${BUILD}/good_repositories_so_far | ./trim_urls.bash  | shuf | head +1000 | ./mutate-path-part.bash | sort | uniq | shuf > ${BUILD}/good_repositories_expanded
#wget --force-directories --input-file=${BUILD}/good_repositories_so_far --directory-prefix=./good_repos --tries=1 --timeout=20


#rm ./tmp_urls
#for file in logs*/urls-*; do echo $file; cat $file |  ./filter_urls.bash | ./trim_urls.bash | sort | uniq >> ${BUILD}/tmp_urls ; done
#cat  ${BUILD}/tmp_urls |  sort | uniq > ${BUILD}/tmp_urls_sorted


cat logs*/s* | tr ' <>()"\000\r\n' '\012' | tr " '" '\012' | sort | uniq > oai-found/0.0.1/raw;
(cd oai-found; git commit -m add . &)


# Wait for all parallel jobs to finish
while [ 1 ]; do fg 2> /dev/null; [ $? == 1 ] && break; done

touch ${BUILD}/done

exit 0;

#mkdir ./cache-specials
#for count in $(seq 1 200); do
#    sleep 2
#    echo $i;
#    curl -X GET --header "Accept: application/json" "https://doaj.org/api/v1/search/journals/http?page=${count}&pageSize=100" --output "./nocache-specials/doaj.${count}"
#    if [ $? -ne 0 ]
#    then
#	break;
#    fi	
#done
#
#mkdir ./opendoar
#curl --max-time 300 --output "./nocache-specials/opendoar.xml"  --referer "http://www.google.com/"  --verbose  --url "http://opendoar.org/api13.php?all=y"







