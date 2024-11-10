#!/bin/bash

# Database connection details
DB_NAME="your_database"          # Replace with your database name
DB_USER="postgres"               # Replace with your database user
LOGFILE="/var/log/postgresql/bloat_check.log" # Log file for bloat results

# Check if pgstattuple extension is enabled
psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT extname FROM pg_extension WHERE extname = 'pgstattuple';" | grep -q "pgstattuple"
if [ $? -ne 0 ]; then
    echo "ERROR: The pgstattuple extension is not installed or enabled in database $DB_NAME." >> "$LOGFILE"
    exit 1
fi

# Write the header for the bloat report
echo "Table Bloat Report for Database: $DB_NAME" > "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"
echo "Schema | Table | Table Size | Dead Tuples Size | Bloat %" >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"

# Loop through each table in the public schema and check bloat
psql -U "$DB_USER" -d "$DB_NAME" -t -c "
SELECT schemaname, tablename 
FROM pg_tables 
WHERE schemaname = 'public';
" | while read -r schema table; do
    if [ -n "$table" ]; then
        # Run pgstattuple for each table and format the output
        psql -U "$DB_USER" -d "$DB_NAME" -c "
        SELECT
            '$schema' AS schema,
            '$table' AS table,
            pg_size_pretty(table_len) AS table_size,
            pg_size_pretty(dead_tuple_len) AS dead_tuple_size,
            ROUND((dead_tuple_len::NUMERIC / table_len) * 100, 2) AS bloat_pct
        FROM pgstattuple('$schema.$table')
        WHERE dead_tuple_len > 0;
        " >> "$LOGFILE"
    fi
done

echo "Bloat check completed. Results saved in $LOGFILE."