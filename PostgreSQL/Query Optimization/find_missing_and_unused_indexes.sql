-- Identify tables with high sequential scans (potential missing indexes)
SELECT schemaname,
       relname                                       AS table_name,
       seq_scan                                      AS sequential_scans,
       idx_scan                                      AS index_scans,
       n_tup_ins                                     AS inserts,
       n_tup_upd                                     AS updates,
       n_tup_del                                     AS deletes,
       PG_SIZE_PRETTY(PG_TOTAL_RELATION_SIZE(relid)) AS table_size
    FROM pg_stat_user_tables
    WHERE seq_scan > 1000 -- Threshold for sequential scans
      AND idx_scan = 0
    ORDER BY sequential_scans DESC;

-- Identify unused indexes
SELECT schemaname,
       relname      AS table_name,
       indexrelname AS index_name,
       idx_scan     AS index_scans
    FROM pg_stat_user_indexes
    WHERE idx_scan = 0
    ORDER BY table_name;