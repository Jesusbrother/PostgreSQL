-- Monitor WAL generation rate
SELECT
    pg_current_wal_lsn() AS current_wal_lsn,   -- Current WAL Log Sequence Number
    pg_wal_lsn_diff(pg_current_wal_lsn(), '0/00000000') / (1024 * 1024) AS wal_bytes_generated_mb
;