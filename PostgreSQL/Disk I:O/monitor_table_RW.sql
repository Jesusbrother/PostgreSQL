-- Monitor table read/write activity
SELECT schemaname,
       relname                                       AS table_name,
       seq_scan                                      AS sequential_scans,
       seq_tup_read                                  AS sequential_rows_read,
       idx_scan                                      AS index_scans,
       idx_tup_fetch                                 AS index_rows_fetched,
       n_tup_ins                                     AS inserts,
       n_tup_upd                                     AS updates,
       n_tup_del                                     AS deletes,
       PG_SIZE_PRETTY(PG_TOTAL_RELATION_SIZE(relid)) AS table_size
    FROM pg_stat_user_tables
    ORDER BY (seq_tup_read + idx_tup_fetch) DESC
    LIMIT 10; -- Show top 10 tables by read activity