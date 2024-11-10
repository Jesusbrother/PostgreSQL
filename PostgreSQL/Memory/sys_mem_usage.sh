#!/bin/bash

# Log file to record system memory usage
MEMORY_LOG="/var/log/postgresql/system_memory_usage.log"

# Log memory usage every minute
while true; do
    echo "$(date +'%Y-%m-%d %H:%M:%S') - System Memory Usage" >> "$MEMORY_LOG"
    free -h >> "$MEMORY_LOG"
    sleep 60 # Log every 1 minute
done