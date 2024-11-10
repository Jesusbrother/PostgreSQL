-- Monitor and alert if any user is nearing connection limit
SELECT usename                                                     AS user_name,
       COUNT(*)                                                    AS user_connections,
       max_conn.setting::INT                                       AS max_connections,
       ROUND((COUNT(*)::NUMERIC / max_conn.setting::INT) * 100, 2) AS usage_pct
    FROM pg_stat_activity,
         LATERAL (
             SELECT setting
                 FROM pg_settings
                 WHERE name = 'max_connections'
             ) AS max_conn
    GROUP BY usename, max_conn.setting
    HAVING (COUNT(*)::NUMERIC / max_conn.setting::INT) * 100 > 80 -- Alert if over 80% of max_connections per user
    ORDER BY usage_pct DESC;