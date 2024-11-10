-- Identify WAL-heavy queries (requires pg_stat_statements)
SELECT queryid,
       calls,
       shared_blks_written,
       temp_blks_written,
       PG_SIZE_PRETTY((shared_blks_written + temp_blks_written) *
                      CURRENT_SETTING('block_size')::INT) AS estimated_wal_written,
       LEFT(query, 100)                                   AS query_sample -- First 100 characters of the query
    FROM pg_stat_statements
    ORDER BY estimated_wal_written DESC
    LIMIT 10;