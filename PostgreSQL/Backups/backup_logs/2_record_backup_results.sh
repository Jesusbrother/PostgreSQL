#!/bin/bash

# Perform the backup and log the status
BACKUP_DIR="/var/lib/postgresql/backups/$(date +%Y%m%d)"
STATUS="Success"
DETAILS="Backup completed successfully."

pg_basebackup -D "$BACKUP_DIR" -Ft -z -P -U postgres -h localhost || {
    STATUS="Failure"
    DETAILS="Backup failed."
}

# Log status to PostgreSQL
psql -U postgres -d mydatabase -c \
    "INSERT INTO backup_log (status, details) VALUES ('$STATUS', '$DETAILS');"