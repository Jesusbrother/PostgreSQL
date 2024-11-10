-- Check replication lag on standby server
SELECT PG_SIZE_PRETTY(pg_wal_lsn_diff(pg_last_wal_receive_lsn(), pg_last_wal_replay_lsn())) AS replication_lag,
       pg_last_wal_receive_lsn()                                                            AS last_received_lsn,
       pg_last_wal_replay_lsn()                                                             AS last_replayed_lsn,
       CASE
           WHEN pg_last_wal_receive_lsn() = pg_last_wal_replay_lsn() THEN 'No lag'
           ELSE 'Lagging'
           END                                                                              AS lag_status;