-- Check for databases nearing transaction ID wraparound threshold
WITH datage AS (
    SELECT
        datname,
        age(datfrozenxid) AS xid_age,
        round(pg_database_size(oid)/(1024*1024)::NUMERIC, 1) AS db_size_mb
    FROM
        pg_database
),
max_age AS (
    SELECT setting::NUMERIC AS max_age
    FROM pg_settings
    WHERE name = 'autovacuum_freeze_max_age'
)
SELECT
    datage.datname AS database_name,
    datage.xid_age AS transaction_age,
    max_age.max_age AS autovacuum_threshold,
    round((xid_age / max_age) * 100, 2) AS age_pct_to_wraparound,
    db_size_mb AS database_size_mb
FROM
    datage, max_age
WHERE
    (xid_age / max_age) * 100 > 80  -- Alert if 80% of threshold is reached
ORDER BY
    age_pct_to_wraparound DESC;