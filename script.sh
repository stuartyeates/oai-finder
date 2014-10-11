
for code in int ac ad ae af ag ai al am an ao ar as at au aw ax az; do
    for string in dspace eprints bitstream+sequence+123456789 JOURNAL+CONTENT+issue+view "Select+a+community+to+browse+its+collections"; do 
	for from in 0 50 100 150 200 250 300 350 400 450 500; do
	    echo "http://www.google.com/search?num=50&safe=strict&q=${string}+site%3A.${code}&start=${from}"
	done
    done
done