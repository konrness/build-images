#!/usr/bin/env bash

set -e

starttime=$(date +%s.%N)
flags="${FLAGS:-$PLUGIN_FLAGS}"

echo "-- Pushing test results to TestRail..."

# check required parameters
if [[ -z $PLUGIN_USER ]]; then
    echo "-- Error: missing TestRail user"
    exit 1
fi
if [[ -z $PLUGIN_PASSWORD ]]; then
    echo "-- Error: missing TestRail password"
    exit 1
fi
if [[ -z $PLUGIN_HOST ]]; then
    echo "-- Error: missing TestRail project"
    exit 1
fi
if [[ -z $PLUGIN_PROJECT ]] && [[ -z $PLUGIN_PROJECT_ID ]]; then
    echo "-- Error: missing TestRail project or project ID"
    exit 1
fi

set +e

files="${FILES:-$PLUGIN_FILES}"
echo $files

# Get list of JUnit Report files to upload
sfiles=""
for f in $(echo $files | tr -d '[[:space:]]' | tr "," "\n"); do
    if [[ -f $PWD/$f ]]; then
      sfiles="$sfiles -f $PWD/$f"
    fi
done

sflags=""
if [[ -n $flags ]]; then
    sflags=" $flags"
fi

host=""
username=""
password=""
project=""
files=""
title='--title Harness'
run_description="--run-description $DRONE_BUILD_LINK"

if [[ -n $PLUGIN_HOST ]]; then
    host="-h $PLUGIN_HOST"
fi
if [[ -n $PLUGIN_USER ]]; then
    username="-u $PLUGIN_USER"
fi
if [[ -n $PLUGIN_PASSWORD ]]; then
    password="-p $PLUGIN_PASSWORD"
fi
if [[ -n $PLUGIN_PROJECT ]]; then
    project="--project $PLUGIN_PROJECT"
fi
if [[ -n $PLUGIN_PROJECT_ID ]]; then
    project="--project-id $PLUGIN_PROJECT_ID"
fi

if [[ $PLUGIN_DEBUG = "true" ]]; then
    echo "-- DEBUG: running following command..."
    echo "-- DEBUG: trcli -y $sflags $host $project $user $password parse_junit $title $run_description $sfiles"
fi

exitcode=`trcli -y \
  $host \
  $project \
  $username \
  $password \
  parse_junit \
  $title \
  $run_description \
  $sfiles &> output.log; echo $?`

if [[ $PLUGIN_DEBUG = "true" ]]; then
    cat output.log
fi

endtime=$(date +%s.%N)
echo "duration: $(echo "$endtime $starttime" | awk '{printf "%f", $1 - $2}')s"

if [[ $exitcode -eq 0 ]]; then
    echo "-- Test results successfully pushed to TestRail"
else
    echo "-- Test results failed to push to TestRail"
fi