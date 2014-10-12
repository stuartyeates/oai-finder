
a="int ac ad ae af ag ai al am an ao ar as at au aw ax az"
b="ba bb bd be bf bg bh bi bj bm bn bo br bs bt bv bw by"
c="ca cc cd cf cg ch ci ck cl cm cn co cr cs cu cv cw cx cy cz"

for code in  de dj dk dm do dz ec ee eg eh er es et eu fi fj fk fm fo fr ; do
    for string in dspace eprints bitstream+sequence+123456789 JOURNAL+CONTENT+issue+view "Select+a+community+to+browse+its+collections"; do 
	for from in 0 50 100 150 200 250 300 350 400 450 500; do
	    echo "http://www.google.com/search?num=50&safe=strict&q=${string}+site%3A.${code}&start=${from}"
	done
    done
done