-- Identify long-running queries
SELECT pid,
       usename                                                  AS user_name,
       datname                                                  AS database_name,
       state,
       query_start,
       ROUND(EXTRACT(EPOCH FROM (NOW() - query_start)) / 60, 2) AS duration_minutes,
       LEFT(query, 100)                                         AS query_sample
    FROM pg_stat_activity
    WHERE state = 'active'
      AND (NOW() - query_start) > INTERVAL '5 minutes'
    ORDER BY duration_minutes DESC;