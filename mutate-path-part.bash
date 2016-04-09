#!/bin/bash
#script to create variants of the port part of the URL

while read URL
do
    if [ ! -z "${URL}" ]; then
	while [[ "${URL}" =~  ^https?://[a-z0-9.]*/  ]]
	do
	    echo ${URL}
	    if [[ "${URL}" =~  /$  ]]; then
		echo ${URL} | sed 's|$|casirgrid-oai/request|'
		echo ${URL} | sed 's|$|cgi-bin/oai.cgi|'  # greenstone
		echo ${URL} | sed 's|$|cgi-bin/oai.exe|' # greenstone
		echo ${URL} | sed 's|$|cgi-bin/oaiserver.cgi|' # greenstone
		echo ${URL} | sed 's|$|cgi-bin/oaiserver|' # greenstone
		echo ${URL} | sed 's|$|cgi-bin/oai|' # greenstone
		echo ${URL} | sed 's|$|cgi/oai2|'
		echo ${URL} | sed 's|$|do.oai|'
		echo ${URL} | sed 's|$|dspace-oai/request|' # dspace
		echo ${URL} | sed 's|$|fedora/oai|' #fedora 3
		echo ${URL} | sed 's|$|greenstone/cgi-bin/oaiserver.cgi|' # greenstone
		echo ${URL} | sed 's|$|greenstone/cgi-bin/oaiserver|' # greenstone
		echo ${URL} | sed 's|$|gsdl/cgi-bin/oaiserver.cgi|' # greenstone
		echo ${URL} | sed 's|$|gsdl/cgi-bin/oaiserver|' # greenstone
		echo ${URL} | sed 's|$|ir-oai/request|'
		echo ${URL} | sed 's|$|modules/xoonips/oai.php|'  # xoonips
		echo ${URL} | sed 's|$|oai-pmh-repository.xml|' # dlibra
		echo ${URL} | sed 's|$|oai-pmh/oai-pmh|'  #drupal
		echo ${URL} | sed 's|$|oai-pmh|'  #drupal
		echo ${URL} | sed 's|$|oai/driver|'
		echo ${URL} | sed 's|$|oai/oai.php|'
		echo ${URL} | sed 's|$|oai/request|' # dspace
		echo ${URL} | sed 's|$|oai/scielo-oai.php|'
		echo ${URL} | sed 's|$|oai/scielo-oai.php|'   # scilo
		echo ${URL} | sed 's|$|oai2/oai2.php|'
		echo ${URL} | sed 's|$|oai2d|'  # invenio
		echo ${URL} | sed 's|$|oai2|'
		echo ${URL} | sed 's|$|oaicat|'
		echo ${URL} | sed 's|$|oaiextended/request|'
		echo ${URL} | sed 's|$|oaiserver.cgi|'
		echo ${URL} | sed 's|$|oaiserver|'
		echo ${URL} | sed 's|$|oai|'
		echo ${URL} | sed 's|$|opac/mmd_api/oai-pmh/|'
		echo ${URL} | sed 's|$|opus4/oai|'   #  opus
		echo ${URL} | sed 's|$|phpoai/oai2.php|'   # opus
		echo ${URL} | sed 's|$|rest/oai|' #fedora 4
		echo ${URL} | sed 's|$|sobekcm_oai.aspx|'
		echo ${URL} | sed 's|$|ws/oai|'
#		echo ${URL} | sed 's|$||'
#		echo ${URL} | sed 's|$||'
#		echo ${URL} | sed 's|$||'
#		echo ${URL} | sed 's|$||'
#		echo ${URL} | sed 's|$||'
#		echo ${URL} | sed 's|$||'
	    else

	    fi
	    
	    URL=`echo $URL | sed 's![^/]*.$!!'`

	    
	done
		
    fi
done
