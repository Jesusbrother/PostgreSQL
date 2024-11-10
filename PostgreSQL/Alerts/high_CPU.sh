#!/bin/bash

# Log file to store CPU usage alerts
LOGFILE="/var/log/postgresql/cpu_alert.log"

# CPU usage threshold for alert
THRESHOLD=80

# Check PostgreSQL processes for high CPU usage
echo "$(date +'%Y-%m-%d %H:%M:%S') - Checking CPU usage" >> "$LOGFILE"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | grep '[p]ostgres' | while read -r pid ppid cmd cpu; do
    if (( $(echo "$cpu > $THRESHOLD" | bc -l) )); then
        echo "ALERT: PostgreSQL process $pid using high CPU: $cpu%" >> "$LOGFILE"
    fi
done