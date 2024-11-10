-- Monitor WAL directory size
SELECT 
    pg_size_pretty(pg_total_relation_size('pg_wal')) AS wal_directory_size;