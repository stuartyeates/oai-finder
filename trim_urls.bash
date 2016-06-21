#!/bin/bash

# read urls from standard in and trim them

perl -p -e 's^(/article/view/|/handle/|/exhibits/show/|/islandora/object/|/items/|/file/|/help/|/gateway/plugin/|/article/|/bitstream/|/user/|/items/|/item/|/issue/|/pages/|/submission/|/themes/|/view/|/cdm/|/login/|/utils/|/ui/custom/|/node/|/item_viewer.php/|/plugins/|/js/|/datastream/|/about/|/phpdoc/|/forums/|/CollectionViewPage.external|/lib/pkp/|/browse|/search|/browse|VODID=|verb=).*^/^' | sed 's|/\([0-9]\)*/\([0-9]\).*|/|g' | sed 's|/\([0-9]\)*/$|/|g'  | sed 's!/[^/]*\(\.js$\|\.css$\|\.gif$\|\.jpg$\|\.rss$\|\.atom$\|\.rss2$\|\.png$\|\.pdf\)!/!'  |sed 's|/library.cgi.*|/library.cgi|'  | sed 's|/cgi-bin/library.*|/cgi-bin/library|' | sed 's|/cdmcustom/.*|/cdmcustom/|' | sed 's|/vital/access/manager/.*|/vital/access/manager/|'  | sed 's|/[0-9]*$|/|' | sed 's|/wp-.*|/|' |  sed 's|/dlibra.*|/dlibra|' | sed 's|/ETD-db/.*|/ETD-db/|' | sed 's|/etd-[-0-9/]*$||' 
