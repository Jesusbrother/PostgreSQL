#!/bin/bash

# Define log file and threshold for I/O in kB/s
LOGFILE="/var/log/postgresql/io_alert.log"
READ_THRESHOLD=50000  # Example threshold in kB/s
WRITE_THRESHOLD=50000 # Example threshold in kB/s

echo "$(date +'%Y-%m-%d %H:%M:%S') - Checking disk I/O usage" >> "$LOGFILE"

# Check PostgreSQL processes for high disk I/O using iostat
iostat -dx | grep 'postgres' | while read -r device tps read_kbps write_kbps; do
    if (( $(echo "$read_kbps > $READ_THRESHOLD" | bc -l) )); then
        echo "ALERT: High read I/O on $device: $read_kbps kB/s" >> "$LOGFILE"
    fi
    if (( $(echo "$write_kbps > $WRITE_THRESHOLD" | bc -l) )); then
        echo "ALERT: High write I/O on $device: $write_kbps kB/s" >> "$LOGFILE"
    fi
done