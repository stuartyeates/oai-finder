#!/bin/bash
#wget --page-requisites --save-cookies  yandex.cookies --keep-session-cookies --no-clobber --restrict-file-names=windows --default-page=index.php --user-agent="Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/37.0.2062.120 Chrome/37.0.2062.120 Safari/537.36" --ignore-length --wait 150 --force-directories https://www.yandex.com/

wget --page-requisites --load-cookies yandex.cookies --save-cookies  yandex.cookies --keep-session-cookies --no-clobber --restrict-file-names=windows --default-page=index.php --user-agent="Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/37.0.2062.120 Chrome/37.0.2062.120 Safari/537.36" --ignore-length --wait 150 --force-directories --input-file=yandex.urls

