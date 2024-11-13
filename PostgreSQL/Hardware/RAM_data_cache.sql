-- This query estimates the required memory (RAM) for data caching based on read operations,
-- cache hit ratio, and average row size in PostgreSQL.
WITH
    cache_estimation AS (SELECT 500  AS read_ops_per_sec, -- Expected read operations per second
                                0.1  AS hit_ratio,        -- Target cache hit ratio (e.g., 10%)
                                8192 AS page_size_bytes,  -- Page size in bytes (default in PostgreSQL is 8 KB)
                                100  AS row_size_bytes -- Average size of a single row in bytes
    )
SELECT read_ops_per_sec,
       hit_ratio,
       page_size_bytes,
       row_size_bytes,

       -- Calculate required cache in bytes to maintain the desired cache hit ratio
       (read_ops_per_sec * row_size_bytes * hit_ratio)                              AS required_cache_bytes,

       -- Convert to MB and GB for easier analysis
       CEIL((read_ops_per_sec * row_size_bytes * hit_ratio) / 1024.0 / 1024)        AS required_cache_mb,
       CEIL((read_ops_per_sec * row_size_bytes * hit_ratio) / 1024.0 / 1024 / 1024) AS required_cache_gb
    FROM cache_estimation;
