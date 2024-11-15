-- Show last vacuum or autovacuum by table size descending.
SELECT pg_class.relname
        ,
       pg_namespace.nspname
        ,
       PG_SIZE_PRETTY(PG_TOTAL_RELATION_SIZE(pg_class.oid))
        ,
       CASE
           WHEN COALESCE(last_vacuum, '1/1/1000') >
                COALESCE(last_autovacuum, '1/1/1000') THEN
               pg_stat_all_tables.last_vacuum
           ELSE last_autovacuum
           END AS last_vacuumed
        ,
       PG_RELATION_SIZE(pg_class.oid)
    FROM pg_class
    JOIN pg_namespace
            ON pg_class.relnamespace = pg_namespace.oid
    JOIN pg_stat_all_tables
            ON (
            pg_class.relname = pg_stat_all_tables.relname
                AND pg_namespace.nspname = pg_stat_all_tables.schemaname
            )
    WHERE pg_namespace.nspname NOT IN ('pg_toast')
    ORDER BY PG_RELATION_SIZE(pg_class.oid) DESC
;