-- Count connections by client IP address
SELECT client_addr AS client_ip,
       COUNT(*)    AS connection_count
    FROM pg_stat_activity
    GROUP BY client_addr
    ORDER BY connection_count DESC
    LIMIT 10;