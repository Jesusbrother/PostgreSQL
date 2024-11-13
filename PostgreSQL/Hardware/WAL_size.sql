-- step 1: Get stat before, note it
SELECT 
    pg_current_wal_lsn() AS start_lsn,
    (xact_commit + xact_rollback) AS start_transactions
FROM 
    pg_stat_database
WHERE 
    datname = 'your_database_name';

-- step 2: wait for some time (e.g. 1 hour) and repeat:
SELECT
    pg_current_wal_lsn() AS end_lsn,
    (xact_commit + xact_rollback) AS end_transactions
FROM
    pg_stat_database
WHERE
    datname = 'your_database_name';

-- step 3: calculate avg WAL size via formula:
SELECT
    (pg_size_bytes(pg_lsn_diff('end_lsn', 'start_lsn')) / NULLIF(('end_transactions' - 'start_transactions'), 0)) AS avg_wal_per_txn_bytes;


-- This query estimates the WAL (Write-Ahead Log) size based on the number of transactions per second
-- and the average WAL record size per transaction.
WITH
    wal_estimation AS (SELECT 100 AS transactions_per_sec, -- Number of transactions per second
                              10  AS avg_wal_size_kb -- Average WAL size per transaction in KB
    )
SELECT transactions_per_sec,
       avg_wal_size_kb,

       -- Estimate WAL size per second, hour, and day
       (transactions_per_sec * avg_wal_size_kb)                       AS wal_per_sec_kb,

       -- Convert WAL size to MB per hour
       (transactions_per_sec * avg_wal_size_kb * 3600) / 1024         AS wal_per_hour_mb,

       -- Convert WAL size to GB per day
       (transactions_per_sec * avg_wal_size_kb * 86400) / 1024 / 1024 AS wal_per_day_gb
    FROM wal_estimation;