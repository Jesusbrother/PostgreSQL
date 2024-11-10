-- Find tables with a large number of rows
SELECT schemaname AS schema_name,
       relname    AS table_name,
       n_live_tup AS row_count
    FROM pg_stat_user_tables
    WHERE n_live_tup > 1000000 -- Adjust the threshold as needed
    ORDER BY n_live_tup DESC;