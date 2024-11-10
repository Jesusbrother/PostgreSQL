#!/bin/bash

# Define the path to the WAL directory
WAL_DIR="/var/lib/postgresql/12/main/pg_wal"  # Update with your actual WAL directory path
THRESHOLD=1024  # Set threshold in MB for alert

# Calculate WAL directory size in MB
WAL_SIZE=$(du -sm "$WAL_DIR" | cut -f1)

# Check if WAL directory size exceeds threshold
if [ "$WAL_SIZE" -gt "$THRESHOLD" ]; then
    echo "ALERT: WAL directory size ($WAL_SIZE MB) exceeds threshold ($THRESHOLD MB)."
fi