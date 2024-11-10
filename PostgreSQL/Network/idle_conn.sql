-- Identify idle connections with duration
SELECT pid,
       usename                                                   AS user,
       datname                                                   AS database,
       client_addr                                               AS client_ip,
       state,
       ROUND(EXTRACT(EPOCH FROM (NOW() - state_change)) / 60, 2) AS idle_duration_minutes
    FROM pg_stat_activity
    WHERE state = 'idle'
    ORDER BY idle_duration_minutes DESC;