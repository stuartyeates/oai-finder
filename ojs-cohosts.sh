#!/bin/bash
# A command to download related ojs websites, incase we have found 
# only one journal in a multi-site install

for url in `cat build/explore  | grep -v ftp.free.fr | grep -v github.com | sed 's|^\(.*\)//\([^/]*\)/\(.*\)$|http://\2/\nhttp://\2/\3\nhttps://\2/\nhttps://\2/\3\n|' | sort | uniq | shuf`; 
do  
#    (wget "${url}" --no-clobber  --wait=5 --restrict-file-names=windows --directory-prefix=build/ojs --force-directories  --recursive --level=2 --convert-links --span-hosts --quiet &); 
    echo doing ${url}
    (wget "${url}"  --recursive --level=1 --restrict-file-names=windows --protocol-directories --directory-prefix=build/ojs --force-directories --no-clobber --convert-links --span-hosts -e robots=off --quiet --wait=1 --random-wait --timeout=9 -R mpg,mpeg,au,mp4,pdf,jpg,jpeg,png,gif,doc,docx,css,js,swf --quota=1m --no-check-certificate &); 
    sleep 5; 
    ps auxwww | grep wget | wc --lines
    df .
done

