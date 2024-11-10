-- List idle connections, ordered by duration
SELECT pid,
       usename              AS user,
       datname              AS database,
       client_addr,
       backend_start,
       state,
       NOW() - state_change AS idle_duration
    FROM pg_stat_activity
    WHERE state = 'idle'
    ORDER BY idle_duration DESC;