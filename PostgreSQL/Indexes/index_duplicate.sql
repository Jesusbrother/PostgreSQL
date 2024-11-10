-- Find duplicate indexes to remove redundancy and optimize index usage
WITH
    index_columns_order AS (SELECT attrelid, attnum, attname
                           FROM pg_attribute
                           JOIN pg_index
                                   ON indexrelid = attrelid
                           WHERE indkey[0] > 0
                           ORDER BY attrelid, attnum),
    index_columns_list AS (SELECT attrelid,
                              ARRAY_AGG(attname) AS cols
                           FROM index_columns_order
                           GROUP BY attrelid),
    duplicat_natts      AS (SELECT indrelid, indexrelid
                           FROM pg_index AS ind
                           WHERE EXISTS (SELECT 1
                                             FROM pg_index AS ind2
                                             WHERE ind.indrelid = ind2.indrelid
                                               AND (ind.indkey @> ind2.indkey
                                                 OR ind.indkey <@ ind2.indkey)
                                               AND ind.indkey[0] = ind2.indkey[0]
                                               AND ind.indkey <> ind2.indkey
                                               AND ind.indexrelid <> ind2.indexrelid))
SELECT userdex.schemaname          AS schema_name,
       userdex.relname             AS table_name,
       userdex.indexrelname        AS index_name,
       ARRAY_TO_STRING(cols, ', ') AS index_cols,
       indexdef,
       idx_scan                    AS index_scans
    FROM pg_stat_user_indexes AS userdex
    JOIN index_columns_list
            ON index_columns_list.attrelid = userdex.indexrelid
    JOIN duplicat_natts
            ON userdex.indexrelid = duplicat_natts.indexrelid
    JOIN pg_indexes
            ON userdex.schemaname = pg_indexes.schemaname
            AND userdex.indexrelname = pg_indexes.indexname
    ORDER BY userdex.schemaname, userdex.relname, cols, userdex.indexrelname;