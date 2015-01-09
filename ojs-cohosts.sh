#!/bin/bash
# A command to download related ojs websites, incase we have found 
# only one journal in a multi-site install

for url in `cat build/explore  | sort | uniq | shuf`; 
do  
#    (wget "${url}" --no-clobber  --wait=5 --restrict-file-names=windows --directory-prefix=build/ojs --force-directories  --recursive --level=2 --convert-links --span-hosts --quiet &); 
    echo doing ${url}
    (wget "${url}"  --recursive --level=1 --restrict-file-names=windows --directory-prefix=build/ojs --force-directories  --convert-links --span-hosts -e robots=off --quiet --wait=2 --random-wait --timeout=9 -R mpg,mpeg,au,mp4,pdf,jpg,jpeg,png,gif,doc,docx &); 
    sleep 1; 
done
