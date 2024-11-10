-- Check for index bloat to decide when to rebuild indexes for better performance
-- Perform ANALYZE on your table
-- high dead_tup_ratio = high bloat
-- prefer to use pgstattuple extension
SELECT schemaname,
       relname,
       PG_SIZE_PRETTY(PG_RELATION_SIZE(schemaname || '.' || relname))          AS size,
       n_live_tup,
       n_dead_tup,
       CASE
           WHEN n_live_tup > 0 THEN ROUND((n_dead_tup::FLOAT /
                                           n_live_tup::FLOAT)::NUMERIC, 4) END AS dead_tup_ratio,
       last_autovacuum,
       last_autoanalyze
    FROM pg_stat_user_tables
    ORDER BY dead_tup_ratio DESC NULLS LAST;