-- Identify columns with a high percentage of NULL values
SELECT table_schema,
       table_name,
       column_name,
       COUNT(*) FILTER (WHERE column_name IS NULL)                      AS null_count,
       COUNT(*)                                                         AS total_count,
       (COUNT(*) FILTER (WHERE column_name IS NULL) * 100.0 / COUNT(*)) AS null_percentage
    FROM information_schema.columns AS cols
    JOIN
        pg_class                    AS c
            ON c.relname = cols.table_name
    WHERE column_name IS NULL
    GROUP BY table_schema, table_name, column_name
    HAVING (COUNT(*) FILTER (WHERE column_name IS NULL) * 100.0 / COUNT(*)) > 50;