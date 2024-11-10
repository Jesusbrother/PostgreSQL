-- Analyze index sizes to monitor storage usage by each index
SELECT i.relname                                     AS table_name,
       indexrelname                                  AS index_name,
       PG_SIZE_PRETTY(PG_TOTAL_RELATION_SIZE(relid)) AS total_size,
       PG_SIZE_PRETTY(PG_INDEXES_SIZE(relid))        AS total_size_of_all_indexes,
       PG_SIZE_PRETTY(PG_RELATION_SIZE(relid))       AS table_size,
       PG_SIZE_PRETTY(PG_RELATION_SIZE(indexrelid))  AS index_size,
       reltuples::BIGINT                             AS estimated_table_row_count
    FROM pg_stat_all_indexes i
    JOIN pg_class            c
            ON i.relid = c.oid
    WHERE i.relname = 'name';