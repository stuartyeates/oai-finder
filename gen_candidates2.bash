#!/bin/bash


BUILD=./build2
OLD=./old2-$$/
MAX=10000000

mv ${BUILD} ${OLD}
mkdir -p ${BUILD}

touch ${BUILD}/starting

for file in logs*/urls-*; do echo $file; cat $file | ./text_to_urls.bash |  ./filter_urls.bash | ./trim_urls.bash | sort | uniq >> ${BUILD}/tmp_urls ; done

cat  ${BUILD}/tmp_urls | head -${MAX} |  sort | uniq > ${BUILD}/raw_urls2

cat  ${BUILD}/raw_urls2 | ./filter_urls.bash > ${BUILD}/filtered_urls2

cat ${BUILD}/filtered_urls2 | ./trim_urls.bash | uniq | sort | uniq > ${BUILD}/trimmed_urls2

cat  ${BUILD}/trimmed_urls2 |  ./mutate-path-part.bash |  sed 's^\([^:]\)//^\1/^' | uniq | sort | uniq > ${BUILD}/expanded2

cat logs*/succ* logs*/fail* logs*/error*  | sort | uniq > ${BUILD}/tried_urls2
comm -13 ${BUILD}/tried_urls2 ${BUILD}/expanded2 > ${BUILD}/untried_urls2

cat  ${BUILD}/untried_urls2 | head -${MAX} | shuf > ${BUILD}/shuffled2

split -da 3 -l $((`wc -l < ${BUILD}/shuffled`/50)) ${BUILD}/shuffled2 ${BUILD}/shuffled2-n-

for file in ${BUILD}/shuffled2-n-*; do
    ./check_urls.bash < $file &
done
