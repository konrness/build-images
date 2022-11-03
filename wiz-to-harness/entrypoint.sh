#!/bin/sh

set -e

starttime=$(date +%s.%N)

echo "-- Reformatting Wiz scan results to Harness format..."

# check required parameters
if [ -z $PLUGIN_INPUT_FILE ]; then
    echo "-- Error: missing input file"
    exit 1
fi

if [ -z $PLUGIN_OUTPUT_FILE ]; then
    echo "-- Error: missing output file"
    exit 1
fi

set +e

if [ "$PLUGIN_DEBUG" = "true" ]; then
    echo "-- DEBUG: running following command..."
    echo "-- DEBUG: node /home/wizToHarness.js $PLUGIN_INPUT_FILE $PLUGIN_OUTPUT_FILE"
fi

exitcode=`node /home/wizToHarness.js $PLUGIN_INPUT_FILE $PLUGIN_OUTPUT_FILE &> output.log; echo $?`

if [ "$PLUGIN_DEBUG" = "true" ]; then
    cat output.log
fi

endtime=$(date +%s.%N)
echo "duration: $(echo "$endtime $starttime" | awk '{printf "%f", $1 - $2}')s"

if [[ $exitcode -eq 0 ]]; then
    echo "-- Successfully finished wiz-to-harness"
else
    echo "-- Error running wiz-to-harness"
    exit $exitcode
fi