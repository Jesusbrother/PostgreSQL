-- Check database-wide usage of temporary files
SELECT
    datname AS database_name,
    temp_files AS temporary_files,
    temp_bytes AS temporary_bytes,
    temp_bytes / 1024 / 1024 AS temp_mb
FROM
    pg_stat_database
WHERE
    temp_files > 0
ORDER BY
    temp_files DESC;