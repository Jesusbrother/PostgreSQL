#!/bin/bash

# Path to the backups directory and alert threshold in days
BACKUP_DIR="/var/lib/postgresql/backups"
ALERT_THRESHOLD=1 # Days

# Find the latest backup file and its modification time
LATEST_BACKUP=$(find "$BACKUP_DIR" -type f -printf '%T+ %p\n' | sort | tail -1 | cut -d ' ' -f 2)

if [ -z "$LATEST_BACKUP" ]; then
    echo "ALERT: No backup found in $BACKUP_DIR!" >&2
    exit 1
fi

# Calculate the age of the latest backup
BACKUP_AGE=$(( ( $(date +%s) - $(date +%s -r "$LATEST_BACKUP") ) / 86400 ))

# Alert if the latest backup is older than the threshold
if [ "$BACKUP_AGE" -gt "$ALERT_THRESHOLD" ]; then
    echo "ALERT: Latest backup in $BACKUP_DIR is $BACKUP_AGE days old, exceeding the threshold of $ALERT_THRESHOLD days."
else
    echo "Backup is recent (within $ALERT_THRESHOLD days)."
fi