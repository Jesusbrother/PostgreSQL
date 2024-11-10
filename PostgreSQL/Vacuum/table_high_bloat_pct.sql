-- find tables with high bloat pct
CREATE EXTENSION IF NOT EXISTS pgstattuple;
WITH
    table_bloat AS (SELECT pg_namespace.nspname                                 AS schemaname,
                           pg_class.relname                                     AS tablename,
                           pg_class.relpages::BIGINT                            AS pages,
                           ROUND(
                                   CASE
                                       WHEN pgstattuple.table_len > 0
                                           THEN (pgstattuple.dead_tuple_len::NUMERIC / pgstattuple.table_len) * 100
                                       ELSE 0
                                       END, 2
                           )                                                    AS bloat_pct,
                           PG_SIZE_PRETTY(PG_TOTAL_RELATION_SIZE(pg_class.oid)) AS table_size
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
SELECT schemaname,
       tablename,
       table_size,
       bloat_pct
    FROM table_bloat
    WHERE bloat_pct > 20 -- Threshold for bloat
    ORDER BY bloat_pct DESC;