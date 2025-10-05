#!/bin/sh

NAME="kwin_win8"

if command -v "qtpaths6"; then

# Plasma 6
DATA_DIR=`qtpaths6 --paths GenericDataLocation | cut -d":" -f 1`
mkdir -p ${DATA_DIR}/kwin/decorations/$NAME
KWIN_DIR=${DATA_DIR}/kwin/decorations/${NAME}/
mkdir -p ${KWIN_DIR}/contents/ui
cp -r ./contents/* ${KWIN_DIR}/contents/ui
cp metadata.json ${KWIN_DIR}
kbuildsycoca6
echo kwin_win8 Installed

else

# Plasma 5
DATA_DIR=`kf5-config --path data | cut -d":" -f 1`
SERVICES_DIR=`kf5-config --path services | cut -d":" -f 1`

mkdir -p ${DATA_DIR}kwin/decorations/$NAME
cp -r * ${DATA_DIR}kwin/decorations/$NAME
cp metadata.desktop ${SERVICES_DIR}$NAME.desktop
kbuildsycoca5 &> /dev/null
echo kwin_win8 Installed

fi
