-- Monitor replication performance metrics
SELECT application_name AS standby_name,
       client_addr      AS standby_ip,
       write_lag,
       flush_lag,
       replay_lag,
       sync_state,
       backend_start    AS replication_start_time
    FROM pg_stat_replication
    ORDER BY write_lag, flush_lag, replay_lag;