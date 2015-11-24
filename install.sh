#!/bin/sh

NAME="kwin_win8"
DATA_DIR=`kde4-config --path data | cut -d":" -f 1`
SERVICES_DIR=`kde4-config --path services | cut -d":" -f 1`

mkdir -p ${DATA_DIR}kwin/decorations/$NAME
cp -r * ${DATA_DIR}kwin/decorations/$NAME
cp metadata.desktop ${SERVICES_DIR}$NAME.desktop
kbuildsycoca4 &> /dev/null
echo kwin_win8 Installed
