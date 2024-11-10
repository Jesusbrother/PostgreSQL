#!/bin/bash

# Load average threshold
THRESHOLD=2.0
LOGFILE="/var/log/postgresql/load_alert.log"

# Check the 1-minute load average
LOAD=$(uptime | awk -F'load average: ' '{print $2}' | cut -d, -f1)

# Alert if load average exceeds threshold
if (( $(echo "$LOAD > $THRESHOLD" | bc -l) )); then
    echo "$(date +'%Y-%m-%d %H:%M:%S') - ALERT: High load average - $LOAD" >> "$LOGFILE"
fi