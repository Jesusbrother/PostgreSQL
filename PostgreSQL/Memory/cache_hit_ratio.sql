-- Monitor cache hit ratio
SELECT (blks_hit * 100 / NULLIF(blks_hit + blks_read, 0)) AS cache_hit_ratio
    FROM pg_stat_database
    WHERE datname = 'your_database';