#!/bin/bash

# This script terminates idle and long-running transactions in PostgreSQL (version 9.2 and later).
# It logs information about each terminated transaction in JSON format for easy parsing.

# REQUIRED: Set the location of the log file where killed transactions will be recorded.
LOGFILE=/var/log/postgresql/kill_idle.log

# REQUIRED: Set the time limit for idle transactions (in minutes).
# Any transaction idle for longer than this time will be terminated.
IDLETIME=15

# REQUIRED: Set the time limit for long-running, non-idle transactions (in minutes).
# Set a high value (e.g., 1000) if you don't want these transactions to be terminated.
XACTTIME=120

# REQUIRED: Define users to be ignored from idle transaction termination.
# This usually includes the PostgreSQL superuser (e.g., postgres) and the user running backups (e.g., pg_dump).
# If no users need to be ignored, set both to 'XXXXX'.
SUPERUSER=postgres
BACKUPUSER=XXXXX

# REQUIRED: Specify the path to the psql executable, as cron jobs often lack search paths.
PSQL=/usr/lib/postgresql/9.3/bin/psql

# OPTIONAL: PostgreSQL connection variables. If running as the postgres user with local passwordless login, these can be left blank.
PGHOST=
PGUSER=
PGPORT=
PGPASSWORD=

# Export PostgreSQL connection variables for the psql command.
export PGHOST
export PGUSER
export PGPORT
export PGPASSWORD

# Redirect stdout and stderr to the log file for logging
exec >> $LOGFILE 2>&1

# Define an array with the safe users that should not have their transactions terminated
SAFELIST="ARRAY['${SUPERUSER}', '${BACKUPUSER}']"
# Set the idle and transaction time limits as parameters for use in the SQL query
IDLEPARAM="'${IDLETIME} minutes'"
XACTPARAM="'${XACTTIME} minutes'"

# Define the SQL query to identify and terminate idle and long-running transactions
KILLQUERY="WITH idles AS (
    -- Select idle and long-running transactions that match the time criteria and are not initiated by safe users
    SELECT now() as run_at, datname, pid, usename, application_name,
        client_addr, backend_start, xact_start, state_change,
        waiting, regexp_replace(substr(query, 1, 100), E$$[\n\r]+$$, ' ', 'g' ) as query,
        pg_terminate_backend(pid) -- Terminate the transaction
    FROM pg_stat_activity
    WHERE state = 'idle in transaction' -- Select only transactions that are idle in transaction
        AND usename != '${SUPERUSER}' -- Exclude transactions from the superuser
        AND usename != '${BACKUPUSER}' -- Exclude transactions from the backup user
        AND ( ( now() - xact_start ) > '${XACTTIME} minutes' -- Check if transaction exceeds XACTTIME
            OR ( now() - state_change ) > '${IDLETIME} minutes' ) -- Check if transaction exceeds IDLETIME
) 
-- Format output as JSON for easy parsing, providing details of terminated transactions
SELECT row_to_json(idles.*)
FROM idles
ORDER BY xact_start;"

# Execute the query using psql, which will terminate matching transactions and log the output to the log file
$PSQL -q -t -c "${KILLQUERY}"

# Exit the script
exit 0