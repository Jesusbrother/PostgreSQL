-- Identify tables with an excessive number of indexes
SELECT t.schemaname        AS schema_name,
       t.relname           AS table_name,
       COUNT(i.indexrelid) AS index_count
    FROM pg_stat_user_tables t
    JOIN
        pg_index             i
            ON t.relid = i.indrelid
    GROUP BY t.schemaname, t.relname
    HAVING COUNT(i.indexrelid) > 5 -- Adjust threshold as needed
    ORDER BY index_count DESC;