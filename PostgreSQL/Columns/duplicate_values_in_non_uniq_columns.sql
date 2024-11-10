-- Identify columns with high levels of duplicate values
SELECT table_schema,
       table_name,
       column_name,
       COUNT(*)                                                      AS total_count,
       COUNT(DISTINCT column_name)                                   AS distinct_count,
       COUNT(*) - COUNT(DISTINCT column_name)                        AS duplicate_count,
       ((COUNT(*) - COUNT(DISTINCT column_name)) * 100.0 / COUNT(*)) AS duplicate_percentage
    FROM information_schema.columns
    JOIN
        pg_class
            ON pg_class.relname = information_schema.columns.table_name
    GROUP BY table_schema, table_name, column_name
    HAVING ((COUNT(*) - COUNT(DISTINCT column_name)) * 100.0 / COUNT(*)) > 20; -- Threshold for high duplication