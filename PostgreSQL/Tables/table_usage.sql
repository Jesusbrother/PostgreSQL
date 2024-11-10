-- Analyze table usage patterns
SELECT schemaname AS schema_name,
       relname    AS table_name,
       seq_scan   AS sequential_scans,
       idx_scan   AS index_scans,
       n_tup_ins  AS inserts,
       n_tup_upd  AS updates,
       n_tup_del  AS deletes
    FROM pg_stat_user_tables
    ORDER BY seq_scan + idx_scan DESC;