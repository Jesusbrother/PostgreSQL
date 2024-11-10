-- Monitor current and maximum connections
SELECT COUNT(*)                                       AS current_connections,
       max_conn                                       AS max_connections,
       ROUND((COUNT(*)::NUMERIC / max_conn) * 100, 2) AS connection_usage_pct
    FROM pg_stat_activity,
         (SELECT setting::INT AS max_conn
              FROM pg_settings
              WHERE name = 'max_connections') AS max_connections
GROUP BY max_connections.max_conn;