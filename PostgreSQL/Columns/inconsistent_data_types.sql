-- Identify columns that could have a more appropriate data type
SELECT
    table_schema,
    table_name,
    column_name,
    data_type,
    CASE
        WHEN data_type = 'text' AND column_name ~ '^[0-9]+$' THEN 'Consider changing to INTEGER'
        WHEN data_type = 'text' AND column_name ~ '^[0-9]+.[0-9]+$' THEN 'Consider changing to NUMERIC'
        ELSE 'No change needed'
    END AS suggestion
FROM
    information_schema.columns
WHERE
    table_schema NOT IN ('pg_catalog')
    AND data_type = 'text';