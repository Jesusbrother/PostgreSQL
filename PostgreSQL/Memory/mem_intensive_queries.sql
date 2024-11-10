-- Identify memory-intensive queries based on block usage
SELECT
    queryid,
    calls,
    ROUND(total_exec_time::INT / 1000, 2) AS total_exec_time_sec,
    shared_blks_hit + shared_blks_read AS total_shared_blocks,
    temp_blks_written AS temp_blocks_written,
    pg_size_pretty(temp_blks_written * current_setting('block_size')::int) AS temp_blocks_size
FROM
    pg_stat_statements
WHERE
    temp_blks_written > 0
ORDER BY
    temp_blks_written DESC
LIMIT 10;