-- Monitor active connections with client IP addresses
SELECT pid,
       usename                                                    AS user,
       datname                                                    AS database,
       client_addr                                                AS client_ip,
       backend_start                                              AS connection_start_time,
       state,
       ROUND(EXTRACT(EPOCH FROM (NOW() - backend_start)) / 60, 2) AS connection_duration_minutes,
       LEFT(query, 100)                                           AS query_sample -- First 100 characters of the query
    FROM pg_stat_activity
    WHERE state = 'active'
    ORDER BY connection_duration_minutes DESC;