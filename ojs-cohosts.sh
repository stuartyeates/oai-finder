
for url in `cat build/explore  | sort | uniq`; 
do  
#    (wget "${url}" --no-clobber  --wait=5 --restrict-file-names=windows --directory-prefix=build/ojs --force-directories  --recursive --level=2 --convert-links --span-hosts --quiet &); 
    (wget "${url}"  --restrict-file-names=windows --directory-prefix=build/ojs --force-directories  --convert-links --span-hosts -e robots=off --quiet &); 
    sleep 1; 
done
