#!/bin/bash

# Log file to store maintenance output
LOGFILE="/var/log/postgresql/vacuum_analyze.log"

# Run vacuum and analyze
echo "$(date +'%Y-%m-%d %H:%M:%S') - Running VACUUM and ANALYZE" >> "$LOGFILE"
psql -U postgres -d your_database -c "VACUUM (VERBOSE, ANALYZE);" >> "$LOGFILE"