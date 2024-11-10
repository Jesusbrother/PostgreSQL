-- Check lock conflicts
SELECT pg_locks.pid,
       locktype,
       relation::REGCLASS      AS locked_relation,
       mode,
       granted,
       query_start,
       AGE(NOW(), query_start) AS query_duration,
       state,
       LEFT(query, 100)        AS query_sample
    FROM pg_locks
    JOIN
        pg_stat_activity
            ON pg_locks.pid = pg_stat_activity.pid
    WHERE NOT granted
    ORDER BY query_duration DESC;