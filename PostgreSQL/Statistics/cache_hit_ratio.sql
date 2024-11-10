-- Monitor cache hit ratio
SELECT datname                                            AS database_name,
       blks_hit * 100.0 / NULLIF(blks_hit + blks_read, 0) AS cache_hit_ratio
    FROM pg_stat_database
    WHERE datname = 'your_database';