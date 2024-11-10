-- Check replication status on the primary server
SELECT application_name                                                  AS standby_name,
       client_addr                                                       AS standby_ip,
       state,
       sync_state,
       PG_SIZE_PRETTY(pg_wal_lsn_diff(pg_current_wal_lsn(), replay_lsn)) AS replication_lag,
       pg_current_wal_lsn()                                              AS primary_wal_lsn,
       replay_lsn                                                        AS standby_replay_lsn,
       write_lag,
       flush_lag,
       replay_lag
    FROM pg_stat_replication;