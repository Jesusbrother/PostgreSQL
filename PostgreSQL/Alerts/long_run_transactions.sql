-- Alert for queries running longer than a specified duration (e.g., 5 minutes)
SELECT pid,
       NOW() - query_start AS duration,
       usename             AS user,
       datname             AS database,
       application_name,
       client_addr,
       state,
       LEFT(query, 100)    AS query_sample -- First 100 characters of the query
    FROM pg_stat_activity
    WHERE state = 'active'
      AND NOW() - query_start > INTERVAL '5 minutes' -- Threshold for alert
    ORDER BY duration DESC;