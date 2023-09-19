#!/usr/bin/env bash

set -e

starttime=$(date +%s.%N)
flags="${FLAGS:-$PLUGIN_FLAGS}"

echo "-- Copying image using Skopeo..."

# check required parameters
if [[ -z $PLUGIN_SOURCE ]]; then
    echo "-- Error: missing source image"
    exit 1
fi
if [[ -z $PLUGIN_DEST ]]; then
    echo "-- Error: missing destination image"
    exit 1
fi
if [[ -z $PLUGIN_SOURCE_USER ]]; then
    echo "-- Error: missing source user"
    exit 1
fi
if [[ -z $PLUGIN_SOURCE_PASS ]]; then
    echo "-- Error: missing source password"
    exit 1
fi
if [[ -z $PLUGIN_DEST_USER ]]; then
    echo "-- Error: missing dest user"
    exit 1
fi
if [[ -z $PLUGIN_DEST_PASS ]]; then
    echo "-- Error: missing dest password"
    exit 1
fi

set +e

source="$PLUGIN_SOURCE"
dest="$PLUGIN_DEST"

# TODO: Add docker transport if no transport provided

src_auth="--src-creds=$PLUGIN_SOURCE_USER:$PLUGIN_SOURCE_PASS"
dest_auth="--dest-creds=$PLUGIN_DEST_USER:$PLUGIN_DEST_PASS"

addt_options=""
if [[ -n $PLUGIN_OPTIONS ]]; then
    addt_options="$PLUGIN_OPTIONS"
fi
if [[ -n $PLUGIN_DEBUG ]]; then
    addt_options="$addt_options --debug"
fi

options="$src_auth $dest_auth $addt_options"

if [[ $PLUGIN_DEBUG = "true" ]]; then
    echo "-- DEBUG: running following command..."
    echo "-- DEBUG: skopeo copy $options $source $dest"
fi

skopeo copy $options $source $dest
exitcode=$?

endtime=$(date +%s.%N)
echo "duration: $(echo "$endtime $starttime" | awk '{printf "%f", $1 - $2}')s"

if [[ $exitcode -eq 0 ]]; then
    echo "-- Image copied from: $source to $dest"
else
    echo "-- Failed copying image from $source to $dest"
fi

exit $exitcode