-- Check for basic activity and statistics on tables
SELECT schemaname,
       relname                                       AS table_name,
       seq_scan                                      AS sequential_scans, -- Sequential scans count
       idx_scan                                      AS index_scans,      -- Index scans count
       PG_SIZE_PRETTY(PG_TOTAL_RELATION_SIZE(relid)) AS table_size        -- Table size
    FROM pg_stat_user_tables
    ORDER BY table_size DESC
    LIMIT 10; -- Display the top 10 largest tables