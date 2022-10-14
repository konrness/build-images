#!/usr/bin/env bash

set -e

starttime=$(date +%s.%N)

echo "-- Printing all Environment Variables..."

printenv

endtime=$(date +%s.%N)
echo "duration: $(echo "$endtime $starttime" | awk '{printf "%f", $1 - $2}')s"
