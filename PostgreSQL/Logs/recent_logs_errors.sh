#!/bin/bash

# Define the log file path and search for recent errors
LOG_DIR="/var/log/postgresql"
ERROR_LOG="/var/log/postgresql/recent_errors.log"
ERROR_THRESHOLD=50

# Find recent errors in PostgreSQL logs (e.g., last 24 hours)
grep "$(date +'%Y-%m-%d')" "$LOG_DIR"/*.log | grep "ERROR" > "$ERROR_LOG"

# Check if the number of errors exceeds the threshold
ERROR_COUNT=$(wc -l < "$ERROR_LOG")

if [ "$ERROR_COUNT" -gt "$ERROR_THRESHOLD" ]; then
    echo "ALERT: High number of errors ($ERROR_COUNT) in PostgreSQL logs within the last 24 hours."
fi