#!/bin/bash

# Log file to record overall CPU usage
LOGFILE="/var/log/postgresql/system_cpu_usage.log"

# Log system CPU usage every minute
while true; do
    echo "$(date +'%Y-%m-%d %H:%M:%S') - System CPU usage" >> "$LOGFILE"
    top -bn1 | grep "Cpu(s)" >> "$LOGFILE"
    sleep 60 # Check every 1 minute
done