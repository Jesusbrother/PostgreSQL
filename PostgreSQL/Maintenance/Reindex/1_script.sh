#!/bin/bash

# Log file for reindexing
LOGFILE="/var/log/postgresql/reindex.log"

# Run reindexing
echo "$(date +'%Y-%m-%d %H:%M:%S') - Running REINDEX" >> "$LOGFILE"
psql -U postgres -d your_database -c "REINDEX DATABASE your_database;" >> "$LOGFILE"