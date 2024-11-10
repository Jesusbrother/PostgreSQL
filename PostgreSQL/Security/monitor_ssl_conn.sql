SHOW ssl;
-- Verify SSL usage by active connections
SELECT pg_stat_activity.pid,
       usename       AS user_name,
       client_addr   AS ip_address,
       ssl,
       backend_start AS session_start_time
    FROM pg_stat_ssl
    JOIN
        pg_stat_activity
            ON pg_stat_ssl.pid = pg_stat_activity.pid
    WHERE ssl = TRUE;