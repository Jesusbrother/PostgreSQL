#!/bin/bash

# Define backup directory and file name
BACKUP_DIR="/var/lib/postgresql/backups"
BACKUP_FILE="$BACKUP_DIR/$(date +%Y%m%d)_backup.sql"

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR"

# Perform the backup
pg_dump -U postgres your_database > "$BACKUP_FILE"

# Log backup completion
echo "Backup completed: $BACKUP_FILE"