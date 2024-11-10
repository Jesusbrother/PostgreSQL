-- Find columns with high uniqueness, but without a unique constraint or index
SELECT table_schema,
       table_name,
       column_name,
       COUNT(DISTINCT column_name) AS distinct_count,
       COUNT(*)                    AS total_count,
       CASE
           WHEN COUNT(DISTINCT column_name) = COUNT(*) THEN 'Potentially Unique'
           ELSE 'Not Unique'
           END                     AS uniqueness
    FROM information_schema.columns AS cols
    JOIN
        pg_class                    AS c
            ON c.relname = cols.table_name
    GROUP BY table_schema, table_name, column_name
    HAVING COUNT(DISTINCT column_name) > (0.95 * COUNT(*));