#!/bin/bash

# Log file to store memory usage alerts
LOGFILE="/var/log/postgresql/memory_alert.log"
MEM_THRESHOLD=80  # Memory usage threshold in %

echo "$(date +'%Y-%m-%d %H:%M:%S') - Checking memory usage" >> "$LOGFILE"

# Check PostgreSQL processes for high memory usage
ps -eo pid,ppid,cmd,%mem --sort=-%mem | grep '[p]ostgres' | while read -r pid ppid cmd mem; do
    if (( $(echo "$mem > $MEM_THRESHOLD" | bc -l) )); then
        echo "ALERT: PostgreSQL process $pid using high memory: $mem%" >> "$LOGFILE"
    fi
done