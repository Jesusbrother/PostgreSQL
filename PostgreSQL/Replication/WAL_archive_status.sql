-- Monitor WAL archiving status
SELECT archived_count AS archived_wal_files,
       failed_count   AS failed_wal_archives,
       last_archived_wal,
       last_archived_time
    FROM pg_stat_archiver;