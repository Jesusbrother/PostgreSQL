#!/bin/bash

# Set log directory and size threshold in MB
LOG_DIR="/var/log/postgresql"
SIZE_THRESHOLD=100 # Size in MB

# Check each log file size and alert if it exceeds the threshold
for LOG_FILE in "$LOG_DIR"/*.log; do
    FILE_SIZE=$(du -m "$LOG_FILE" | cut -f1)
    if [ "$FILE_SIZE" -gt "$SIZE_THRESHOLD" ]; then
        echo "ALERT: Log file $LOG_FILE has exceeded $SIZE_THRESHOLD MB with size ${FILE_SIZE} MB."
    fi
done