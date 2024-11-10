#!/bin/bash

# Log PostgreSQL connections resource usage (CPU, memory) every minute
LOGFILE="/var/log/postgresql/connection_resources.log"

while true; do
    echo "$(date +'%Y-%m-%d %H:%M:%S')" >> $LOGFILE
    ps -eo pid,pcpu,pmem,cmd | grep "[p]ostgres" >> $LOGFILE
    sleep 60 # Run every minute
done