#!/bin/bash

# Define backup parameters
BACKUP_DIR="/var/lib/postgresql/backups/$(date +%Y%m%d)"
LOGFILE="/var/log/postgresql/backup_log.log"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Perform the base backup
pg_basebackup -D "$BACKUP_DIR" -Ft -z -P -U postgres -h localhost >> "$LOGFILE" 2>&1

# Check if the backup completed successfully
if [ $? -eq 0 ]; then
    echo "$(date) - Backup completed successfully." >> "$LOGFILE"
else
    echo "$(date) - Backup failed!" >> "$LOGFILE"
    exit 1
fi