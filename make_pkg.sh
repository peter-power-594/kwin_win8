#!/bin/sh
git archive master --prefix=kwin_win8/ | tar -xv
makeself --bzip2 kwin_win8 kwin_win8.run "Windows 8 decoration theme" ./install.sh