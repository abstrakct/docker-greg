#!/bin/bash

LINK="$1"
DIRECTORY="$2"
DATE="$3"
FILENAMETITLE="$4"
PODCASTTITLE="$5"

OUTPUT="${DIRECTORY}/${DATE}-${FILENAMETITLE}.mp3"

RESULT=$(/usr/bin/wget $LINK -O $OUTPUT -a "${DIRECTORY}/${PODCASTTITLE}.log" -c -nv)

# Look for errors
if [[ $RESULT == 0 ]]; then
    # No errors
    TITLE="Success!"
    MESSAGE="Downloaded file ${FILENAMETITLE} for podcast ${PODCASTTITLE}!"
    if [[ ! -z $DL_USER && ! -z $DL_GROUP ]]; then
        chown "$DL_USER":"$DL_GROUP" $OUTPUT
    fi
else
    # Some error happened!
    TITLE="ERROR!"
    MESSAGE="Error code ${RESULT} encountered while downloading file ${FILENAMETITLE} for podcast ${PODCASTTITLE}! See man wget for more details."
fi

# Send notification (if APPRISE_SERVICE is set)
if [[ ! -z $APPRISE_SERVICE ]]; then
    apprise -t "$TITLE" -b "$MESSAGE" "$APPRISE_SERVICE"
fi
