-- Track top 10 resource-intensive queries (requires pg_stat_statements)
SELECT queryid,
       calls,
       ROUND(total_exec_time::INT / 1000, 2) AS total_exec_time_sec,
       ROUND(mean_exec_time::INT, 2)         AS avg_exec_time_ms,
       rows,
       shared_blks_hit                       AS cache_hits,
       shared_blks_read                      AS disk_reads,
       LEFT(query, 100)                      AS query_sample
    FROM pg_stat_statements
    ORDER BY total_exec_time_sec DESC
    LIMIT 10;