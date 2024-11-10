-- Monitor estimated data transfer rates for queries (requires pg_stat_statements)
SELECT queryid,
       calls,
       ROUND(total_exec_time::INT / 1000, 2)                                                          AS total_exec_time_sec,
       PG_SIZE_PRETTY((shared_blks_read + local_blks_read) *
                      CURRENT_SETTING('block_size')::INT)                                        AS estimated_bytes_received,
       PG_SIZE_PRETTY((shared_blks_written + local_blks_written + temp_blks_written) *
                      CURRENT_SETTING('block_size')::INT)                                        AS estimated_bytes_written,
       LEFT(query, 100)                                                                          AS query_sample -- First 100 characters of the query
    FROM pg_stat_statements
    ORDER BY estimated_bytes_written DESC
    LIMIT 10;