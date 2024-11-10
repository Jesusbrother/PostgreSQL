-- Identify unused indexes
SELECT schemaname,
       relname      AS table_name,
       indexrelname AS index_name,
       idx_scan     AS index_scans
    FROM pg_stat_user_indexes
    WHERE idx_scan = 0
    ORDER BY table_name;