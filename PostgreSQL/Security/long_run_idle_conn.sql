-- Identify long-running idle connections
SELECT pid,
       usename                                                    AS user_name,
       client_addr                                                AS ip_address,
       state,
       backend_start                                              AS session_start_time,
       ROUND(EXTRACT(EPOCH FROM (NOW() - backend_start)) / 60, 2) AS idle_duration_minutes
    FROM pg_stat_activity
    WHERE state = 'idle'
      AND (NOW() - backend_start) > INTERVAL '10 minutes'
    ORDER BY idle_duration_minutes DESC;