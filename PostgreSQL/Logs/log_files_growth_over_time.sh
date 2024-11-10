#!/bin/bash

# Log file to store size information
SIZE_LOG="/var/log/postgresql/log_size_tracking.log"

# Track the size of each PostgreSQL log file
for LOG_FILE in /var/log/postgresql/*.log; do
    FILE_SIZE=$(du -m "$LOG_FILE" | cut -f1)
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $LOG_FILE: ${FILE_SIZE} MB" >> "$SIZE_LOG"
done