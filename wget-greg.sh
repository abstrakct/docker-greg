#!/bin/bash

LINK="$1"
DIRECTORY="$2"
DATE="$3"
FILENAMETITLE="$4"
PODCASTTITLE="$5"


RESULT=$(/usr/bin/wget $LINK -O "${DIRECTORY}/${DATE}-${FILENAMETITLE}.mp3" -a "${DIRECTORY}/${PODCASTTITLE}.log" -c -nv)

MESSAGE=""

if [[ $RESULT == 0 ]]; then
    # No errors
    TITLE="Success!"
    MESSAGE="Downloaded file ${FILENAMETITLE} for podcast ${PODCASTTITLE}!"
else
    # Some error happened!
    TITLE="ERROR!"
    MESSAGE="Error code ${RESULT} encountered while downloading file ${FILENAMETITLE} for podcast ${PODCASTTITLE}! See man wget for more details."
fi

apprise -t "$TITLE" -b "$MESSAGE" "$APPRISE_SERVICE"
