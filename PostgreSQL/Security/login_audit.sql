-- Monitor active sessions and IP addresses
SELECT pid,
       usename       AS user_name,
       client_addr   AS ip_address,
       application_name,
       backend_start AS session_start_time,
       state
    FROM pg_stat_activity
    WHERE state = 'active'
    ORDER BY backend_start DESC;