-- Monitor active connections per database
SELECT datname  AS database_name,
       COUNT(*) AS active_connections
    FROM pg_stat_activity
    WHERE state = 'active'
    GROUP BY datname
    ORDER BY active_connections DESC;