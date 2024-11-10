CREATE EXTENSION IF NOT EXISTS pgstattuple;

-- Alert for tables with bloat exceeding a threshold (e.g., 20%)
WITH
    table_bloat AS (SELECT pg_namespace.nspname                                                          AS schema_name,
                           pg_class.relname                                                              AS table_name,
                           pg_class.relpages::BIGINT                                                     AS pages,
                           pgstattuple.table_len                                                         AS total_size,
                           pgstattuple.dead_tuple_len                                                    AS dead_size,
                           ROUND((pgstattuple.dead_tuple_len::NUMERIC / pgstattuple.table_len) * 100, 2) AS bloat_pct
                        FROM pg_class
                        JOIN
                            pg_namespace
                                ON pg_namespace.oid = pg_class.relnamespace
                        JOIN
                            LATERAL pgstattuple(pg_class.oid) AS pgstattuple
                                ON TRUE
                        WHERE pg_namespace.nspname = 'public'
                          AND pg_class.relkind = 'r' -- Regular tables
    )
SELECT schema_name,
       table_name,
       PG_SIZE_PRETTY(total_size) AS table_size,
       bloat_pct
    FROM table_bloat
    WHERE bloat_pct > 20 -- Alert if bloat exceeds 20%
    ORDER BY bloat_pct DESC;