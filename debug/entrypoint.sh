#!/bin/sh

starttime=$(date +%s.%N)

echo "-- Printing all Environment Variables..."

printenv

echo "-- Updating DRONE_OUTPUT .env file..."

touch $DRONE_OUTPUT
echo "foo=bar" >> $DRONE_OUTPUT

endtime=$(date +%s.%N)
echo "duration: $(echo "$endtime $starttime" | awk '{printf "%f", $1 - $2}')s"
