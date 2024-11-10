#!/bin/bash

# Alert if PostgreSQL process exceeds 80% CPU or 75% Memory
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | grep 'postgres' | awk '$4 > 75 || $5 > 80 {print "ALERT: High CPU/Memory on PID", $1, "Memory:", $4"%", "CPU:", $5"%"}'