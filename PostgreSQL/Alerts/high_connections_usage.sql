-- Alert if active connections exceed 80% of max_connections
WITH
    connection_info AS (SELECT COUNT(*)                                                              AS current_connections,
                               (SELECT setting::INT FROM pg_settings WHERE name = 'max_connections') AS max_connections
                            FROM pg_stat_activity)
SELECT current_connections,
       max_connections,
       ROUND((current_connections::NUMERIC / max_connections) * 100, 2) AS connection_usage_pct
    FROM connection_info
    WHERE (current_connections::NUMERIC / max_connections) * 100 > 80; -- Alert if over 80% of max_connections