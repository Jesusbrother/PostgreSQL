-- Monitor checkpoint activity
SELECT checkpoints_timed,
       checkpoints_req,
       ROUND(checkpoint_write_time::INT / 1000, 2) AS checkpoint_write_time_sec,
       ROUND(checkpoint_sync_time::INT / 1000, 2)  AS checkpoint_sync_time_sec
    FROM pg_stat_bgwriter;