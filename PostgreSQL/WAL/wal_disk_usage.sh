#!/bin/bash

# Define WAL directory and size threshold
WAL_DIR="/var/lib/postgresql/12/main/pg_wal"  # Update with your actual WAL directory path
THRESHOLD=1000  # Threshold in MB

# Calculate WAL directory size in MB
WAL_SIZE=$(du -sm "$WAL_DIR" | cut -f1)

# Check if WAL directory size exceeds threshold
if [ "$WAL_SIZE" -gt "$THRESHOLD" ]; then
    echo "ALERT: WAL directory size ($WAL_SIZE MB) exceeds threshold ($THRESHOLD MB)."
fi