-- identifies large tables nearing transaction ID wraparound or autovacuum thresholds
WITH
    relage     AS (
        -- Retrieves each table's name, transaction ID age, and estimated size in MB.
        SELECT relname,
               AGE(relfrozenxid)                   AS xid_age,
               ROUND((relpages / 128::NUMERIC), 1) AS mb_size
            FROM pg_class
            WHERE relkind IN ('r', 't') -- Includes only regular tables ('r') and TOAST tables ('t').
    ),
    av_max_age AS (
        -- Fetches the autovacuum freeze max age setting, which defines when PostgreSQL should freeze transaction IDs.
        SELECT setting::NUMERIC AS max_age
            FROM pg_settings
            WHERE name = 'autovacuum_freeze_max_age'),
    wrap_pct   AS (
        -- Calculates the percentage of transaction ID age relative to the autovacuum threshold and the wraparound limit.
        SELECT relname,
               xid_age,
               ROUND(xid_age * 100::NUMERIC / max_age, 1)    AS av_wrap_pct,  -- % to autovacuum threshold
               ROUND(xid_age * 100::NUMERIC / 2200000000, 1) AS shutdown_pct, -- % to transaction ID wraparound
               mb_size
            FROM relage
            CROSS JOIN
                av_max_age)
SELECT wrap_pct.*,
       pgsa.pid
    FROM wrap_pct
    LEFT OUTER JOIN
        pg_stat_activity pgsa
            ON (pgsa.query ILIKE '%autovacuum%' AND pgsa.query ILIKE '%' || relname || '%')
-- Filters for tables approaching autovacuum or wraparound limits, focusing on large tables
    WHERE ((av_wrap_pct >= 75 OR shutdown_pct >= 50) AND mb_size > 1000)
       OR (av_wrap_pct > 100 OR shutdown_pct > 80)
    ORDER BY xid_age DESC;