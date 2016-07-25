#!/bin/bash
#scipt to create variants of the port part of the URL

TMPIN=`mktemp /tmp/in.XXXXXXXXXXXXX`
TMPOUT=`mktemp /tmp/out.XXXXXXXXXXXXX`

while read "URL"
do
    if [ ! -z "${URL}" ]; then
	echo "${URL}" >> ${TMPIN}
	echo "${URL}" >> ${TMPOUT}

	protocol=`echo ${URL}| sed 's|^\([^/]*\)//*\([^/]*\)/\(.*\)$|\1|'` 
	host=`echo ${URL}| sed 's|^\([^/]*\)//*\([^/]*\)/\(.*\)$|\2|'` 
	path=`echo ${URL}| sed 's|^\([^/]*\)//*\([^/]*\)/\(.*\)$|\3|'` 

	path=$(echo $path| sed 's|\?.*||')
	
	echo "${protocol}//${host}/${path}"  >> ${TMPIN}
	echo "${protocol}//${host}/${path}"  >> ${TMPOUT}

	path=$(echo $path| sed -r 's|[^/]*$||')
	
	echo "${protocol}//${host}/${path}"  >> ${TMPIN}
	echo "${protocol}//${host}/${path}"  >> ${TMPOUT}

	while [[ !  -z  $path  ]]
	do
	    echo "${protocol}//${host}/${path}/"  >> ${TMPIN}
	    echo "${protocol}//${host}/${path}/"  >> ${TMPOUT}

	    pathnew=$(echo $path| sed -r 's|[^/]*/$||')

	    echo \"$path\" \"$pathnew\"

	    path=$pathnew
	done
    fi
done


cat ${TMPIN} | sed 's|$|/oai/request?verb=Identify|' >> ${TMPOUT}
cat ${TMPIN} | sed 's|$|casirgrid-oai/request?verb=Identify|' >> ${TMPOUT}
cat ${TMPIN} | sed 's|$|cgi-bin/oai.cgi?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|cgi-bin/oai.exe?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|cgi-bin/oai?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|cgi-bin/oaiserver.exe?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|cgi-bin/oaiserver.cgi?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|cgi-bin/oaiserver?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|cgi/oai2?verb=Identify|' >> ${TMPOUT}
cat ${TMPIN} | sed 's|$|do.oai?verb=Identify|' >> ${TMPOUT}
cat ${TMPIN} | sed 's|$|dspace-oai/request?verb=Identify|' >> ${TMPOUT} # dspace
cat ${TMPIN} | sed 's|$|fedora/oai?verb=Identify|' >> ${TMPOUT} #fedora 3
cat ${TMPIN} | sed 's|$|greenstone/cgi-bin/oaiserver.cgi?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|greenstone/cgi-bin/oaiserver.exe?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|greenstone/cgi-bin/oaiserver?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|gsdl/cgi-bin/oaiserver.cgi?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|gsdl/cgi-bin/oaiserver.exe?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|gsdl/cgi-bin/oaiserver?verb=Identify|' >> ${TMPOUT} # greenstone
cat ${TMPIN} | sed 's|$|ir-oai/request?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|modules/xoonips/oai.php?verb=Identify|' >> ${TMPOUT} # xoonips
cat ${TMPIN} | sed 's|$|oai-pmh-repository.xml?verb=Identify|' >> ${TMPOUT} # dlibra
cat ${TMPIN} | sed 's|$|oai-pmh/oai-pmh?verb=Identify|' >> ${TMPOUT} #drupal
cat ${TMPIN} | sed 's|$|oai-pmh?verb=Identify|' >> ${TMPOUT} #drupal
cat ${TMPIN} | sed 's|$|oai/driver?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|oai/oai.php?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|oai/request?verb=Identify|' >> ${TMPOUT} # dspace
cat ${TMPIN} | sed 's|$|oai/scielo-oai.php?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|oai/scielo-oai.php?verb=Identify|' >> ${TMPOUT} # scilo
cat ${TMPIN} | sed 's|$|oai2/oai2.php?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|oai2d?verb=Identify|' >> ${TMPOUT} # invenio
cat ${TMPIN} | sed 's|$|oai2?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|oaicat?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|oaiextended/request?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|oaiserver.cgi?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|oaiserver?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|oai?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|opac/mmd_api/oai-pmh/?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|opus4/oai?verb=Identify|' >> ${TMPOUT} # opus
cat ${TMPIN} | sed 's|$|phpoai/oai2.php?verb=Identify|' >> ${TMPOUT} # opus
cat ${TMPIN} | sed 's|$|rest/oai?verb=Identify|' >> ${TMPOUT} #fedora 4
cat ${TMPIN} | sed 's|$|sobekcm_oai.aspx?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|/+/oai?verb=Identify|' >> ${TMPOUT} # OJS shortest feed.
cat ${TMPIN} | sed 's|$|+/oai?verb=Identify|' >> ${TMPOUT} # OJS shortest feed.
cat ${TMPIN} | sed 's|$|ws/oai?verb=Identify|' >> ${TMPOUT} 
cat ${TMPIN} | sed 's|$|oai-pmh-repository/request?verb=Identify|' >> ${TMPOUT} #omeka
cat ${TMPIN} | sed 's|$|index/oai?verb=Identify|' >> ${TMPOUT} #omeka
cat ${TMPIN} | sed 's|$|?page=oai\&amp;verb=Identify|' >> ${TMPOUT} #ojs no mapping
cat ${TMPIN} | sed 's|$|/pycsw/csw.py?mode=oaipmh&verb=Identify|' >> ${TMPOUT} # http://docs.pycsw.org/en/1.10.4/oaipmh.html
cat ${TMPIN} | sed 's|$|/catalogue/csw.py?mode=oaipmh&verb=Identify|' >> ${TMPOUT} # http://docs.pycsw.org/en/1.10.4/oaipmh.html
cat ${TMPIN} | sed 's|$|/?action=repository_oaipmh|' >> ${TMPOUT} # http://ir.soken.ac.jp/?action=repository_oaipmh&verb=Identify

#cat ${TMPIN} | sed 's|$||' >> ${TMPOUT} # 

cat ${TMPOUT} | sort | uniq

rm ${TMPOUT}
rm ${TMPIN}

