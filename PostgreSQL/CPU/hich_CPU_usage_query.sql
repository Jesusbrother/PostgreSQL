-- Identify high CPU usage queries in PostgreSQL
SELECT pid,
       usename                                                  AS user,
       datname                                                  AS database,
       application_name,
       client_addr,
       backend_start,
       state,
       ROUND(EXTRACT(EPOCH FROM (NOW() - query_start)) / 60, 2) AS query_duration_minutes,
       LEFT(query, 100)                                         AS query_sample -- First 100 characters of the query
    FROM pg_stat_activity
    WHERE state = 'active'
      AND NOW() - query_start > INTERVAL '1 minute' -- Only queries running for over 1 minute
    ORDER BY query_duration_minutes DESC
    LIMIT 10;