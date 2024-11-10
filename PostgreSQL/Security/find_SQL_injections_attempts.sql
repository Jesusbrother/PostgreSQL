-- Monitor for suspicious query patterns (requires pg_stat_statements)
SELECT queryid,
       calls,
       ROUND(total_exec_time::INT / 1000, 2) AS total_exec_time_sec,
       LEFT(query, 100)                      AS query_sample
    FROM pg_stat_statements
    WHERE query ~* '(--|;|DROP|ALTER|UNION|SELECT.*FROM.*information_schema)' -- Example pattern
    ORDER BY total_exec_time_sec DESC
    LIMIT 10;