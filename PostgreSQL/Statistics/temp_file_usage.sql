-- Monitor temporary file usage by database
SELECT datname                    AS database_name,
       temp_files                 AS temp_file_count,
       PG_SIZE_PRETTY(temp_bytes) AS temp_file_size
    FROM pg_stat_database
    ORDER BY temp_bytes DESC;