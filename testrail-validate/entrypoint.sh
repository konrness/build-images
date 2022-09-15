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

export TESTRAIL_URL=$PLUGIN_HOST
export TESTRAIL_EMAIL=$PLUGIN_USER
export TESTRAIL_PASSWORD=$PLUGIN_PASSWORD

export PLUGIN_RUN_ID=$PLUGIN_RUN_ID
export PLUGIN_FAIL_ON_PRIORITY=$PLUGIN_FAIL_ON_PRIORITY
export PLUGIN_FAILED_STATUS_ID=$PLUGIN_FAILED_STATUS_ID

if [[ $PLUGIN_DEBUG = "true" ]]; then
    echo "-- DEBUG: running following command..."
    echo "-- DEBUG: python3 testrail.py"
    echo "-- DEBUG:   TESTRAIL_URL=$PLUGIN_HOST"
    echo "-- DEBUG:   TESTRAIL_EMAIL=$PLUGIN_USER"
    echo "-- DEBUG:   TESTRAIL_PASSWORD=$PLUGIN_PASSWORD"
    echo "-- DEBUG:   PLUGIN_RUN_ID=$PLUGIN_RUN_ID"
    echo "-- DEBUG:   PLUGIN_FAIL_ON_PRIORITY=$PLUGIN_FAIL_ON_PRIORITY"
    echo "-- DEBUG:   PLUGIN_FAILED_STATUS_ID=$PLUGIN_FAILED_STATUS_ID"
fi

exitcode=`python3 testrail.py &> output.log; echo $?`

if [[ $PLUGIN_DEBUG = "true" ]]; then
    cat output.log
fi

endtime=$(date +%s.%N)
echo "duration: $(echo "$endtime $starttime" | awk '{printf "%f", $1 - $2}')s"

if [[ $exitcode -eq 0 ]]; then
    echo "-- Successfully finished TestRail"
else
    echo "-- Error running TestRail"
fi