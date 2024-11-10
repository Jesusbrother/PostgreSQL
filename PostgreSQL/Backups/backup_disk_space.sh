#!/bin/bash

# Define backup directory and space threshold percentage
BACKUP_DIR="/var/lib/postgresql/backups"
THRESHOLD=20

# Get the available space in the backup directory
AVAILABLE_SPACE=$(df "$BACKUP_DIR" | awk 'NR==2 {print $5}' | sed 's/%//')

# Alert if available space is below the threshold
if [ "$AVAILABLE_SPACE" -gt "$((100 - THRESHOLD))" ]; then
    echo "ALERT: Available space in $BACKUP_DIR is below $THRESHOLD%. Consider cleaning up old backups."
else
    echo "Sufficient space available in $BACKUP_DIR."
fi