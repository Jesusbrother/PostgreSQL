-- Monitor replication lag
SELECT application_name,
       client_addr,
       state,
       PG_SIZE_PRETTY(pg_wal_lsn_diff(pg_current_wal_lsn(), replay_lsn)) AS replication_lag,
       sync_state
    FROM pg_stat_replication;