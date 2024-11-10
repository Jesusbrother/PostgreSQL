#!/bin/bash

# Log file to record system I/O usage
LOGFILE="/var/log/postgresql/system_io_usage.log"

# Log disk I/O every minute
while true; do
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Disk I/O usage" >> "$LOGFILE"
    iostat -dx | grep -E 'Device|sda' >> "$LOGFILE" # Replace 'sda' with your device name
    sleep 60 # Log every 1 minute
done