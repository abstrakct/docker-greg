#!/bin/bash

LINK="$1"
DIRECTORY="$2"
DATE="$3"
FILENAMETITLE="$4"
PODCASTTITLE="$5"


RESULT=$(/usr/bin/wget $LINK -O "${DIRECTORY}/${DATE}-${FILENAMETITLE}.mp3" -a "${DIRECTORY}/${PODCASTTITLE}.log -c -nv)

MESSAGE=""

if [ $RESULT == 0 ]; then
    # No errors
    MESSAGE="Downloaded file ${FILENAMETITLE} for podcast ${PODCASTTITLE} successfully!"
else
    # Some error happened!
    MESSAGE="Error code ${RESULT} encountered while downloading file ${FILENAMETITLE} for podcast ${PODCASTTITLE}! See man wget for more details."
fi

apprise -t "GREG" -b "$MESSAGE" "$APPRISE_SERVICE"
