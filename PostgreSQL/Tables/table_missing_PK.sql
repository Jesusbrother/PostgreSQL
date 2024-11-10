-- Find tables without a primary key
SELECT schemaname AS schema_name,
       relname    AS table_name
    FROM pg_stat_user_tables t
    WHERE NOT EXISTS (SELECT 1
                          FROM pg_index i
                          WHERE i.indrelid = t.relid
                            AND i.indisprimary = TRUE);