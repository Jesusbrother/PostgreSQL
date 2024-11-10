#!/bin/bash

# Log file for system load average
LOGFILE="/var/log/postgresql/load_average.log"

# Log load average every minute
while true; do
    echo "$(date +'%Y-%m-%d %H:%M:%S') - System Load Average" >> "$LOGFILE"
    uptime | awk -F'load average:' '{ print "Load Average:" $2 }' >> "$LOGFILE"
    sleep 60 # Log every 1 minute
done