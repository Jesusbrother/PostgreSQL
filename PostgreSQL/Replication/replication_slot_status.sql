-- Monitor replication slot status
SELECT slot_name,
       slot_type,
       active,
       PG_SIZE_PRETTY(pg_wal_lsn_diff(pg_current_wal_lsn(), restart_lsn)) AS wal_retention_size,
       restart_lsn,
       confirmed_flush_lsn
    FROM pg_replication_slots;