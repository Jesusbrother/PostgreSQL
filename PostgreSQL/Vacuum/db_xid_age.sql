-- identifies databases that are at risk of reaching transaction ID wraparound
WITH datage AS (
    -- Retrieves database names along with their transaction ID age and approximate size in GB.
    SELECT
        datname,
        age(datfrozenxid) AS xid_age,
        round(pg_database_size(oid) / (128 * 1024::numeric), 1) AS gb_size
    FROM
        pg_database
    WHERE
        datname NOT IN ('rdsadmin') -- Excludes the 'rdsadmin' database (used in AWS RDS) due to lack of permissions.
),
av_max_age AS (
    -- Fetches the maximum age setting for autovacuum, which triggers freezing of old transactions.
    SELECT
        setting::numeric AS max_age
    FROM
        pg_settings
    WHERE
        name = 'autovacuum_freeze_max_age'
),
wrap_pct AS (
    -- Calculates the percentage of transaction ID age relative to the autovacuum freeze max age and the wraparound limit.
    SELECT
        datname,
        xid_age,
        round(xid_age * 100::numeric / max_age, 1) AS av_wrap_pct, -- % to autovacuum threshold
        round(xid_age * 100::numeric / 2200000000, 1) AS shutdown_pct, -- % to transaction ID wraparound
        gb_size
    FROM
        datage
    CROSS JOIN
        av_max_age
)
SELECT
    wrap_pct.*
FROM
    wrap_pct
-- Filters for databases approaching autovacuum threshold or wraparound limit, prioritizing larger databases
WHERE
    ((av_wrap_pct >= 75 OR shutdown_pct > 50 AND gb_size > 1))
    OR (av_wrap_pct > 100 OR shutdown_pct > 80)
ORDER BY
    xid_age DESC;