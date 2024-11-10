-- Monitor disk usage by tables and indexes
SELECT s.schemaname,
       s.relname                                               AS object_name,
       CASE WHEN c.relkind = 'i' THEN 'Index' ELSE 'Table' END AS object_type,
       PG_SIZE_PRETTY(PG_TOTAL_RELATION_SIZE(s.relid))         AS total_size
    FROM pg_catalog.pg_statio_user_tables AS s
    JOIN
        pg_catalog.pg_class               AS c
            ON s.relid = c.oid
    ORDER BY PG_TOTAL_RELATION_SIZE(s.relid) DESC
    LIMIT 10;