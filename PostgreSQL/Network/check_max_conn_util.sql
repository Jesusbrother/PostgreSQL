-- Monitor maximum connection utilization
WITH
    connection_info AS (SELECT COUNT(*)     AS current_connections,
                               setting::INT AS max_connections
                            FROM pg_stat_activity,
                                 pg_settings
                            WHERE name = 'max_connections'
                            GROUP BY setting::INT)
SELECT current_connections,
       max_connections,
       ROUND((current_connections::NUMERIC / max_connections) * 100, 2) AS connection_usage_pct
    FROM connection_info;