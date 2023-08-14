#!/bin/bash

# Date string
date_string="2023-08-14T08:28:53.698818Z"

# Convert date string to Unix timestamp
date_timestamp=$(date -d "$date_string" +"%s")
echo "$date_timestamp"

# Get current Unix timestamp
current_timestamp=$(date +"%s")
echo "$current_timestamp"

if [ "$date_timestamp" -gt "$current_timestamp" ]; then
    echo "The date is in the future."
else
    echo "The date is not in the future."
fi
