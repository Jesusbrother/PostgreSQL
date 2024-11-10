#!/bin/bash

# Log connection pool usage with pgBouncer
PGUSER="pgbouncer"
PGDATABASE="pgbouncer"
PGPORT=6543
LOGFILE="/var/log/pgbouncer/pool_usage.log"

# Execute the query and log pool usage
psql -U $PGUSER -d $PGDATABASE -p $PGPORT -c "SHOW POOLS;" | tee -a $LOGFILE