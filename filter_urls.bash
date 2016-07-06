#!/bin/bash

grep -a -v '\(\.msn\.com\|bingj\.com\|wikipedia\.org\|\.live\.com\|twitter.com\|google\.com\|google\.co\.nz\|googleusercontent\.com\|\.blogspot\.\|clickserve\.dartsearch\.net\|ebsco\.com\|baiducontent\.com\|doubleclick\|.net\|\.doaj\.org\|.\thomsonreuters\.com\|baidu\.com\|youtube\.com\|www\.worldcat\.org\|jobs\.code4lib\.org\|www\.mail-archive\.com\|libguides\.\|/pipermail/\|www\.nla\.gov\.au\|pkp\.sfu\.ca\|localhost\|\.about\.com\|127\.0\.0\.1/\|//example\.com/\|googleapis\.com\|www.googleadservices\.com\|google\.de/\|/scholar\.google\.\|googlecode\.com\|bing\.com/\|flagcounter\.com\|ubuntuforums\.org\|stackoverflow\.com\|wholinkstome\.com\|academia\.edu\|http://earthengine\.google\.org/\|/pc\.tantin\.jp/tamori/\|mirror\.swem\.wm\.edu\|mydomain\.com\|http://myhost/\|http://my.ojs/\|puj-portal\.javeriana\.edu\.co\|crossref\.org/\|imagemagick\.org/\|http://go\.microsoft\.com\|http://goo\.gl/\|alle-domeinnamen\.xyz/\|/redir\.php\|/wp-content/\|archive\.org\|http://dromosfm\.alfanews\.com\.cy/\|http://answers\.microsoft\.com/\|rssing\.com/\|http://.*readthedocs\.org/\|http://politube\.upv\.es/\|sport-widgets\.snd\.no\|http://www\.albertalakehomes\.ca/\|http://www\.dtic\.mil/\|http://www\.ebay\.\|http://www\.nzdl\.org/\|www\.pantarhei\.ba\|http://zoot\.li/\|http://www\.hermpac\.co\.nz/\|http://osdir\.com\|alibaba\.com/\|http://trac\.\|http://www.dafiti.cl/\|http://www\.emeraldinsight\.com/\|http://www\.google\.\|http://archive-org-2013\.com/\|http://archive-it\.org/\|http://archive\.apache\.org/\|http://archive\.li/\|webofknowledge\.com/\|/archive\.is/\|/atmire\.com/\|/citeseerx\.ist\.psu\.edu/\|/doaj\.org/\|\.nabble\.com/\|microsofttranslator\.com\|http://atlantisonline\.smfforfree2\.com/\|basilicasanclemente\.com/\|//blog\.\|//blogs\.\|//boardnation\.com/\|/boards\.straightdope\.com/\|/chmod666\.org/\|/clubsearay\.com/\|/imgur\.com/\|/hal\.archives-ouvertes\.fr/\|github\.com\|moodkick\.ning\.com\|wiki\.duraspace\.org\|www\.facebook\.com\|www\.linkedin\.com\|www\.pinterest\.com\|www\.super\.kg\|www\.ana\.rs\|/www\.wpi\.edu/\|phpforum\.su\|issuu\.com\|www\.rootschat\.com\|joomlaforum\.ru\|www\.ffhockey\.org\|www.ppsystems.com\|www.frontierleague.com\|gist.github.com\|linuxforums.org.uk\|ww.preceptministries.ca\|msdn.microsoft.com\|joomlaforum.kz\|forums.modx.com\|forums.malwarebytes.org\|forum.pfsense.org\|www.avforums.co.za\|forum.avast.com\|http://forums\.\|http://forum\.\|https://forums\.\|https://forum\.\|//booking\.\|ad\.itweb\.co\.za\|allmusic\.com/\|beverageindustrynews.com.ng\|be-zet.ning.com\|blagodiynist.com.ua\|/brokencontrollers.com/\|/ebookinga.com/\/fisherpub.sjfc.edu/\|/hal-emse.ccsd.cnrs.fr/\|/ha.shsps.kh.edu.tw/\|/hcmc.uvic.ca\|/hfboards.hockeysfuture.com/\|/hub.hku.hk/\|scholar.lib.vt.edu\|www.howtobuildsoftware.com\|www.intechopen.com\|rcin.org.pl\|www.applyabroad.org\|www.oclc.org\|wiki.lib.sun.ac.za\|www.lastminutetraining.ca\|hankstruckforum.com\|bitcointalk.org\|www.bcgcertification.org\|www.littlepriest.edu\|www.steadishots.org\|www.yesnany.com\|oaklandparkboulevardtransitstudy.com\|cialis.alcohol.interaction.viagrawithoutadoctorprescription.top\|www.wow.com/\|/adultoffline.com/\|/www.audio-forums.com/\|/www.hotporno.tv/\|/waitrose.pornblink.com/\|/broker39.ru/\|https://secure.gravatar.com/\|nordstromimage\.com/\|nordstrom\.com/\|\.scribd\.com/\|\.scribdassets\.com\|/itunes.apple.com/\|/plus.google.com/\|\.stackexchange\.com\|\.wordpress\.com/\|PHPSESSID\|;\|,\|\.\.\.\|torrent\|pirateproxy\|\.go\.com\|\.microsoft\.com\|/forum/\|http://arXiv\.org/\|http://biglistofwebsites.com/\|/submit\|halshs.archives-ouvertes.fr\|/doku\.php.id=\|/mediawiki/\|//api\.addthis\.com/\|url=http\|uri=http\|/http:/\|//ads.careerweb.co.za/\|//assets.nydailynews.com/\|http://boards\.\|//clk.tradedoubler.com/\//community.ancestry.com/\|//del.icio.us/\|//digg.com/\)' | grep -a -v '^[^/]\+//[a-zA-Z0-9.-]\+/?'
