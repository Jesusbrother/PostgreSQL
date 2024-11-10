#!/bin/bash

# Define log file path
LOG_DIR="/var/log/postgresql"
ERROR_FREQUENCY_LOG="/var/log/postgresql/error_frequency.log"

# Parse logs and identify top 5 most common errors
grep "ERROR" "$LOG_DIR"/*.log | awk -F 'ERROR' '{print $2}' | sort | uniq -c | sort -nr | head -5 > "$ERROR_FREQUENCY_LOG"

echo "Top 5 most common errors in PostgreSQL logs:"
cat "$ERROR_FREQUENCY_LOG"