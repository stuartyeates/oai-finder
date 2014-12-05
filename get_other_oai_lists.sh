#!/bin/bash

CACHEDIR=./cache/others

mkdir -p ${CACHEDIR}

wget --recursive  --no-clobber --wait=10 --force-directories --directory-prefix=${CACHEDIR}  --input-file=./other-repo-lists.url




http://www.opendoar.org/find.php?p=160&step=20&format=summary
http://blogs.biomedcentral.com/orblog/page/2/
http://www.duraspace.org/registry/dspace?search_fulltext=&page=89
http://www.duraspace.org/registry/fedora?search_fulltext=&page=16
