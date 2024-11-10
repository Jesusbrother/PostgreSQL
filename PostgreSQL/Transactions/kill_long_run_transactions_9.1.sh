#!/bin/bash

# This script terminates idle and long-running transactions in PostgreSQL.
# It logs information about each terminated transaction to a specified log file.

# REQUIRED: Set the location of the log file for logging killed transactions
LOGFILE=/var/log/postgresql/kill_idle.log

# REQUIRED: Set the time limit for idle transactions (in minutes).
# Transactions idle longer than this will be terminated.
IDLETIME=15

# REQUIRED: Set the time limit for long-running, non-idle transactions (in minutes).
# Set to a large value (e.g., 1000) if you don't want these terminated.
XACTTIME=120

# REQUIRED: Define users to be excluded from idle transaction termination.
# Generally, omit the superuser (e.g., postgres) and the user running backups (e.g., pg_dump).
# If there are no such users, set both to XXXXX as a placeholder.
SUPERUSER=postgres
BACKUPUSER=XXXXX

# REQUIRED: Path to the psql executable, as cron jobs often lack search paths.
PSQL=/usr/lib/postgresql/9.1/bin/psql

# OPTIONAL: Set PostgreSQL connection variables if needed. 
# If running as the postgres user on the local machine without password, leave these empty.
PGHOST=
PGUSER=
PGPORT=
PGPASSWORD=

# Export connection variables for psql
export PGHOST
export PGUSER
export PGPORT
export PGPASSWORD

# Redirect standard output and error to the log file
exec >> $LOGFILE 2>&1

# Define safe users to ignore in an array format for PostgreSQL query
SAFELIST="ARRAY['${SUPERUSER}', '${BACKUPUSER}']"
IDLEPARAM="'${IDLETIME} minutes'"
XACTPARAM="'${XACTTIME} minutes'"

# Define the SQL query to terminate idle and long-running transactions
KILLQUERY="WITH idles AS (
    SELECT datname, procpid, usename, application_name,
        client_addr, backend_start, xact_start, query_start,
        waiting, pg_terminate_backend(procpid)
    FROM pg_stat_activity
    WHERE current_query = '<IDLE> in transaction'
        AND usename != '${SUPERUSER}'
        AND usename != '${BACKUPUSER}'
        AND ( ( now() - xact_start ) > '${XACTTIME} minutes'
            OR ( now() - query_start ) > '${IDLETIME} minutes' )
)
SELECT array_to_string(ARRAY[ now()::TEXT,
                idles.datname::TEXT, idles.procpid::TEXT, idles.usename::TEXT,
                idles.application_name, idles.client_addr::TEXT,
                idles.backend_start::TEXT, idles.xact_start::TEXT,
                idles.query_start::TEXT, idles.waiting::TEXT], '|')
FROM idles
ORDER BY xact_start;"

# Execute the query and log terminated transactions
$PSQL -q -t -c "${KILLQUERY}"

exit 0