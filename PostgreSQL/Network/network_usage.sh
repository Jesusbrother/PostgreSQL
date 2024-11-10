#!/bin/bash

# Log file for network usage
LOGFILE="/var/log/postgresql/network_usage.log"

# Monitor network usage every minute
while true; do
    echo "$(date +'%Y-%m-%d %H:%M:%S') - PostgreSQL Network Usage" >> "$LOGFILE"
    sudo iftop -t -s 1 -L 10 -P port 5432 >> "$LOGFILE"  # Logs top connections on PostgreSQL port
    sleep 60 # Log every minute
done