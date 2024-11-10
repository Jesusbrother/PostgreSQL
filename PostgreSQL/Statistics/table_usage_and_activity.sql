-- Monitor table usage and activity
SELECT schemaname,
       relname                                       AS table_name,
       seq_scan                                      AS sequential_scans,
       idx_scan                                      AS index_scans,
       n_tup_ins                                     AS inserts,
       n_tup_upd                                     AS updates,
       n_tup_del                                     AS deletes,
       PG_SIZE_PRETTY(PG_TOTAL_RELATION_SIZE(relid)) AS table_size
    FROM pg_stat_user_tables
    ORDER BY table_size DESC
    LIMIT 10;