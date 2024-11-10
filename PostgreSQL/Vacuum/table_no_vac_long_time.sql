-- find tables that not vacuumed for a long time
SELECT schemaname,
       relname                                       AS table_name,
       last_vacuum,
       last_autovacuum,
       PG_SIZE_PRETTY(PG_TOTAL_RELATION_SIZE(relid)) AS table_size
    FROM pg_stat_user_tables
    WHERE last_vacuum IS NULL
       OR last_autovacuum IS NULL
       OR last_vacuum < NOW() - INTERVAL '7 days'
       OR last_autovacuum < NOW() - INTERVAL '7 days'
    ORDER BY table_size DESC;