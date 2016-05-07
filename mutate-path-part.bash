#!/bin/bash
#script to create variants of the port part of the URL

while read "URL"
do
    if [ ! -z "${URL}" ]; then
	echo ${URL}
	while [[ "${URL}" =~  ^https?://[-a-z0-9.:]*/  ]]
	do
	    echo ${URL}
	    if [[ "${URL}" =~  /$  ]]; then
		echo ${URL} | sed 's|$|casirgrid-oai/request?verb=Identify|'
		echo ${URL} | sed 's|$|cgi-bin/oai.cgi?verb=Identify|'  # greenstone
		echo ${URL} | sed 's|$|cgi-bin/oai.exe?verb=Identify|' # greenstone
		echo ${URL} | sed 's|$|cgi-bin/oai?verb=Identify|' # greenstone
		echo ${URL} | sed 's|$|cgi-bin/oaiserver.exe?verb=Identify|' # greenstone
		echo ${URL} | sed 's|$|cgi-bin/oaiserver.cgi?verb=Identify|' # greenstone
		echo ${URL} | sed 's|$|cgi-bin/oaiserver?verb=Identify|' # greenstone
		echo ${URL} | sed 's|$|cgi/oai2?verb=Identify|'
		echo ${URL} | sed 's|$|do.oai?verb=Identify|'
		echo ${URL} | sed 's|$|dspace-oai/request?verb=Identify|' # dspace
		echo ${URL} | sed 's|$|fedora/oai?verb=Identify|' #fedora 3
		echo ${URL} | sed 's|$|greenstone/cgi-bin/oaiserver.cgi?verb=Identify|' # greenstone
		echo ${URL} | sed 's|$|greenstone/cgi-bin/oaiserver.exe?verb=Identify|' # greenstone
		echo ${URL} | sed 's|$|greenstone/cgi-bin/oaiserver?verb=Identify|' # greenstone
		echo ${URL} | sed 's|$|gsdl/cgi-bin/oaiserver.cgi?verb=Identify|' # greenstone
		echo ${URL} | sed 's|$|gsdl/cgi-bin/oaiserver.exe?verb=Identify|' # greenstone
		echo ${URL} | sed 's|$|gsdl/cgi-bin/oaiserver?verb=Identify|' # greenstone
		echo ${URL} | sed 's|$|ir-oai/request?verb=Identify|'
		echo ${URL} | sed 's|$|modules/xoonips/oai.php?verb=Identify|'  # xoonips
		echo ${URL} | sed 's|$|oai-pmh-repository.xml?verb=Identify|' # dlibra
		echo ${URL} | sed 's|$|oai-pmh/oai-pmh?verb=Identify|'  #drupal
		echo ${URL} | sed 's|$|oai-pmh?verb=Identify|'  #drupal
		echo ${URL} | sed 's|$|oai/driver?verb=Identify|'
		echo ${URL} | sed 's|$|oai/oai.php?verb=Identify|'
		echo ${URL} | sed 's|$|oai/request?verb=Identify|' # dspace
		echo ${URL} | sed 's|$|oai/scielo-oai.php?verb=Identify|'
		echo ${URL} | sed 's|$|oai/scielo-oai.php?verb=Identify|'   # scilo
		echo ${URL} | sed 's|$|oai2/oai2.php?verb=Identify|'
		echo ${URL} | sed 's|$|oai2d?verb=Identify|'  # invenio
		echo ${URL} | sed 's|$|oai2?verb=Identify|'
		echo ${URL} | sed 's|$|oaicat?verb=Identify|'
		echo ${URL} | sed 's|$|oaiextended/request?verb=Identify|'
		echo ${URL} | sed 's|$|oaiserver.cgi?verb=Identify|'
		echo ${URL} | sed 's|$|oaiserver?verb=Identify|'
		echo ${URL} | sed 's|$|oai?verb=Identify|'
		echo ${URL} | sed 's|$|opac/mmd_api/oai-pmh/?verb=Identify|'
		echo ${URL} | sed 's|$|opus4/oai?verb=Identify|'   #  opus
		echo ${URL} | sed 's|$|phpoai/oai2.php?verb=Identify|'   # opus
		echo ${URL} | sed 's|$|rest/oai?verb=Identify|' #fedora 4
		echo ${URL} | sed 's|$|sobekcm_oai.aspx?verb=Identify|'
		echo ${URL} | sed 's|$|ws/oai?verb=Identify|'
		echo ${URL} | sed 's|$|oai-pmh-repository/request?verb=Identify|'   #omeka
		echo ${URL} | sed 's|$|index/oai?verb=Identify|'   #omeka
		echo ${URL} | sed 's|$|?page=oai\&amp;verb=Identify|'   #ojs no mapping
#		echo ${URL} | sed 's|$||'
#		echo ${URL} | sed 's|$||'
#		echo ${URL} | sed 's|$||'
#		echo ${URL} | sed 's|$||'
#		echo ${URL} | sed 's|$||'
#		echo ${URL} | sed 's|$||'
	    else
		true;
	    fi
	    
	    URL=`echo $URL | sed 's![^/]*.$!!'`

	    
	done
		
    fi
done
