-- find tables that not analized for a long time
SELECT schemaname,
       relname                                       AS table_name,
       last_analyze,
       last_autoanalyze,
       PG_SIZE_PRETTY(PG_TOTAL_RELATION_SIZE(relid)) AS table_size
    FROM pg_stat_user_tables
    WHERE last_analyze IS NULL
       OR last_autoanalyze IS NULL
       OR last_analyze < NOW() - INTERVAL '7 days'
       OR last_autoanalyze < NOW() - INTERVAL '7 days'
    ORDER BY table_size DESC;